//
//  GHDropMenuFilterTagItem.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GHDropMenuFilterTagItem,GHDropMenuModel;

@protocol GHDropMenuFilterTagItemDelegate <NSObject>
- (void)dropMenuFilterTagItem: (GHDropMenuFilterTagItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel;

@end

@interface GHDropMenuFilterTagItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterTagItemDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
