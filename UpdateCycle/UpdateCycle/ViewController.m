//
//  ViewController.m
//  testUI
//
//  Created by stone on 2020/11/12.
//

#import "ViewController.h"
#import "STView.h"
#import "STLabel.h"
#import "STScrollView.h"


@interface ViewController ()

@property (nonatomic, strong) STView *myView;
@property (nonatomic, strong) STLabel *myLabel;

@end

@implementation ViewController

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //STView *view = [[STView alloc] init];
    //STView *view = [[STView alloc] initWithFrame:CGRectZero];
    STView *view = [[STView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor orangeColor];
    //view.alpha = 0.8;
    //view.frame = CGRectMake(1, 1, 1, 0);
    //[view layoutIfNeeded];

    [self.view addSubview:view];
    self.myView = view;
    
//    STLabel *label = [[STLabel alloc] initWithFrame:CGRectMake(10, 50, 448.5, 25)];
//    label.backgroundColor = [UIColor greenColor];
//    label.text = @"我们都有一个家啊，名字叫中国，家里攀着两条龙";
//    label.font = [UIFont systemFontOfSize:20];
//    label.textColor = [UIColor blackColor];
//    [self.view addSubview:label];
//    self.myLabel = label;
    
//    STScrollView *scrollView = [[STScrollView alloc] init];
//    scrollView.frame = self.view.frame;
//    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) * 2);
//    [self.view addSubview:scrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //[view layoutIfNeeded];
    });
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesBegan");
    [self.myView setNeedsDisplay];
    
    //[self testSetNeedsDisplay];
    //[self testDrawRect];
    //[self testSetNeedsLayout];
    //[self testLayoutIfNeeded];
}

- (void)testSetNeedsLayout {
    self.myView.frame = CGRectMake(100, 100, 100, 10);
    [self.myView layoutIfNeeded];
    
    //UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 10, 10)];
    //[self.myView addSubview:subView];

    //[self.myView setNeedsLayout];
}

- (void)testLayoutIfNeeded {
//    [self.myView setNeedsLayout];
//    [self.myView layoutIfNeeded];
}

- (void)testSetNeedsDisplay {
    self.myView.fillColor = [UIColor purpleColor];
    
    self.myView.backgroundColor = [UIColor greenColor];//触发setNeedsDisplay
    //self.myView.frame = CGRectMake(200, 100, 90, 100);//不触发setNeedsDisplay
    //self.myView.alpha = 0.5;//不触发setNeedsDisplay
    
    //[self.myView setNeedsDisplay];
    //[self.myView setNeedsDisplayInRect:CGRectMake(0, 0, 50, 50)];
    //[self.myView setNeedsLayout];
    
    //[self.myView.layer displayIfNeeded];
}

- (void)testDrawRect {
    self.myView.fillColor = [UIColor purpleColor];
    
    // 设置contentMode属性值为UIViewContentModeRedraw，设置或更改frame.size
    //self.myView.contentMode = UIViewContentModeRedraw;
    //self.myView.frame = CGRectMake(200, 100, 101, 100);
    
    // 调用sizeThatFits后，视图的frame.size发生改变
    //CGSize size = [self.myLabel sizeThatFits:CGSizeMake(1000, 1000)];
    //[self.myLabel sizeToFit];
    
    [self.myView sizeToFit];
}


@end
