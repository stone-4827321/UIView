//
//  MASConstraintMaker.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "K3MASConstraint.h"
#import "K3MASUtilities.h"

typedef NS_OPTIONS(NSInteger, K3MASAttribute) {
    K3MASAttribute_Left = 1 << NSLayoutAttributeLeft,
    K3MASAttribute_Right = 1 << NSLayoutAttributeRight,
    K3MASAttribute_Top = 1 << NSLayoutAttributeTop,
    K3MASAttribute_Bottom = 1 << NSLayoutAttributeBottom,
    K3MASAttribute_Leading = 1 << NSLayoutAttributeLeading,
    K3MASAttribute_Trailing = 1 << NSLayoutAttributeTrailing,
    K3MASAttribute_Width = 1 << NSLayoutAttributeWidth,
    K3MASAttribute_Height = 1 << NSLayoutAttributeHeight,
    K3MASAttribute_CenterX = 1 << NSLayoutAttributeCenterX,
    K3MASAttribute_CenterY = 1 << NSLayoutAttributeCenterY,
    K3MASAttribute_Baseline = 1 << NSLayoutAttributeBaseline,

    K3MASAttribute_FirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    K3MASAttribute_LastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    K3MASAttribute_LeftMargin = 1 << NSLayoutAttributeLeftMargin,
    K3MASAttribute_RightMargin = 1 << NSLayoutAttributeRightMargin,
    K3MASAttribute_TopMargin = 1 << NSLayoutAttributeTopMargin,
    K3MASAttribute_BottomMargin = 1 << NSLayoutAttributeBottomMargin,
    K3MASAttribute_LeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    K3MASAttribute_TrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    K3MASAttribute_CenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    K3MASAttribute_CenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating MASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface K3MASConstraintMaker : NSObject

/**
 *	The following properties return a new MASViewConstraint
 *  with the first item set to the makers associated view and the appropriate MASViewAttribute
 */
@property (nonatomic, strong, readonly) K3MASConstraint *left;
@property (nonatomic, strong, readonly) K3MASConstraint *top;
@property (nonatomic, strong, readonly) K3MASConstraint *right;
@property (nonatomic, strong, readonly) K3MASConstraint *bottom;
@property (nonatomic, strong, readonly) K3MASConstraint *leading;
@property (nonatomic, strong, readonly) K3MASConstraint *trailing;
@property (nonatomic, strong, readonly) K3MASConstraint *width;
@property (nonatomic, strong, readonly) K3MASConstraint *height;
@property (nonatomic, strong, readonly) K3MASConstraint *centerX;
@property (nonatomic, strong, readonly) K3MASConstraint *centerY;
@property (nonatomic, strong, readonly) K3MASConstraint *baseline;

@property (nonatomic, strong, readonly) K3MASConstraint *firstBaseline;
@property (nonatomic, strong, readonly) K3MASConstraint *lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) K3MASConstraint *leftMargin;
@property (nonatomic, strong, readonly) K3MASConstraint *rightMargin;
@property (nonatomic, strong, readonly) K3MASConstraint *topMargin;
@property (nonatomic, strong, readonly) K3MASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) K3MASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) K3MASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) K3MASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) K3MASConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new MASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  MASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) K3MASConstraint *(^attributes)(K3MASAttribute attrs);

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate MASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) K3MASConstraint *edges;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate MASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) K3MASConstraint *size;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate MASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) K3MASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any K3MASConstraint are created with this view as the first item
 *
 *	@return	a new MASConstraintMaker
 */
- (id)initWithView:(UIView *)view;

/**
 *	Calls install method on any MASConstraints which have been created by this maker
 *
 *	@return	an array of all the installed MASConstraints
 */
- (NSArray *)install;

- (K3MASConstraint * (^)(dispatch_block_t))group;

@end
