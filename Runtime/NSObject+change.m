//
//  NSObject+change.m
//  Runtime
//
//  Created by GM on 2018/3/19.
//  Copyright © 2018年 Video. All rights reserved.
//

#import "NSObject+change.h"
#import <objc/runtime.h>
@implementation NSObject (change)
const char * kproperlist = "properlistKey";
+ (NSArray *)list{
    NSArray * ptyList = objc_getAssociatedObject(self , kproperlist);
    if(ptyList){
        return ptyList;
    }
    /* 调用运行时方法, 取得类的属性列表 */
    /* 成员变量:
     * class_copyIvarList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 方法:
     * class_copyMethodList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 属性:
     * class_copyPropertyList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 协议:
     * class_copyProtocolList(__unsafe_unretained Class cls, unsigned int *outCount)
     */
    
    unsigned  int outCount  = 0 ;
    /**
     * 参数1: 要获取得类
     * 参数2: 类属性的个数指针
     * 返回值: 所有属性的数组, C 语言中,数组的名字,就是指向第一个元素的地址
     */
    objc_property_t  * propertyList = class_copyPropertyList(self , &outCount);
    NSMutableArray * arr = [NSMutableArray array];
    for (unsigned int  i= 0; i<outCount; i++) {
        objc_property_t t = propertyList[i];
        const char * propertyName_C= property_getName(t);
        NSString   * propertyName_OC = [NSString stringWithCString:propertyName_C encoding:NSUTF8StringEncoding];
        [arr addObject:propertyName_OC];
    }
    /* 设置关联对象 */
    /**
     *  参数1 : 对象self
     *  参数2 : 动态添加属性的 key
     *  参数3 : 动态添加属性值
     *  参数4 : 对象的引用关系
     */
    
    objc_setAssociatedObject(self , kproperlist, arr.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    free(propertyList);
    return arr.copy;
    
}

+(instancetype)modelWithDicKey:(NSDictionary * )dic{
    id objc = [[ self alloc]init];
    NSArray * properList = [self list];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([properList  containsObject:key ]){
            [objc setValue:obj forKey:key];
        }
    }];
    
    return objc;
}

@end
