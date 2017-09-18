//
//  UIGestureRecognizer+Block.h
//  Runtime
//
//  Created by 雨停 on 2017/9/18.
//  Copyright © 2017年 Video. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GestureBlock)(id gestureRecognizer);
@interface UIGestureRecognizer (Block)
+ (instancetype)getureRecognizerWithActionBlock:(GestureBlock)block;


@end
