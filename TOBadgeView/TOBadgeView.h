//
//  TOBadgeView.h
//
//  Copyright 2018 Timothy Oliver. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(BadgeView)
IB_DESIGNABLE @interface TOBadgeView : UIView

/** The text displayed inside the badge. May be an int or text. (Default is '1') */
@property (nonatomic, strong, nullable) IBInspectable NSString *text;

/** The font of the badge text. (Default is system medium 16) */
@property (nonatomic, strong, null_resettable) IBInspectable UIFont *font;

/** The color of the badge text. (Default is white) */
@property (nonatomic, strong, null_resettable) IBInspectable UIColor *textColor;

/** The tint color of the badge image behind the text (Default is red) */
@property (nonatomic, strong, null_resettable) IBInspectable UIColor *badgeColor;

/** When text is longer than 1 char, vertically and horizontally,
 the amount of padding between the text and the edge of the view on each side.
 Default is {10, 4}
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
