//
//  UIImageView+CircleImage.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/19.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "UIImageView+CircleImage.h"

@implementation UIImage (CircleImage)

- (UIImage *)circleImage
{
    //NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ref, rect);
    
    CGContextClip(ref);
    //把圆画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}
@end
