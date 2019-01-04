//
//  GHDropMenuTitleItem.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GHDropMenuModel,GHDropMenuTitleItem;

@protocol GHDropMenuTitleItemDelegate <NSObject>
/**
 GHDropMenuTitleItem 代理回调方法

 @param item GHDropMenuTitleItem
 @param dropMenuModel GHDropMenuModel
 
 */
- (void)dropMenuTitleItem: (GHDropMenuTitleItem *)item
            dropMenuModel: (GHDropMenuModel *)dropMenuModel;

@end

NS_ASSUME_NONNULL_BEGIN

/**
 筛选菜单 菜单标题cell
 */
@interface GHDropMenuTitleItem : UICollectionViewCell
/**
 模型
 */
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
/**
 代理
 */
@property (nonatomic , weak) id <GHDropMenuTitleItemDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
