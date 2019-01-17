//
//  GHWaterFallLabel.h
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/16.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GHWaterFallLabel;
typedef void(^GHWaterFallLabelCallBackBlock)(NSString *text ,NSInteger index);
typedef void(^GHWaterFallLabelHeightBlock)(GHWaterFallLabel *waterFallLabel, CGFloat height);
@interface GHWaterFallLabel : UIScrollView
+ (instancetype)creatWaterFallLabelWithFrame: (CGRect)frame tags: (NSMutableArray *)tags;
@property (nonatomic , copy) GHWaterFallLabelHeightBlock heightBlock;
@property (nonatomic , copy) GHWaterFallLabelCallBackBlock textBlock;
@property (nonatomic , strong) NSMutableArray *tags;
@end

NS_ASSUME_NONNULL_END
