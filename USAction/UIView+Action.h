//
//  UIView+Action.h
//  USAction
//
//  Created by xgf on 2018/9/17.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USAction.h"

@interface UIView (Action)

- (void)run:(USAction *)action;
- (void)run:(USAction *)action completion:(void(^)(void))handler;

@end
