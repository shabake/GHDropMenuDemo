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
/**
 block回掉

 @param waterFallLabe 本身
 @param text 当前文本
 @param index 当前tag
 
 */
typedef void(^GHWaterFallLabelCallBackBlock)(GHWaterFallLabel *waterFallLabe,NSString *text ,NSInteger index);

/**
 流水布局view
 */
@interface GHWaterFallLabel : UIView

/**
 初始化方法

 @param point 传入点坐标
 @param tags 数据源数组
 @return GHWaterFallLabel
 */
+ (instancetype)creatWaterFallLabelWithPoint: (CGPoint)point tags: (NSMutableArray *)tags;

@property (nonatomic , copy) GHWaterFallLabelCallBackBlock textBlock;
/** 数据源数组 可以使用set方法追加标签 */
@property (nonatomic , strong) NSMutableArray *tags;
@end

NS_ASSUME_NONNULL_END
