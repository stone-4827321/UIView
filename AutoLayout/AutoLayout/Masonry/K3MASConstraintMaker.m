//
//  MASConstraintMaker.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "K3MASConstraintMaker.h"
#import "K3MASViewConstraint.h"
#import "K3MASCompositeConstraint.h"
#import "K3MASConstraint+K3Private.h"
#import "K3MASViewAttribute.h"
#import "View+K3MASAdditions.h"

@interface K3MASConstraintMaker () <K3MASConstraintDelegate>

@property (nonatomic, weak) UIView *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation K3MASConstraintMaker

- (id)initWithView:(UIView *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [K3MASViewConstraint installedConstraintsForView:self.view];
        for (K3MASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (K3MASConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(K3MASConstraint *)constraint shouldBeReplacedWithConstraint:(K3MASConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (K3MASConstraint *)constraint:(K3MASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    K3MASViewAttribute *viewAttribute = [[K3MASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    K3MASViewConstraint *newConstraint = [[K3MASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:K3MASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        K3MASCompositeConstraint *compositeConstraint = [[K3MASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (K3MASConstraint *)addConstraintWithAttributes:(K3MASAttribute)attrs {
    __unused K3MASAttribute anyAttribute = (K3MASAttribute_Left | K3MASAttribute_Right | K3MASAttribute_Top | K3MASAttribute_Bottom | K3MASAttribute_Leading
                                          | K3MASAttribute_Trailing | K3MASAttribute_Width | K3MASAttribute_Height | K3MASAttribute_CenterX
                                          | K3MASAttribute_CenterY | K3MASAttribute_Baseline
                                          | K3MASAttribute_FirstBaseline | K3MASAttribute_LastBaseline
#if TARGET_OS_IPHONE || TARGET_OS_TV
                                          | K3MASAttribute_LeftMargin | K3MASAttribute_RightMargin | K3MASAttribute_TopMargin | K3MASAttribute_BottomMargin
                                          | K3MASAttribute_LeadingMargin | K3MASAttribute_TrailingMargin | K3MASAttribute_CenterXWithinMargins
                                          | K3MASAttribute_CenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & K3MASAttribute_Left) [attributes addObject:self.view.mas_left];
    if (attrs & K3MASAttribute_Right) [attributes addObject:self.view.mas_right];
    if (attrs & K3MASAttribute_Top) [attributes addObject:self.view.mas_top];
    if (attrs & K3MASAttribute_Bottom) [attributes addObject:self.view.mas_bottom];
    if (attrs & K3MASAttribute_Leading) [attributes addObject:self.view.mas_leading];
    if (attrs & K3MASAttribute_Trailing) [attributes addObject:self.view.mas_trailing];
    if (attrs & K3MASAttribute_Width) [attributes addObject:self.view.mas_width];
    if (attrs & K3MASAttribute_Height) [attributes addObject:self.view.mas_height];
    if (attrs & K3MASAttribute_CenterX) [attributes addObject:self.view.mas_centerX];
    if (attrs & K3MASAttribute_CenterY) [attributes addObject:self.view.mas_centerY];
    if (attrs & K3MASAttribute_Baseline) [attributes addObject:self.view.mas_baseline];
    if (attrs & K3MASAttribute_FirstBaseline) [attributes addObject:self.view.mas_firstBaseline];
    if (attrs & K3MASAttribute_LastBaseline) [attributes addObject:self.view.mas_lastBaseline];
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    if (attrs & K3MASAttribute_LeftMargin) [attributes addObject:self.view.mas_leftMargin];
    if (attrs & K3MASAttribute_RightMargin) [attributes addObject:self.view.mas_rightMargin];
    if (attrs & K3MASAttribute_TopMargin) [attributes addObject:self.view.mas_topMargin];
    if (attrs & K3MASAttribute_BottomMargin) [attributes addObject:self.view.mas_bottomMargin];
    if (attrs & K3MASAttribute_LeadingMargin) [attributes addObject:self.view.mas_leadingMargin];
    if (attrs & K3MASAttribute_TrailingMargin) [attributes addObject:self.view.mas_trailingMargin];
    if (attrs & K3MASAttribute_CenterXWithinMargins) [attributes addObject:self.view.mas_centerXWithinMargins];
    if (attrs & K3MASAttribute_CenterYWithinMargins) [attributes addObject:self.view.mas_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (K3MASViewAttribute *a in attributes) {
        [children addObject:[[K3MASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    K3MASCompositeConstraint *constraint = [[K3MASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (K3MASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (K3MASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (K3MASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (K3MASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (K3MASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (K3MASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (K3MASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (K3MASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (K3MASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (K3MASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (K3MASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (K3MASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (K3MASConstraint *(^)(K3MASAttribute))attributes {
    return ^(K3MASAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

- (K3MASConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (K3MASConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (K3MASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (K3MASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (K3MASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (K3MASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (K3MASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (K3MASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (K3MASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (K3MASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (K3MASConstraint *)edges {
    return [self addConstraintWithAttributes:K3MASAttribute_Top | K3MASAttribute_Left | K3MASAttribute_Right | K3MASAttribute_Bottom];
}

- (K3MASConstraint *)size {
    return [self addConstraintWithAttributes:K3MASAttribute_Width | K3MASAttribute_Height];
}

- (K3MASConstraint *)center {
    return [self addConstraintWithAttributes:K3MASAttribute_CenterX | K3MASAttribute_CenterY];
}

#pragma mark - grouping

- (K3MASConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        K3MASCompositeConstraint *constraint = [[K3MASCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
