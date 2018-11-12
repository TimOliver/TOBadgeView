//
//  TOBadgeView.h
//  TOBadgeViewExample
//
//  Created by Tim Oliver on 8/11/18.
//  Copyright © 2018 Tim Oliver. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


NS_SWIFT_NAME(BadgeView)
IB_DESIGNABLE @interface TOBadgeView : UIView

/** The text displayed inside the badge. May be an int or text. */
@property (nonatomic, strong, nullable) IBInspectable NSString *text;

/** The font of the badge text. (Default is system bold 14) */
@property (nonatomic, strong, null_resettable) IBInspectable UIFont *font;

/** The color of the badge text. (Default is white) */
@property (nonatomic, strong, null_resettable) IBInspectable UIColor *textColor;

/** The tint color of the badge image behind the text (Default is red) */
@property (nonatomic, strong, null_resettable) IBInspectable UIColor *badgeColor;

/** Vertically and horizontally, the amount of padding between the text and the edge of the view
 Default is {3, 2}
 */
@property (nonatomic, assign) CGSize textInsets;

/** If YES, the badge is rendered in Core Graphics as a flat bitmap.
    Changing `backgroundColor` to a solid alpha color will make the view opaque.
 */
@property (nonatomic, assign) BOOL softwareRendered;

/** Using the text, font and insets, resizes the badge view to the appropriate minimum size. */
- (void)sizeToFit;

@end

NS_ASSUME_NONNULL_END
