//
//  USAction.h
//  USAction
//
//  Created by xgf on 2018/9/17.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface USAction : NSObject

@property(nonatomic, copy, readonly)NSDictionary *info;

+ (instancetype)run:(void(^)(void))handler;
+ (instancetype)moveTo:(CGPoint)point duration:(NSTimeInterval)interval;
+ (instancetype)sequence:(NSArray<USAction *> *)actions;
+ (instancetype)repeatForEver:(USAction *)action;
+ (instancetype)repeat:(USAction *)action count:(NSInteger)count;
+ (instancetype)wait:(NSTimeInterval)interval;


@end
