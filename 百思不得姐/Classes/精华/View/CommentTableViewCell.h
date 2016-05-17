//
//  CommentTableViewCell.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/15.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;

@interface CommentTableViewCell : UITableViewCell
@property (nonatomic, strong) CommentModel *commentModel;

@end
