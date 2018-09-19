//
//  ViewController.m
//  USAction
//
//  Created by xgf on 2018/9/17.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Action.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    USAction *add = [USAction run:^{
        [self addNewNode];
    }];
    USAction *wait = [USAction wait:0.2];
    USAction *sequence = [USAction sequence:@[add, wait]];
    USAction *repeat = [USAction repeatForEver:sequence];//[USAction repeat:sequence count:25];
    [self.view run:repeat];
}
- (void)addNewNode {
    UIView *node = [self dropNode];
    [self.view addSubview:node];
    USAction *move = [USAction moveTo:CGPointMake(arc4random_uniform((int)self.view.bounds.size.width) + 1, self.view.bounds.size.height + 40) duration:4 + (arc4random_uniform(100) + 1)/ 100.f];
    USAction *remove = [USAction run:^{
        [node removeFromSuperview];
    }];
    USAction *combine = [USAction sequence:@[move, remove]];
    [node run:combine];
}
- (UIView *)dropNode {
    UIImageView *node = [[UIImageView alloc] initWithFrame:CGRectMake(arc4random_uniform((int)self.view.bounds.size.width) + 1, -40, 40, 40)];
    node.image = [UIImage imageNamed:@"miss"];
    return node;
}

@end
