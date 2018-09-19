
# USAction
类似SpriteKit的SKAction，你可以在UIKit上使用USAction，用法同SpriteKit的SKAction

![](/src/drop.gif)

## 使用

### run
```swift
+ (instancetype)run:(void(^)(void))handler;
USAction *action = [USAction run:^{
    //do something
}];
```

### move
```swift
+ (instancetype)moveTo:(CGPoint)point duration:(NSTimeInterval)interval;
USAction *move = [USAction moveTo:CGPointZero duration:0.5];
```
### wait
```swift
+ (instancetype)wait:(NSTimeInterval)interval;
USAction *wait = [USAction wait:0.2];
```
### sequence
```swift
+ (instancetype)sequence:(NSArray<USAction *> *)actions;
 USAction *sequence = [USAction sequence:@[action1, action2, action3]];
```
### repeat
```swift
+ (instancetype)repeat:(USAction *)action count:(NSInteger)count;
USAction *repeat = [USAction repeat:sequence count:25];
```

### repeatForEver
```swift
+ (instancetype)repeatForEver:(USAction *)action;
USAction *repeat = [USAction repeatForEver:sequence];
```
### 嵌套示例
```swift
- (void)viewDidLoad {
    [super viewDidLoad];

    USAction *add = [USAction run:^{
        [self addNewNode];
    }];
    USAction *wait = [USAction wait:0.2];
    USAction *sequence = [USAction sequence:@[add, wait]];
    USAction *repeat = [USAction repeatForEver:sequence];
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
```

## 安装
```
pod repo update
pod 'USAction'
```
