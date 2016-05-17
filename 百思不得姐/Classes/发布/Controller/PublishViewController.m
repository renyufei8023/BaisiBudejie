//
//  PublishViewController.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/8.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "PublishViewController.h"
#import "RYFVerButton.h"
#import "PublishJokesController.h"
#import "RYFNavigationController.h"

@interface PublishViewController ()

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        [self.view addSubview:btn];
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
    [self.view addSubview:slogan];

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
        if (btn.tag == 2) {
            DEBUGLOG(@"123");
            DEBUGLOGFunc;
            PublishJokesController *postWord = [[PublishJokesController alloc] init];
            RYFNavigationController *nav = [[RYFNavigationController alloc] initWithRootViewController:postWord];
            
            // 这里不能使用self来弹出其他控制器, 因为self执行了dismiss操作
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];

        }
    }];
}
/**
 *  这样写是为了点击按钮每个都有动画效果，而且每次下次都会有回调，通过这个completionBlock通知btnClick这个方法按钮哪个被点击
 */
- (void)animationWithComletedBlock:(void (^)())completionBlock
{
    for (int i = 2; i < self.view.subviews.count; i ++) {
        UIView *view = self.view.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        // 动画的执行节奏(一开始很慢, 后面很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        CGFloat centerY = view.centerY + SCREENHEIGHT;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(view.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - 2) * 0.1;
        [view pop_addAnimation:anim forKey:nil];
        
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL comple) {
                [self dismissViewControllerAnimated:NO completion:nil];
                if (completionBlock) {
                    completionBlock();
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
