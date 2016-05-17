//
//  CommentHeaderView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/15.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "CommentHeaderView.h"

@interface CommentHeaderView ()
@property (nonatomic, strong) UILabel *label;

@end

@implementation CommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        _label = [UILabel new];
        [self.contentView addSubview:_label];
        _label.textColor = RGBCOLOR(42, 42, 42);
        _label.width = 200;
        _label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _label.x = 10;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    _label.text = _title;
}
@end
