//
//  USAction.m
//  USAction
//
//  Created by xgf on 2018/9/17.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "USAction.h"

@implementation USAction

- (void)setInfo:(NSDictionary *)info {
    _info = info;
}

+ (instancetype)run:(void (^)(void))handler {
    USAction *action = [USAction new];
    NSDictionary *dict = @{@"type" : @"handler", @"target" : handler};
    action.info = dict;
    return action;
}

+ (instancetype)moveTo:(CGPoint)point duration:(NSTimeInterval)interval {
    USAction *action = [USAction new];
    NSDictionary *dict = @{@"type" : @"moveTo",
                           @"target" : @{@"x" : @(point.x), @"y" : @(point.y)} ,
                           @"duration" : @(interval)};
    action.info = dict;
    return action;
}

+ (instancetype)sequence:(NSArray<USAction *> *)actions {
    USAction *action = [USAction new];
    NSArray *infos = [actions valueForKey:@"info"];
    NSDictionary *dict = @{@"type" : @"sequence", @"target" : infos};
    action.info = dict;
    return action;
}

+ (instancetype)repeatForEver:(USAction *)action {
    USAction *ak = [USAction new];
    NSDictionary *dict = @{@"type" : @"repeatForEver", @"target" : action.info};
    ak.info = dict;
    return ak;
}

+ (instancetype)repeat:(USAction *)action count:(NSInteger)count {
    USAction *ak = [USAction new];
    NSDictionary *dict = @{@"type" : @"repeat",
                           @"target" : action.info,
                           @"count" : @(count)};
    ak.info = dict;
    return ak;
}

+ (instancetype)wait:(NSTimeInterval)interval {
    USAction *action = [USAction new];
    NSDictionary *dict = @{@"type" : @"wait", @"duration" : @(interval)};
    action.info = dict;
    return action;
}

@end
