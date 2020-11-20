//
//  STView.m
//  Hit-Testing
//
//  Created by stone on 2020/11/18.
//

#import "STView.h"

@implementation STView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"hitTest %@ %@", @(self.tag), @(view.tag));
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL flag = [super pointInside:point withEvent:event];
    NSLog(@"pointInside %@ %@", @(self.tag), @(flag));
    return flag;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"touchesBegan %@ %@", self, @(self.tag));
    
    //[super touchesBegan:touches withEvent:event];

//    UIResponder *re = [self nextResponder];
//    while (re) {
//        re = [re nextResponder];
//        NSLog(@"touchesBegan %@", re);
//    }
}
@end
