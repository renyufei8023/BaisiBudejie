//
//  CommentModel.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/4/14.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface CommentModel : NSObject
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, strong) UserModel *user;

@end
