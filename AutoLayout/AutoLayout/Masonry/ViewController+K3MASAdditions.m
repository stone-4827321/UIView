//
//  UIViewController+MASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+K3MASAdditions.h"

@implementation UIViewController (K3MASAdditions)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

- (K3MASViewAttribute *)mas_topLayoutGuide {
    return [[K3MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (K3MASViewAttribute *)mas_topLayoutGuideTop {
    return [[K3MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (K3MASViewAttribute *)mas_topLayoutGuideBottom {
    return [[K3MASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (K3MASViewAttribute *)mas_bottomLayoutGuide {
    return [[K3MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (K3MASViewAttribute *)mas_bottomLayoutGuideTop {
    return [[K3MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (K3MASViewAttribute *)mas_bottomLayoutGuideBottom {
    return [[K3MASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

#pragma clang diagnostic pop

@end
