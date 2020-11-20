//
//  UIView+MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "K3MASUtilities.h"
#import "K3MASConstraintMaker.h"
#import "K3MASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating MASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface UIView (K3MASAdditions)

/**
 *	following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_trailing;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_centerY;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_baseline;
@property (nonatomic, strong, readonly) K3MASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);

@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_firstBaseline;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_lastBaseline;

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_leftMargin;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_rightMargin;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_topMargin;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_bottomMargin;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_leadingMargin;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_trailingMargin;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_centerYWithinMargins;

@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuide NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideLeading NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideTrailing NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideLeft NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideRight NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideTop NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideBottom NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideWidth NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideHeight NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideCenterX NS_AVAILABLE_IOS(11.0);
@property (nonatomic, strong, readonly) K3MASViewAttribute *mas_safeAreaLayoutGuideCenterY NS_AVAILABLE_IOS(11.0);

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id mas_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)mas_closestCommonSuperview:(UIView *)view;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void(NS_NOESCAPE ^)(K3MASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void(NS_NOESCAPE ^)(K3MASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void(NS_NOESCAPE ^)(K3MASConstraintMaker *make))block;

@end
