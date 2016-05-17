//
//  RYFPlaceHolderTextView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/20.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFPlaceHolderTextView.h"

@implementation RYFPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.alwaysBounceVertical = YES;
        self.font = [UIFont systemFontOfSize:15];
        self.placeholerColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChange
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //可以使用这种方式判断
//    if (self.text.length || self.attributedText.length) return;
    //或者是这种
    if (self.hasText) return;
    rect.origin.x = 5;
    rect.origin.y = 5;
    rect.size.width -= 2 * rect.origin.x;
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = self.font;
    att[NSForegroundColorAttributeName] = self.placeholerColor;
    [self.placeholer drawInRect:rect withAttributes:att];
}

- (void)setPlaceholer:(NSString *)placeholer
{
    _placeholer = placeholer;
    [self setNeedsDisplay];
}

- (void)setPlaceholerColor:(UIColor *)placeholerColor
{
    _placeholerColor = placeholerColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

@end
