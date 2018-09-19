//
//  UIView+Action.m
//  USAction
//
//  Created by xgf on 2018/9/17.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "UIView+Action.h"

@implementation UIView (Action)

- (void)run:(USAction *)action {
    NSDictionary *info = action.info;
    [self runWithInfo:info completion:nil];
}

- (void)run:(USAction *)action completion:(void (^)(void))handler {
    NSDictionary *info = action.info;
    [self runWithInfo:info completion:handler];
}

- (void)runWithInfo:(NSDictionary *)info completion:(void(^)(void))completion {
    NSString *type = info[@"type"];
    if([type isEqualToString:@"handler"]) {
        void(^handler)(void) = info[@"target"];
        if(handler) {
            handler();
        }
        if(completion) {
            completion();
        }
    } else if([type isEqualToString:@"moveTo"]) {
        NSDictionary *target = info[@"target"];
        CGFloat x = [target[@"x"] floatValue];
        CGFloat y = [target[@"y"] floatValue];
        CGPoint point = CGPointMake(x, y);
        NSTimeInterval duration =  [info[@"duration"] floatValue];
        [UIView animateWithDuration:duration animations:^{
            self.center = point;
        } completion:^(BOOL finished) {
            if(completion) {
                completion();
            }
        }];
    } else if([type isEqualToString:@"sequence"]) {
        NSArray *infos = info[@"target"];
        if(infos.count == 0) {
            return;
        }
        [self runInfos:infos at:0 totalCompletion:completion];
    } else if([type isEqualToString:@"repeatForEver"]) {
        NSDictionary *dict = info[@"target"];
        [self runWithInfo:dict];
    } else if([type isEqualToString:@"repeat"]) {
        NSDictionary *dict = info[@"target"];
        NSInteger count = [info[@"count"] integerValue];
        [self run:dict total:count at:0 totalCompletion:completion];
    } else if([type isEqualToString:@"wait"]) {
        NSTimeInterval duration =  [info[@"duration"] floatValue];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(completion){
                completion();
            }
        });
    }
}

- (void)run:(NSDictionary *)info total:(NSInteger)count at:(NSInteger)times totalCompletion:(void(^)(void))completion {
    if(times >= count) {
        if(completion) {
            completion();
        }
        return;
    }
    __weak typeof(self) wkself = self;
    [self runWithInfo:info completion:^{
        [wkself run:info total:count at:times + 1 totalCompletion:completion];
    }];
}

- (void)runWithInfo:(NSDictionary *)info {
    __weak typeof(self) wkself = self;
    [self runWithInfo:info completion:^{
        [wkself runWithInfo:info];
    }];
}

- (void)runInfos:(NSArray *)infos at:(int)i totalCompletion:(void(^)(void))completion {
    if(i >= infos.count) {
        if(completion) {
            completion();
        }
        return;
    }
    __weak typeof(self) wkself = self;
    [self runWithInfo:infos[i] completion:^{
        [wkself runInfos:infos at:i+1 totalCompletion:completion];
    }];
}


@end

