//
//  GHDropMenuFilterTimeChoseItem.h
//  GHDropMenuDemo
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM (NSUInteger,GHDropMenuFilterTimeChoseItemType) {
    GHDropMenuFilterTimeChoseItemTypeBeginTime = 0 ,
    GHDropMenuFilterTimeChoseItemTypeEndTime ,

};
@class GHDropMenuFilterTimeChoseItem,GHDropMenuModel;
@protocol GHDropMenuFilterTimeChoseItemDelegate <NSObject>
@optional

- (void)dropMenuFilterTimeChoseItem: (GHDropMenuFilterTimeChoseItem *)item type:(GHDropMenuFilterTimeChoseItemType)type dropMenuModel: (GHDropMenuModel *)dropMenuModel;

@end
@interface GHDropMenuFilterTimeChoseItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak)id <GHDropMenuFilterTimeChoseItemDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
