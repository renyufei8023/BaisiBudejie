
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ControllerType){
    ControllerTypeAll = 1,
    ControllerTypePicture = 10,
    ControllerTypeWord = 29,
    ControllerTypeVoice = 31,
    ControllerTypeVideo = 41
};

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const TitilesViewH;
/** 精华-顶部标题的Y */

UIKIT_EXTERN CGFloat const TitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const TopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const TopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const TopicCellBottomBarH;

UIKIT_EXTERN CGFloat const TopicCellPicMaxH;

UIKIT_EXTERN CGFloat const TopicCellPicBreakH;

UIKIT_EXTERN NSString *const UITabbarControllerDidSelectNotification;

