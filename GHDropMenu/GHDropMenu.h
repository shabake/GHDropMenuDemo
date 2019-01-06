//
//  GHDropMenu.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import <UIKit/UIKit.h>
#import "GHDropMenuHeader.h"

NS_ASSUME_NONNULL_BEGIN

@class GHDropMenu,GHDropMenuModel;
@protocol GHDropMenuDataSource <NSObject>
@required
/** 配置筛选菜单标题 */
- (NSArray *)columnTitlesInMeun:(GHDropMenu *)menu;
/** 配置筛选菜单标题选项 */
- (NSArray *)menu:(GHDropMenu *)menu numberOfColumns:(NSInteger)columns;
@end
@protocol GHDropMenuDelegate <NSObject>
@optional
/**
 代理回调
 
 @param dropMenu dropMenu本身
 @param dropMenuModel 默认配置
 */
- (void)dropMenu: (GHDropMenu *)dropMenu
dropMenuModel: (nullable GHDropMenuModel *)dropMenuModel
           index: (NSInteger)index;
/**
 代理回调

 @param dropMenu dropMenu本身
 @param dropMenuTitleModel 标题弹出筛选结果
 */
- (void)dropMenu: (GHDropMenu *)dropMenu
dropMenuTitleModel: (nullable GHDropMenuModel *)dropMenuTitleModel;

/**
 代理回调
 
 @param dropMenu dropMenu本身
 @param tagArray 侧边弹出筛选结果
 */
- (void)dropMenu: (GHDropMenu *)dropMenu
tagArray: (nullable NSArray *)tagArray;

- (void)dropMenu: (GHDropMenu *)dropMenu
        distance: (CGFloat)distance;
@end

typedef void(^DropMenuTitleBlock)(GHDropMenuModel *dropMenuModel);
typedef void(^DropMenuTagArrayBlock)(NSArray *tagArray);
typedef void(^DropMenuFinishBlock)(void);

@interface GHDropMenu : UIView
/**
 构造GHDropMenu

 @param configuration 配置模型
 @param frame 设置约束
 @param dropMenuTitleBlock 顶部菜单选择回调
 @param dropMenuTagArrayBlock 右侧筛选菜单回调
 */
+ (instancetype)creatDropMenuWithConfiguration: (nullable GHDropMenuModel *)configuration
                                         frame: (CGRect)frame
                            dropMenuTitleBlock: (DropMenuTitleBlock)dropMenuTitleBlock
                         dropMenuTagArrayBlock: (DropMenuTagArrayBlock)dropMenuTagArrayBlock;

/**
 构造GHDropFilterMenu
 @param configuration 配置模型
 @param dropMenuTagArrayBlock 右侧筛选菜单回调
 */
+ (instancetype)creatDropFilterMenuWidthConfiguration: (GHDropMenuModel *)configuration
         dropMenuTagArrayBlock: (DropMenuTagArrayBlock)dropMenuTagArrayBlock;

@property (nonatomic , strong) NSMutableArray *titles;
/** set方法 */
@property (nonatomic , strong) GHDropMenuModel *configuration;

@property (nonatomic , strong) UIColor *titleViewBackGroundColor;
/** 标题菜单标题文字大小 */
@property (nonatomic , strong) UIFont *titleFont;
/** 标题菜单标题正常文字颜色 */
@property (nonatomic , strong) UIColor *titleNormalColor;
/** 标题菜单标题选中文字颜色 */
@property (nonatomic , strong) UIColor *titleSeletedColor;
/** 标题菜单标题正常图片 */
@property (nonatomic , copy) NSString *titleNormalImageName;
/** 标题菜单标题选中图片 */
@property (nonatomic , copy) NSString *titleSeletedImageName;
/** 选项文字大小 */
@property (nonatomic , strong) UIFont *optionFont;
/** 选项正常文字颜色 */
@property (nonatomic , strong) UIColor *optionNormalColor;
/** 选项选中文字颜色 */
@property (nonatomic , strong) UIColor *optionSeletedColor;
/** 选项菜单y值 */
@property (nonatomic , assign) CGFloat tableY;
/** cell高度 不设置默认 44 */
@property (nonatomic , assign) CGFloat cellHeight;
@property (nonatomic , weak) id <GHDropMenuDelegate> delegate;
@property (nonatomic , weak) id <GHDropMenuDataSource> dataSource;
/** 动画时间 等于0 不开启动画 默认是0 */
@property (nonatomic , assign) NSTimeInterval durationTime;
/** 标题菜单是否记录用户菜单选择 默认是NO */
@property (nonatomic , assign) BOOL recordSeleted;

/** 重置所有状态 */
- (void)resetMenuStatus;

- (void)show;

/** 关闭菜单 */
- (void)closeMenu;
@end

NS_ASSUME_NONNULL_END
