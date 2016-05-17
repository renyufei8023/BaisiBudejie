//
//  RYFVerButton.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/30.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "RYFVerButton.h"

@implementation RYFVerButton

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

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.imageView.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 10;
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.titleLabel.height;
    
}

@end
