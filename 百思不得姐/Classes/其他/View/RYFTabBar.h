//
//  RYFTabBar.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/22.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol plusBtnClickDelegate <NSObject>
@optional
- (void)plusBtnClick;

@end
@interface RYFTabBar : UITabBar
@property (nonatomic, weak) id<plusBtnClickDelegate>tabBarDelegate;
@end
