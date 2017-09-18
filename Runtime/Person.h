//
//  Person.h
//  Runtime
//
//  Created by 雨停 on 2017/9/18.
//  Copyright © 2017年 Video. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,assign)     int    age;
@property (nonatomic,copy)  NSString  * name;
//公共的
- (void)publicMethod;
@end
