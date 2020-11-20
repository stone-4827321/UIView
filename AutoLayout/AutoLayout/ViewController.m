//
//  ViewController.m
//  NSLayoutAttribute
//
//  Created by stone on 2020/11/16.
//

#import "ViewController.h"
#import "STView.h"
#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#import "K3Masonry.h"
#import "STTableViewController.h"

@interface ViewController ()

@property (nonatomic, strong) STView *redView;

@property (nonatomic, strong) STView *blueView;

@property (nonatomic, strong) NSLayoutConstraint *layout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self testBase];
    //[self testVFL];
    //[self testMasonry];
    //[self testAnimate];
    //[self testEquivalentWidth];
    //[self testContentHuggingPriority];
    //[self testContentCompressionResistancePriority];
    //[self testUpdateConstraints];
    [self tabelView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self tabelView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    
    //[NSLayoutConstraint deactivateConstraints:@[self.layout]];
    //self.layout = [NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:300];
    //[NSLayoutConstraint activateConstraints:@[self.layout]];

    //self.layout.constant = 300;
    
    //[NSLayoutConstraint constraintWithItem:self.redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:150].active = YES;
    
    [self.redView removeFromSuperview];
    
    //[self.redView setNeedsUpdateConstraints];
    //[self.redView updateConstraintsIfNeeded];
}

- (void)test {
    STView *redView = [[STView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
    
    STView *blueView = [[STView alloc] init];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
}

// 基本使用
- (void)testBase {
    UIView *redView = [[UIView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    NSLayoutConstraint *left1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:100];
    NSLayoutConstraint *top1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    NSLayoutConstraint *width1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    NSLayoutConstraint *height1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];

    [self.view addConstraints:@[left1, top1]];
    [redView addConstraints:@[width1, height1]];
    
    [redView updateConstraints];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    NSLayoutConstraint *left2 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *right2 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *top2 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:100];
    NSLayoutConstraint *height2 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0];
    [NSLayoutConstraint activateConstraints:@[left2, right2]];
    top2.active = YES;
    height2.active = YES;

    //[self.view addConstraints:@[left2, right2, top2, height2]];
}

- (void)testMasonry {
    UIView *redView = [[UIView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [redView makeConstraints:^(K3MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.width.equalTo(100);
        make.height.equalTo(50);
        make.left.equalTo(self.view).offset(50);
    }];
}

- (void)testVFL {
    UIView *redView = [[UIView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    NSString *v = @"V:|-topMargin-[redView(50)]-20-[blueView(50.0)]";
    NSString *h1 = @"H:|-leftMargin-[redView(100)]";
    NSString *h2 = @"H:|-leftMargin-[blueView(50)]";
    NSArray *list1 = [NSLayoutConstraint constraintsWithVisualFormat:v options:0 metrics:@{@"topMargin":@100} views:NSDictionaryOfVariableBindings(redView, blueView)];
    NSArray *list2 = [NSLayoutConstraint constraintsWithVisualFormat:h1 options:0 metrics:@{@"leftMargin":@100} views:NSDictionaryOfVariableBindings(redView)];
    NSArray *list3 = [NSLayoutConstraint constraintsWithVisualFormat:h2 options:0 metrics:@{@"leftMargin":@50} views:NSDictionaryOfVariableBindings(blueView)];

    [self.view addConstraints:list1];
    [self.view addConstraints:list2];
    [self.view addConstraints:list3];
}

// 动画
- (void)testAnimate {
    STView *redView = [[STView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    NSLayoutConstraint *left1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:100];
    NSLayoutConstraint *top1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    NSLayoutConstraint *width1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    NSLayoutConstraint *height1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];

    [self.view addConstraints:@[left1, top1]];
    [redView addConstraints:@[width1, height1]];
    
    dispatch_after(2, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            //[self.view removeConstraint:top1];
            top1.active = NO;
            NSLayoutConstraint *top2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:400];
            //[self.view addConstraint:top2];
            top2.active = YES;
            
            [self.view layoutIfNeeded];
        }];
    });
}

- (void)testEquivalentWidth {
    UIView *redView = [[UIView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    NSLayoutConstraint *top1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    NSLayoutConstraint *height1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    top1.active = YES;
    height1.active = YES;
    NSLayoutConstraint *top2 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    NSLayoutConstraint *height2 = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:100];
    top2.active = YES;
    height2.active = YES;
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:20];
    left.active = YES;
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-20];
    right.active = YES;
    NSLayoutConstraint *middle = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeRight multiplier:1 constant:20];
    middle.active = YES;
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    width.active = YES;
    width.priority = UILayoutPriorityDefaultHigh;
    
    // 优先级
    NSLayoutConstraint *width1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:300];
    width1.active = YES;
    width1.priority = UILayoutPriorityDefaultLow;
}

- (void)testContentHuggingPriority {
    [self test];

    STView *redView = [[STView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    
    
    STView *blueView = [[STView alloc] init];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeRight multiplier:1 constant:100].active = YES;

    // 设置后则redView被拉伸，否则blueView被拉伸
    [blueView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)testContentCompressionResistancePriority {
    [self test];
    
    STView *redView = [[STView alloc] init];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    
    STView *blueView = [[STView alloc] init];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeRight multiplier:1 constant:300].active = YES;
    
    // 设置后则blueView被压缩，否则redView被压缩
    [redView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}


#pragma mark - UIConstraintBasedLayoutCoreMethods

- (void)testUpdateConstraints {
    STView *redView = [[STView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    self.redView = redView;

    NSLayoutConstraint *l1 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:100];
    l1.active = YES;
    NSLayoutConstraint *l2 = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:100];
    l2.active = YES;
    self.layout = l1;
}

- (void)tabelView {
    STTableViewController *vc = [[STTableViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
