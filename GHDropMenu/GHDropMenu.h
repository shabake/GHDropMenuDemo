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

/** 菜单类型 */
typedef NS_ENUM (NSUInteger,GHDropMenuFilterCellType ) {
    /** 标签 */
    GHDropMenuFilterCellTypeTag = 1,
    /** 输入 */
    GHDropMenuFilterCellTypeInput,
    /** 输入 */
    GHDropMenuFilterCellTypeSingleInput,
};
/** 菜单类型 */
typedef NS_ENUM (NSUInteger,GHDropMenuType ) {
    /** 标题 */
    GHDropMenuTypeTitle = 1,
    /** 筛选菜单 */
    GHDropMenuTypeFilter,
};
/** 筛选菜单模型 */
@interface GHDropMenuModel :NSObject
@property (nonatomic , strong) UIColor *titleViewBackGroundColor;
/** 选项正常文字颜色 */
@property (nonatomic , strong) UIColor *optionNormalColor;
/** 选项选中文字颜色 */
@property (nonatomic , strong) UIColor *optionSeletedColor;
/** 选项文字大小 */
@property (nonatomic , strong) UIFont *optionFont;
/** 标题菜单标题正常图片 */
@property (nonatomic , copy) NSString *titleNormalImageName;
/** 标题菜单标题选中图片 */
@property (nonatomic , copy) NSString *titleSeletedImageName;
/** 标题菜单标题正常文字颜色 */
@property (nonatomic , strong) UIColor *titleNormalColor;
/** 标题菜单标题选中文字颜色 */
@property (nonatomic , strong) UIColor *titleSeletedColor;
/** 标题菜单是否记录用户菜单选择 默认是NO */
@property (nonatomic , assign) BOOL recordSeleted;
/** 筛选菜单类型 */
@property (nonatomic , assign) GHDropMenuFilterCellType filterCellType;
@property (nonatomic , copy) NSString *singleInput;
/** 最小价格 */
@property (nonatomic , copy) NSString *minPrice;
/** 最大价格 */
@property (nonatomic , copy) NSString *maxPrice;
/** 是否是多选  NO 单选 YES 多选 */
@property (nonatomic , assign) BOOL isMultiple;
/** cell是否被选中 */
@property (nonatomic , assign) BOOL cellSeleted;
/** section是否被选中 */
@property (nonatomic , assign) BOOL sectionSeleted;
/** 存放tag section数组 */
@property (nonatomic , strong) NSArray *sections;
/** tag id */
@property (nonatomic , assign) NSInteger tagIdentifier;
/** tag 模型 */
@property (nonatomic , strong) GHDropMenuModel *dropMenuTagModel;
/** sectionHeaderTitle */
@property (nonatomic , copy) NSString *sectionHeaderTitle;
/** sectionHeaderDetails */
@property (nonatomic , copy) NSString *sectionHeaderDetails;
/** 标签名称 */
@property (nonatomic , copy) NSString *tagName;
/** 标签选中状态 */
@property (nonatomic , assign) BOOL tagSeleted;
/** 菜单类型 */
@property (nonatomic , assign) GHDropMenuType dropMenuType;
/** 标题 */
@property (nonatomic , copy) NSString *title;
@property (nonatomic , assign) NSInteger identifier;
@property (nonatomic , strong) UIFont *titleFont;
@property (nonatomic , assign) CGFloat menuHeight;
/** 标题被选中 */
@property (nonatomic , assign) BOOL titleSeleted;
/** 标题数组 */
@property (nonatomic , strong) NSArray *titles;
/** 数据源数组 */
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , assign) CGRect frame;

/** 记录indexPath */
@property (nonatomic , strong) NSIndexPath *indexPath;

/** 构造筛选菜单数据 */
- (NSArray *)creaDropMenuData;
- (NSArray *)creaFilterDropMenuData;
- (NSArray *)creatNormalDropMenuData;
@end

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
dropMenuModel: (nullable GHDropMenuModel *)dropMenuModel;
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

@property (nonatomic , strong) NSArray *titles;

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
@property (nonatomic , weak) id <GHDropMenuDelegate> delegate;
@property (nonatomic , weak) id <GHDropMenuDataSource> dataSource;
/** 动画时间 等于0 不开启动画 默认是0 */
@property (nonatomic , assign) NSTimeInterval durationTime;
/** 标题菜单是否记录用户菜单选择 默认是NO */
@property (nonatomic , assign) BOOL recordSeleted;

/** 重置所有状态 */
- (void)resetMenuStatus;

- (void)show;

@end

NS_ASSUME_NONNULL_END
