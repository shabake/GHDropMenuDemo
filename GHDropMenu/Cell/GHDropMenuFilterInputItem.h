//
//  GHDropMenuFilterInputItem.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GHDropMenuFilterInputItem,GHDropMenuModel;
@protocol GHDropMenuFilterInputItemDelegate <NSObject>
- (void)dropMenuFilterInputItem: (GHDropMenuFilterInputItem *)item dropMenuModel: (GHDropMenuModel *)dropMenuModel;
- (void)dropMenuFilterEndInputItem: (GHDropMenuFilterInputItem *)item dropMenuModel: (GHDropMenuModel *)dropMenuModel;

@end

@interface GHDropMenuFilterInputItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterInputItemDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
