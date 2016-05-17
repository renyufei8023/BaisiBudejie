//
//  JokesVideoView.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/13.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JokesModel;
@interface JokesVideoView : UIView
@property (nonatomic, strong) JokesModel *jokeModel;

+ (instancetype)videoView;
@end
