//
//  STLayer.m
//  UpdateCycle
//
//  Created by stone on 2020/11/18.
//

#import "STLayer.h"

@implementation STLayer

//- (void)display {
//    NSLog(@"CALayer display");
//}

- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"CALayer drawInContext");
}

- (void)setNeedsDisplay {
    NSLog(@"CALayer setNeedsDisplay");
    [super setNeedsDisplay];
}

- (void)displayIfNeeded {
    NSLog(@"CALayer displayIfNeeded");
    [super displayIfNeeded];
}

@end
