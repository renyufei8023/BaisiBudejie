//
//  UIView+RYF.h
//  六位支付密码弹框
//
//  Created by 任玉飞 on 15/8/6.
//  Copyright (c) 2015年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (RYF)
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

/**
 *  当前view所属的控制器
 *
 *  @return 所属的控制器
 */
- (UIViewController *)parentController;

/**
 *  淡入
 *
 *  @param time <#time description#>
 */
- (void)fadeInWithTime:(NSTimeInterval)time;

/**
 *  淡出
 *
 *  @param time <#time description#>
 */
- (void)fadeOutWithTime:(NSTimeInterval)time;

/**
 *  缩放
 */
- (void)scalingWithTime:(NSTimeInterval)time andscal:(CGFloat)scal;

/**
 *  旋转
 *
 *  @param time <#time description#>
 */
- (void)revoLvingWithTime:(NSTimeInterval)time andDelta:(CGFloat)delta;


@end
