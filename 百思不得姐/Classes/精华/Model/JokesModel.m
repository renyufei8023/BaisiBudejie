//
//  JokesModel.m
//  百思不得姐
//
//  Created by 任玉飞 on 16/3/31.
//  Copyright © 2016年 任玉飞. All rights reserved.
//

#import "JokesModel.h"
#import "CommentModel.h"

@implementation JokesModel
{
    CGFloat _cellHeight;
    CGRect _picF;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_image":@"image0",@"large_image":@"image1",@"middle_image":@"image2",@"picwidth":@"width",@"picheight":@"height",@"ID":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : @"CommentModel"};
}

- (NSString *)lasttime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //设置时间格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *creattime = [fmt dateFromString:_passtime];
    
    if (creattime.isThisYear) {
        if (creattime.isToday) {
            
            NSDateComponents *cmps = [NSDate deltaFrom:creattime];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{
                return @"刚刚";
            }
        }else if (creattime.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:creattime];
        }else{
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:creattime];
        }
    }else{
        return _passtime;
    }

}
/**
 *
 *
 *  @return <#return value description#>
 */
- (CGFloat)cellHeight
{

    //当property使用readonly进行修饰的时候，系统默认不会帮你自动生成下划线成员变量，这时需要自己手动添加一个
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 40, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = TitilesViewY + textH + TopicCellMargin;
        
        if (self.type == ControllerTypePicture) {
            CGFloat picW = maxSize.width;
            CGFloat picH = picW * _picheight / _picwidth;
            
            if (picH >= TopicCellPicMaxH) {
                picH = TopicCellPicBreakH;
                self.bigPicture = YES;
            }
            
            CGFloat picX = TopicCellMargin;
            CGFloat picY = TopicCellTextY + textH + TopicCellMargin;
            _picF = CGRectMake(picX, picY, picW, picH);
            _cellHeight += picH + TopicCellMargin;
            
        }else if (self.type == ControllerTypeVoice) {
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * _picheight / _picwidth;
            CGFloat voiceX = TopicCellMargin;
            CGFloat voiceY = TopicCellTextY + textH + TopicCellMargin;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + TopicCellMargin;
        }else if (self.type == ControllerTypeVideo) {
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * _picheight / _picwidth;
            CGFloat videoX = TopicCellMargin;
            CGFloat videoY = TopicCellTextY + textH + TopicCellMargin;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + TopicCellMargin;
        }
        
        CommentModel *model = [self.top_cmt firstObject];
        if (model) {
            NSString *content = model.content;
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
            _cellHeight += 21 + contentH + TopicCellMargin;
        }
        
        _cellHeight += TopicCellBottomBarH + TopicCellMargin;
    }

    return _cellHeight;
}
@end


