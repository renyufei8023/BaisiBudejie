//
//  PublishView.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/11.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "PublishView.h"
#import "RYFVerButton.h"

@implementation PublishView

static UIWindow *_window;
+ (void)show
{
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    _window.backgroundColor = [UIColor whiteColor];
    _window.hidden = NO;
    _window.alpha = 0.8;
//    _window.windowLevel = UIWindowLevelAlert;可以设置window的优先级，normal是普通的，alert和alertview级别一样，statubar级别最高
//    [_window makeKeyAndVisible];这句代码相当于把这个window设置为主窗口以及设置hidden=NO
    
    PublishView *publishView = [PublishView publishView];
    publishView.frame = _window.bounds;
    [_window addSubview:publishView];
    
}

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    self.alpha = 0.9;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int total = 3;
    CGFloat btnW = 72;
    CGFloat btnH = btnW + 30;
    CGFloat btnStartY = (SCREENHEIGHT - 2 * btnH) * 0.5;
    CGFloat btnStartX = 20;
    CGFloat margin = (SCREENWIDTH - 2 * btnStartX - total * btnW) / (total - 1);
    CGFloat verMargin = 20;
    for (int i = 0; i < images.count; i++) {
        RYFVerButton *btn = [[RYFVerButton alloc]init];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        //        btn.width = btnW;
        //        btn.height = btnH;
        int row = i / total;
        int col = i % total;
        
        CGFloat buttonX = btnStartX + col * (margin + btnW);
        CGFloat buttonEndY = btnStartY + row * (btnH + verMargin);
        CGFloat buttonBrginY = buttonEndY - SCREENHEIGHT;
        //        btn.x = btnStartX + col * (margin + btnW);
        //        btn.y = btnStartY + row * (btnH + verMargin);
        [self addSubview:btn];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBrginY, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, btnW, btnH)];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        [btn pop_addAnimation:anim forKey:nil];
    }
    
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    //    slogan.centerX = SCREENWIDTH * 0.5;
    //    slogan.y = SCREENHEIGHT * 0.2;
    [self addSubview:slogan];
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = SCREENWIDTH * 0.5;
    CGFloat centerEndY = SCREENHEIGHT * 0.2;
    CGFloat centerBeginY = centerEndY - SCREENHEIGHT;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    
    [slogan pop_addAnimation:anim forKey:nil];
}

- (void)btnClick:(UIButton *)btn
{
    [self animationWithComletedBlock:^{
        if (btn.tag == 1) {
            
        }
    }];
}
/**
 *  这样写是为了点击按钮每个都有动画效果，而且每次下次都会有回调，通过这个completionBlock通知btnClick这个方法按钮哪个被点击
 */
- (void)animationWithComletedBlock:(void (^)())completionBlock
{
    for (int i = 1; i < self.subviews.count; i ++) {
        UIView *view = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        // 动画的执行节奏(一开始很慢, 后面很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        CGFloat centerY = view.centerY + SCREENHEIGHT;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - 1) * 0.1;
        [view pop_addAnimation:anim forKey:nil];
        
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL comple) {
                [self removeFromSuperview];
                if (completionBlock) {
                    completionBlock();
                }
                
                if (_window) {
                    _window = nil;
                }
            }];
        }
    }
    
}

- (IBAction)cancle {
    
    [self animationWithComletedBlock:^{
        
    }];
}

@end
