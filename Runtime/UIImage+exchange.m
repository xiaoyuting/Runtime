//
//  UIImage+exchange.m
//  Runtime
//
//  Created by 雨停 on 2017/9/18.
//  Copyright © 2017年 Video. All rights reserved.
//

#import "UIImage+exchange.h"
#import <objc/runtime.h>
@implementation UIImage (exchange)
+(void)load{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        Class selfClass = object_getClass([self class]);
        SEL oriSEL  = @selector(imageNamed:);
        Method oriMethod  = class_getInstanceMethod(selfClass, oriSEL);
        
        SEL cusSEL =@selector(myImageNamed:);
        Method cusMethod  = class_getInstanceMethod(selfClass, cusSEL);
        
        BOOL addSucc  = class_addMethod(selfClass, oriSEL, method_getImplementation(cusMethod), method_getTypeEncoding(cusMethod));
        if(addSucc){
            class_replaceMethod(selfClass, cusSEL, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
        }else{
            method_exchangeImplementations(oriMethod, cusMethod);
        }
        
    });
    
}
+ (UIImage *)myImageNamed:(NSString *)name {
    
    NSString * newName = [NSString stringWithFormat:@"%@%@", @"new_", name];
    return [self myImageNamed:newName];
}

@end
