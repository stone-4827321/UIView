//
//  ViewController.m
//  Hit-Testing
//
//  Created by stone on 2020/11/18.
//

#import "ViewController.h"
#import "STView.h"
#import "STView1.h"
#import "STView2.h"
#import "STButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self extendScope];
    //[self gestureRecognizer];
    [self controlButton];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"touchesBegan %@", self);
}

- (void)testHitTesting {
    STView *A = [[STView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    A.backgroundColor = [UIColor redColor];
    A.tag = 1;
    [self.view addSubview:A];
    
    STView *A1 = [[STView alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    A1.backgroundColor = [UIColor orangeColor];
    A1.tag = 11;
    [A addSubview:A1];
    
    STView *A2 = [[STView alloc] initWithFrame:CGRectMake(10, 50, 80, 30)];
    A2.backgroundColor = [UIColor orangeColor];
    A2.tag = 12;
    [A addSubview:A2];
    
    
    STView *B = [[STView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
    B.backgroundColor = [UIColor blueColor];
    B.alpha = 0.5;
    B.tag = 2;
    [self.view addSubview:B];
    
    STView *B1 = [[STView alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    B1.backgroundColor = [UIColor purpleColor];
    B1.tag = 21;
    [B addSubview:B1];
    
    STView *B2 = [[STView alloc] initWithFrame:CGRectMake(10, 50, 80, 30)];
    B2.backgroundColor = [UIColor purpleColor];
    B2.tag = 22;
    [B addSubview:B2];
    
    STView *C = [[STView alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    C.backgroundColor = [UIColor yellowColor];
    C.tag = 3;
    [self.view addSubview:C];
    
    STView *C1 = [[STView alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
    C1.backgroundColor = [UIColor purpleColor];
    C1.tag = 31;
    [C addSubview:C1];
    
    STView *C2 = [[STView alloc] initWithFrame:CGRectMake(10, 50, 80, 30)];
    C2.backgroundColor = [UIColor purpleColor];
    C2.tag = 32;
    [C addSubview:C2];
}

// 扩大点击范围
- (void)extendScope {
    STView1 *view = [[STView1 alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
}

- (void)gestureRecognizer {
    STView2 *view = [[STView2 alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 2;
    //tap.cancelsTouchesInView = NO;
    //tap.delaysTouchesBegan = YES;
    //tap.delaysTouchesEnded = YES;
    [view addGestureRecognizer:tap];
}
- (void)tap:(id)sender {
    NSLog(@"tap");
}

- (void)controlButton {
    STButton *button = [STButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"1" forState:UIControlStateNormal];
    [button setTitle:@"2" forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"!!!%lu", (unsigned long)button.state);

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    //[button addGestureRecognizer:tap];
}
- (void)click:(UIButton *)button {
    NSLog(@"click !!!%lu", (unsigned long)button.state);
    NSLog(@"click");
}


@end
