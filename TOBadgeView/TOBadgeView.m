//
//  TOBadgeView.m
//  TOBadgeViewExample
//
//  Created by Tim Oliver on 8/11/18.
//  Copyright © 2018 Tim Oliver. All rights reserved.
//

#import "TOBadgeView.h"

@interface TOBadgeView ()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImage *backingImage;

@property (nonatomic, assign) BOOL isDirty;

@end

@implementation TOBadgeView

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

- (void)commonInit
{
    //Set to software rendered in IB
#if !TARGET_INTERFACE_BUILDER
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

    if (!self.textLabel) {
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self addSubview:self.textLabel];
    }

    self.textLabel.font = self.font;
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.textColor = self.textColor;
}

- (void)sizeToFit
{

}

#pragma mark - Accessors -
- (void)setFont:(UIFont *)font
{
    if (font && font == _font) { return; }
    _font = font;

    // Set font to be bold
    if (!_font) {
        _font = [UIFont systemFontOfSize:14.0f weight:UIFontWeightBold];
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
