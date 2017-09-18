//
//  Person.m
//  Runtime
//
//  Created by 雨停 on 2017/9/18.
//  Copyright © 2017年 Video. All rights reserved.
//

#import "Person.h"
@interface Person()
@property (nonatomic,copy) NSString *address;
@end
@implementation Person
//公共方法
- (void)publicMethod {
    NSLog(@"对外暴露的方法 %@",self.address);
}
//私有方法
- (void)privateMethod {
    NSLog(@"私有方法%@",self.name);
}
- (NSString *)description {
    return [NSString stringWithFormat:@" %@,  %@",self.address,self.name];
}

@end
