//
//  GHDropMenuFilterSingleInputItem.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GHDropMenuFilterSingleInputItem,GHDropMenuModel;

@protocol GHDropMenuFilterSingleInputItemDelegate <NSObject>
- (void)dropMenuFilterSingleInputItem: (GHDropMenuFilterSingleInputItem *)item
                        dropMenuModel: (GHDropMenuModel *)dropMenuModel;
@end

@interface GHDropMenuFilterSingleInputItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterSingleInputItemDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
