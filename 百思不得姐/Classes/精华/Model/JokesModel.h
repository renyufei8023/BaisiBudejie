//
//  JokesModel.h
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/31.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JokesModel : NSObject

@property (nonatomic, assign) NSInteger cache_version;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger voicetime;

@property (nonatomic, copy) NSString *voicelength;

@property (nonatomic, strong) NSArray *top_cmt;

@property (nonatomic, assign) NSInteger repost;

@property (nonatomic, copy) NSString *bimageuri;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *theme_type;

@property (nonatomic, copy) NSString *hate;

@property (nonatomic, assign) NSInteger ding;

@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, copy) NSString *passtime;

//@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *tag;

@property (nonatomic, copy) NSString *theme_name;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *favourite;

@property (nonatomic, strong) NSArray *themes;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, assign) NSInteger videotime;

@property (nonatomic, copy) NSString *bookmark;

@property (nonatomic, assign) NSInteger cai;

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, copy) NSString *profile_image;

@property (nonatomic, copy) NSString *love;

@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *theme_id;

@property (nonatomic, copy) NSString *original_pid;

@property (nonatomic, assign) NSInteger t;

@property (nonatomic, copy) NSString *weixin_url;

@property (nonatomic, copy) NSString *voiceuri;

@property (nonatomic, copy) NSString *videouri;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *lasttime;

/**
 *  cell的高度
 */
@property (nonatomic,assign,readonly) CGFloat cellHeight;

/**
 *  小图
 */
@property (nonatomic, copy) NSString *small_image;
/**
 *  大图
 */
@property (nonatomic, copy) NSString *large_image;
/**
 *  中图
 */
@property (nonatomic, copy) NSString *middle_image;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat picwidth;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat picheight;

@property (nonatomic, assign) ControllerType type;

@property(nonatomic, assign, readonly) CGRect picF;

/**
 *  是否是大图
 */
@property(nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@property(nonatomic, assign) CGFloat picLoadProgress;

@property (nonatomic, assign, readonly) CGRect voiceF;
/**
 *  播放次数
 */
@property (nonatomic, assign) NSInteger playcount;

@property (nonatomic, assign, readonly) CGRect videoF;

@end

