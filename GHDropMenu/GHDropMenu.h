//
//  GHDropMenu.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHDropMenuHeader.h"

NS_ASSUME_NONNULL_BEGIN

/** 菜单类型 */
typedef NS_ENUM (NSUInteger,GHDropMenuFilterCellType ) {
    /** 标签 */
    GHDropMenuFilterCellTypeTag = 1,
    /** 输入 */
    GHDropMenuFilterCellTypeInput,
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
/** 标题菜单是否记录用户菜单选择 默认是NO */
@property (nonatomic , assign) BOOL recordSeleted;
/** 筛选菜单类型 */
@property (nonatomic , assign) GHDropMenuFilterCellType filterCellType;
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
/** titleVie背景颜色 */
@property (nonatomic , strong) UIColor *titleViewBackGroundColor;
/** 记录indexPath */
@property (nonatomic , strong) NSIndexPath *indexPath;

/** 构造筛选菜单数据 */
- (NSArray *)creaDropMenuData;
@end

@class GHDropMenu,GHDropMenuModel;
@protocol GHDropMenuDelegate <NSObject>
/**
 代理回调

 @param dropMenu dropMenu本身
 @param dropMenuModel 标题模型
 @param tagArray tag数组
 */
- (void)dropMenu: (GHDropMenu *)dropMenu
   dropMenuModel: (nullable GHDropMenuModel *)dropMenuModel
        tagArray: (NSArray *)tagArray;
@end


@interface GHDropMenu : UIView
/**
 初始化方法
 
 @param configuration GHDropMenuModel模型

 @return GHDropMenu
 */
- (instancetype)creatDropMenuWithConfiguration: (GHDropMenuModel *)configuration frame: (CGRect)frame;
/** set方法 */
@property (nonatomic , strong) GHDropMenuModel *configuration;

@property (nonatomic , strong) UIColor *titleViewBackGroundColor;

@property (nonatomic , strong) UIFont *titleFont;

@property (nonatomic , weak) id <GHDropMenuDelegate>delegate;

- (void)resetMenuStatus;
@end

NS_ASSUME_NONNULL_END
