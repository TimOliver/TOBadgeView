//
//  TOBadgeView.m
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

#import "TOBadgeView.h"

@interface _TOBadgeLabel : UILabel
@property (nonatomic, strong) UIColor *badgeColor;
@end

@interface TOBadgeView ()

@property (nonatomic, strong) _TOBadgeLabel *textLabel;
@property (nonatomic, strong) UIImage *backingImage;
@property (nonatomic, assign) BOOL isDirty;

@end

@implementation TOBadgeView

#pragma mark - View Creation -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }

    return self;
}

#pragma mark - View Configuration -

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];

    //Set to software rendered in IB
#if TARGET_INTERFACE_BUILDER
    _softwareRendered = YES;
#endif

    // Set up all of the default properties
    [self setUpDefaultProperties];

    // Configure depending on rendering modes
    [self configureForSoftwareRendering:_softwareRendered];
}

- (void)setUpDefaultProperties
{
    // Triggers the accessors and resets them back to
    // their default values. This is better than redundancy.
    self.font = nil;
    self.badgeColor = nil;
    self.textColor = nil;
}

- (void)configureForSoftwareRendering:(BOOL)softwareRendering
{
    // If we're rendering via software (Such as IB), remove all the views
    if (softwareRendering) {
        [self.textLabel removeFromSuperview];
        self.textLabel = nil;
        self.isDirty = YES;

        return;
    }

    // Clean out any backing contents
    self.layer.contents = nil;
    self.layer.masksToBounds = YES;

    if (!self.textLabel) {
        self.textLabel = [[_TOBadgeLabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.textLabel];
    }

    self.textLabel.font = self.font;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = self.textColor;
    self.textLabel.badgeColor = self.badgeColor;
}

- (void)sizeToFit
{

}

#pragma mark - View Layout -

- (void)layoutSubviews
{
    [super layoutSubviews];

    // If the view has been marked as 'dirty', redraw the image, apply, then exit
    if (self.softwareRendered) {
        if (self.isDirty) {
            self.layer.contents = (id)[self imageForBackingLayer].CGImage;
            self.isDirty = NO;
        }
        return;
    }

    // Stretch the label to fill the clipping rect
    self.textLabel.frame = self.bounds;

    self.layer.cornerRadius = CGRectGetHeight(self.bounds) * 0.5f;
}

#pragma mark - Backing Layer -
- (UIImage *)imageForBackingLayer
{
    UIImage *image = nil;
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0f);
    [self drawBackingLayerWithContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)drawBackingLayerWithContext:(CGContextRef)context
{
    // Clip off the rounded corners
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.height];
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);

    // Fill with the badge color
    [self.badgeColor setFill];
    [[UIBezierPath bezierPathWithRect:self.bounds] fill];

    // Add the text

    // Center the text
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;

    // Apply the font and text color
    NSDictionary *attributes = @{NSForegroundColorAttributeName: self.textColor,
                                 NSFontAttributeName: self.font,
                                 NSParagraphStyleAttributeName: paragraphStyle
                                 };

    // Center the text vertically
    CGRect textRect = self.bounds;
    textRect.origin.y = (textRect.size.height - self.font.lineHeight) * 0.5f;

    // Draw the text
    [self.text drawInRect:textRect withAttributes:attributes];
}

#if TARGET_INTERFACE_BUILDER
- (void)drawRect:(CGRect)rect
{
    [self drawBackingLayerWithContext:UIGraphicsGetCurrentContext()];
}
#endif

#pragma mark - Accessors -
- (void)setText:(NSString *)text
{
    if (text == _text) { return; }
    _text = text;
    self.isDirty = YES;
    self.textLabel.text = text;
}

- (void)setFont:(UIFont *)font
{
    if (font && font == _font) { return; }
    _font = font;

    // Set font to be bold
    if (!_font) {
        _font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightMedium];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    if (textColor && textColor == _textColor) { return; }
    _textColor = textColor;

    // Set default color of white
    if (!_textColor) {
        _textColor = UIColor.whiteColor;
    }
}

- (void)setBadgeColor:(UIColor *)badgeColor
{
    if (badgeColor && badgeColor == _badgeColor) { return; }
    _badgeColor = badgeColor;

    // Set badge color to be light-ish red
    if (!_badgeColor) {
        _badgeColor = [UIColor colorWithRed:250.0f/255.0f
                                      green:58.0f/255.0f
                                       blue:44.0f/255.0f
                                      alpha:1.0f];
    }
}

@end

#pragma mark - Badge Label -

/*
 This is a somewhat annoying hack made necessary by old UIKit 'magic'.

 When a `UILabel` is in a table view cell and the cell is tapped,
 iOS will automatically loop through every subview, and depending on its
 type (such as a label) will forcibly change its backgrounf color to clear.

 We explicitly don't ever want that, so in this case, we set a property
 that controls the background color, while explicitly overriding setting
 the background color of the view to be a no-op.

 */
@implementation _TOBadgeLabel

- (void)setBadgeColor:(UIColor *)badgeColor
{
    _badgeColor = badgeColor;
    [super setBackgroundColor:_badgeColor];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor { }

@end
