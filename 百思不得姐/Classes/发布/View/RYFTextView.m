//
//  RYFTextView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/20.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFTextView.h"

@interface RYFTextView ()
@property (nonatomic, strong) UILabel *placeholerLabel;

@end

@implementation RYFTextView

- (UILabel *)placeholerLabel
{
    if (!_placeholerLabel) {
        _placeholerLabel = [[UILabel alloc]init];
        [self addSubview:_placeholerLabel];
        _placeholerLabel.numberOfLines = 0;
        _placeholerLabel.x = 5;
        _placeholerLabel.y = 5;
        _placeholerLabel.textColor = [UIColor lightGrayColor];
    }
    return _placeholerLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChange
{
    self.placeholerLabel.hidden = self.hasText;
}

- (void)setPlaceholer:(NSString *)placeholer
{
    _placeholer = placeholer;
    self.placeholerLabel.text = placeholer;
    [self setNeedsLayout];
}

- (void)setPlaceholerColor:(UIColor *)placeholerColor
{
    _placeholerColor = placeholerColor;
    self.placeholerLabel.textColor = placeholerColor;
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholerLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textChange];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholerLabel.width = SCREENWIDTH - 2 * self.placeholerLabel.x;
    [self.placeholerLabel sizeToFit];
}
/**
 * 更新占位文字的尺寸
 */
- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(SCREENWIDTH - 2 * self.placeholerLabel.x, MAXFLOAT);
    self.placeholerLabel.size = [self.placeholer boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
//    self.placeholerLabel.backgroundColor = [UIColor redColor];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
