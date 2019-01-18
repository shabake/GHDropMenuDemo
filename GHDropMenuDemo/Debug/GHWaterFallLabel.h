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
typedef void(^GHWaterFallLabelCallBackBlock)(GHWaterFallLabel *waterFallLabe,NSString *text ,NSInteger index);
@interface GHWaterFallLabel : UIScrollView

+ (instancetype)creatWaterFallLabelWithPoint: (CGPoint)point tags: (NSMutableArray *)tags;

@property (nonatomic , copy) GHWaterFallLabelCallBackBlock textBlock;
@property (nonatomic , strong) NSMutableArray *tags;
@end

NS_ASSUME_NONNULL_END
