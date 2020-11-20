//
//  STView.m
//  testUI
//
//  Created by stone on 2020/11/12.
//

#import "STView.h"
#import "STLayer.h"

@implementation STView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _fillColor = [UIColor redColor];
        self.layer.delegate = self;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _fillColor = [UIColor redColor];
    }
    return self;
}


+ (Class)layerClass {
    return [STLayer class];
}


//- (void)displayLayer:(CALayer *)layer {
//    NSLog(@"inContext displayLayer:");
//}
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    NSLog(@"CALayer drawLayer:inContext:");
//}

#pragma mark - UIConstraintBasedLayoutLayering


- (CGSize)intrinsicContentSize {
    NSLog(@"intrinsicContentSize");
    //CGSize size = [super intrinsicContentSize];
    return CGSizeMake(50, 100);
}


#pragma mark - UIConstraintBasedLayoutCoreMethods

- (void)setNeedsUpdateConstraints {
    NSLog(@"setNeedsUpdateConstraints");
    [super setNeedsUpdateConstraints];
}

- (void)updateConstraintsIfNeeded {
    NSLog(@"updateConstraintsIfNeeded");
    [super updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    NSLog(@"updateConstraints");
    [super updateConstraints];
}

- (BOOL)needsUpdateConstraints {
    NSLog(@"needsUpdateConstraints");
    //return NO;
    BOOL flag = [super needsUpdateConstraints];
    return YES;
}

- (BOOL)requiresConstraintBasedLayout {
    return YES;
}

#pragma mark - UIViewHierarchy

- (void)layoutSubviews {
    NSLog(@"layoutSubviews");
    [super layoutSubviews];
}

- (void)setNeedsLayout {
    NSLog(@"setNeedsLayout");
    [super setNeedsLayout];
}

- (void)layoutIfNeeded {
    NSLog(@"layoutIfNeeded");
    [super layoutIfNeeded];
}

#pragma mark - UIViewRendering

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect:");
    //使用UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    //填充颜色
    UIColor *fillColor = _fillColor;
    [fillColor set];
    [path fill];
}

//- (void)drawRect:(CGRect)rect {
//    NSLog(@"drawRect:");
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColor(context, CGColorGetComponents(_fillColor.CGColor));
//    CGContextFillRect(context, rect);
//}

- (void)setNeedsDisplay {
    NSLog(@"setNeedsDisplay");
    [super setNeedsDisplay];
}

- (void)setNeedsDisplayInRect:(CGRect)rect {
    [super setNeedsDisplayInRect:rect];
}

#pragma mark - UIViewGeometry

- (void)sizeToFit {
    NSLog(@"sizeToFit");
    [super sizeToFit];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(200, 200);
}

@end
