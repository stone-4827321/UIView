//
//  UIView+MASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+K3MASAdditions.h"
#import <objc/runtime.h>

@implementation UIView (K3MASAdditions)

- (NSArray *)mas_makeConstraints:(void(NS_NOESCAPE ^)(K3MASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    K3MASConstraintMaker *constraintMaker = [[K3MASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void(NS_NOESCAPE ^)(K3MASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    K3MASConstraintMaker *constraintMaker = [[K3MASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_remakeConstraints:(void(NS_NOESCAPE ^)(K3MASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    K3MASConstraintMaker *constraintMaker = [[K3MASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (K3MASViewAttribute *)mas_left {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (K3MASViewAttribute *)mas_top {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (K3MASViewAttribute *)mas_right {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (K3MASViewAttribute *)mas_bottom {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (K3MASViewAttribute *)mas_leading {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (K3MASViewAttribute *)mas_trailing {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (K3MASViewAttribute *)mas_width {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (K3MASViewAttribute *)mas_height {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (K3MASViewAttribute *)mas_centerX {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (K3MASViewAttribute *)mas_centerY {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (K3MASViewAttribute *)mas_baseline {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (K3MASViewAttribute *(^)(NSLayoutAttribute))mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

- (K3MASViewAttribute *)mas_firstBaseline {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (K3MASViewAttribute *)mas_lastBaseline {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (K3MASViewAttribute *)mas_leftMargin {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (K3MASViewAttribute *)mas_rightMargin {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (K3MASViewAttribute *)mas_topMargin {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (K3MASViewAttribute *)mas_bottomMargin {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (K3MASViewAttribute *)mas_leadingMargin {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (K3MASViewAttribute *)mas_trailingMargin {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (K3MASViewAttribute *)mas_centerXWithinMargins {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (K3MASViewAttribute *)mas_centerYWithinMargins {
    return [[K3MASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuide {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeNotAnAttribute];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideLeading {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeading];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideTrailing {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTrailing];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideLeft {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideRight {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideTop {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideBottom {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideWidth {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeWidth];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideHeight {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeHeight];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideCenterX {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeCenterX];
}

- (K3MASViewAttribute *)mas_safeAreaLayoutGuideCenterY {
    return [[K3MASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeCenterY];
}

#endif

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)mas_closestCommonSuperview:(UIView *)view {
    UIView *closestCommonSuperview = nil;

    UIView *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        UIView *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
