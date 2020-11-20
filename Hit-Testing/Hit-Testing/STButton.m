//
//  STButton.m
//  Hit-Testing
//
//  Created by stone on 2020/11/18.
//

#import "STButton.h"

@implementation STButton

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    NSLog(@"touchesBegan %@", self);
//    [super touchesBegan:touches withEvent:event];
//}
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    NSLog(@"touchesMoved %@", self);
//    [super touchesMoved:touches withEvent:event];
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    NSLog(@"touchesEnded %@", self);
//    [super touchesEnded:touches withEvent:event];
//}
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    NSLog(@"touchesCancelled %@", self);
//    [super touchesCancelled:touches withEvent:event];
//}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"beginTrackingWithTouch %@", @(self.state));
    [super setBackgroundColor:[UIColor blueColor]];
    return YES;
    //return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"continueTrackingWithTouch %@", @(self.state));
    return YES;
    //return [super continueTrackingWithTouch:touch withEvent:event];
}
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    NSLog(@"endTrackingWithTouch %@", @(self.state));
    [super setBackgroundColor:[UIColor redColor]];
    [self sendActionsForControlEvents:UIControlEventTouchDownRepeat];
    //[super endTrackingWithTouch:touch withEvent:event];
}
- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    NSLog(@"cancelTrackingWithEvent %@", @(self.state));
    //[super cancelTrackingWithEvent:event];
}

@end
