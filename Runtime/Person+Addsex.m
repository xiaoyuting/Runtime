//
//  Person+Addsex.m
//  Runtime
//
//  Created by 雨停 on 2017/9/18.
//  Copyright © 2017年 Video. All rights reserved.
//

#import "Person+Addsex.h"
#import <objc/runtime.h>
@implementation Person (Addsex)
static const int  psex;
static const int  psoccer;
-(void)setSex:(NSString *)sex{
    objc_setAssociatedObject(self , &psex, sex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void)setSoccer:(int)soccer{
    NSString * a = [NSString stringWithFormat:@"%d",soccer];
    objc_setAssociatedObject(self , &psoccer, a , OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (NSString*)sex{
    return objc_getAssociatedObject(self , &psex);
}

- (int )soccer{
    return [objc_getAssociatedObject(self , &psoccer) intValue];
}
@end

