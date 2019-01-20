//
//  GHDropMenuWaterFallCell.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/19.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GHDropMenuWaterFallCell : UITableViewCell
@property (nonatomic , strong) NSMutableArray *tags;

- (CGFloat)getCellHeight;
@end

NS_ASSUME_NONNULL_END
