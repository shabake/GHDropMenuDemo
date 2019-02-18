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

 @param GHWaterFallLabel 本身
 @param text 当前文本
 @param index 当前tag
 
 */
typedef void(^GHWaterFallLabelCallBackBlock)(GHWaterFallLabel *waterFallLabel,NSString *text ,NSInteger index);

typedef void(^GHWaterFallLabelCallBackMultipleBlock)(GHWaterFallLabel *waterFallLabe,NSArray *array);
typedef void(^GHWaterFallLabelCallHeightBlock)(CGFloat height);

/**
 流水布局view
 */
@interface GHWaterFallLabel : UIScrollView

/**
 初始化方法

 @param point 传入点坐标
 @param tags 数据源数组
 @return GHWaterFallLabel
 */
+ (instancetype)creatWaterFallLabelWithPoint: (CGPoint)point tags: (NSMutableArray *)tags;

- (void)setPoint: (CGPoint)point;
@property (nonatomic , copy) GHWaterFallLabelCallBackBlock textBlock;
@property (nonatomic , copy) GHWaterFallLabelCallBackMultipleBlock multipleBlock;
@property (nonatomic , copy) GHWaterFallLabelCallHeightBlock heightBlock;


/** 数据源数组 可以使用set方法追加标签 */
@property (nonatomic , strong) NSMutableArray *tags;
- (CGFloat)getHeightWithArray: (NSArray *)array;
/** 设置最大高度 */
@property (nonatomic , assign) CGFloat maxHeight;
/** 是否是多选 默认是NO 多选是YES */
@property (nonatomic , assign) BOOL isMultiple;


@end

NS_ASSUME_NONNULL_END
