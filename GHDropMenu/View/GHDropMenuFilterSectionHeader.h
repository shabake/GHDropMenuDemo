//
//  GHDropMenuFilterSectionHeader.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GHDropMenuModel,GHDropMenuFilterSectionHeader;

@protocol GHDropMenuFilterSectionHeaderDelegate <NSObject>
- (void)dropMenuFilterSectionHeader: (GHDropMenuFilterSectionHeader *)header dropMenuModel: (GHDropMenuModel *)dropMenuModel;

@end

@interface GHDropMenuFilterSectionHeader : UICollectionReusableView
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;

@property (nonatomic , weak) id <GHDropMenuFilterSectionHeaderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
