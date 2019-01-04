//
//  GHDropMenuOptionCell.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GHDropMenuModel,GHDropMenuOptionCell;

/**
 选项菜单cell
 */
@interface GHDropMenuOptionCell : UITableViewCell
/**
 模型
 */
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@end

NS_ASSUME_NONNULL_END
