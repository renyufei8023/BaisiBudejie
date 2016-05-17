//
//  JokesPictureView.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/6.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JokesModel;
@interface JokesPictureView : UIView
@property (nonatomic, strong) JokesModel *jokesModel;
+ (instancetype)pictureView;

@end
