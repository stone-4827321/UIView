//
//  STView1.m
//  Hit-Testing
//
//  Created by stone on 2020/11/18.
//

#import "STView1.h"

@implementation STView1

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"touchesBegan %@", self);
}

#pragma mark -  方式一
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
//        return nil;
//    }
//    // 上下左右各扩大10
//    CGRect responseRect = CGRectInset(self.bounds, -10, -10);
//    if(CGRectContainsPoint(responseRect, point)) {
//        for (UIView *subView in [self.subviews reverseObjectEnumerator]) {
//            CGPoint childPoint = [self convertPoint:point toView:subView];
//            UIView *fitView = [subView hitTest:childPoint withEvent:event];
//            if (fitView) {
//                return fitView;
//            }
//        }
//        return self;
//    }
//    return nil;
//}

#pragma mark - 方式二

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = CGRectInset(self.bounds, -10, -10);
    return CGRectContainsPoint(bounds, point);
}


@end
