//
//  GHCustomAlertView.h
//  GHStudy
//
//  Created by 赵治玮 on 2017/11/12.
//  Copyright © 2017年 赵治玮. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    /** 底部 */
    GHCustomAlertViewPositionType_bottom = 1,
    /** 中间 */
    GHCustomAlertViewPositionType_center,
    /** 顶部 */
    GHCustomAlertViewPositionType_top
    
} GHCustomAlertViewPositionType;


typedef enum : NSUInteger {
    /** 取消*/
    GHCustomAlertViewButtonType_cancel = 1,
    /** 确定 */
    GHCustomAlertViewButtonType_sure,
    
} GHCustomAlertViewButtonType;

typedef void (^GHCustomAlertViewTimeBlock)(NSString *time);

@interface GHCustomAlertView : UIView
@property (nonatomic , copy) void (^showFinish)(void);
@property (nonatomic , copy) void (^dimissFinish)(void);
@property (nonatomic , assign) GHCustomAlertViewPositionType positionType;
@property (nonatomic , assign) CGFloat alertHeight;
@property (nonatomic , copy) NSString *alertTitle;
@property (nonatomic , copy) GHCustomAlertViewTimeBlock timeBlock;
@property (nonatomic , strong) UIView *contentView;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UILabel *title;
/** 取消 */
@property (nonatomic , strong) UIButton *cancel;
/** 确定 */
@property (nonatomic , strong) UIButton *sure;
- (void)setupDefault;
- (void)show;
- (void)dismiss;
@end
