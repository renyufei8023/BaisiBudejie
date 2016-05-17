
//
//  RYFLabel.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/18.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFLabel.h"

@implementation RYFLabel

- (void)awakeFromNib
{
    
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  可以成为第一响应者，而不是becomeFirstResponder这个方法
 *
 *  @return <#return value description#>
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:) || action == @selector(copy:) || action == @selector(paste:)) {
        return YES;
    }
    return NO;
    
}

- (void)cut:(id)sender
{
    [self copy:sender];
    self.text = nil;
}

- (void)copy:(id)sender
{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
}

- (void)paste:(id)sender
{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    self.text = board.string;
}

- (void)setup
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)]];
    
}

- (void)longPress
{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
}

@end
