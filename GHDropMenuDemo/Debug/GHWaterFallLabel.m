//
//  GHWaterFallLabel.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/16.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHWaterFallLabel.h"
#import "UIView+Extension.h"
#import "NSArray+Bounds.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface GHWaterFallLabel()
/**
 存储tag的数组
 */
@property (nonatomic , strong) NSMutableArray *labels;
/**
 存储坐标
 */
@property (nonatomic , assign) CGPoint point;

@end
@implementation GHWaterFallLabel

+ (instancetype)creatWaterFallLabelWithPoint: (CGPoint)point tags: (NSMutableArray *)tags {
    GHWaterFallLabel *waterFallLabel = [[GHWaterFallLabel alloc]initWithFrame:CGRectMake(point.x, point.y, kScreenWidth, 0)];
    waterFallLabel.tags = tags;
    waterFallLabel.point = point;
    return waterFallLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self configuration];
    }
    return self;
}

- (void)configuration {
    self.maxHeight = 100;
}
- (void)setTags:(NSMutableArray *)tags {
    _tags = tags;
    
    for (UILabel *label in self.labels) {
        [label removeFromSuperview];
    }

    for (NSInteger index = 0; index < tags.count; index++) {
        UILabel *tag = [[UILabel alloc]init];
        tag.text = [self.tags by_ObjectAtIndex:index];
        [self.labels addObject:tag];
    }
    
    for (NSInteger index = 0;index < self.labels.count ;index++) {
        
        UILabel *tag = [self.labels by_ObjectAtIndex:index];
        tag.font = [UIFont systemFontOfSize:16];
        tag.layer.masksToBounds = YES;
        tag.layer.cornerRadius = 5;
        tag.textAlignment = NSTextAlignmentCenter;
        tag.textColor = [UIColor whiteColor];
        tag.backgroundColor = [UIColor orangeColor];
        tag.numberOfLines = 0 ;
        tag.tag = index;
        tag.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        
        [tag addGestureRecognizer:tap];
        
        CGSize tagSize = [tag sizeThatFits:CGSizeMake(MAXFLOAT,16)];
        // 取出上一个tag
        UILabel *lastTag = [self.labels by_ObjectAtIndex:index -1];
        CGFloat y = 5;
        CGFloat x = 10 +CGRectGetMaxX(lastTag.frame);
        CGFloat w = tagSize.width + 30;
        CGFloat h = 30;
        
        
        if (w > kScreenWidth - 20 /** 最大宽度*/) {
            w = kScreenWidth - 20;
            CGSize titleSize = [tag sizeThatFits:CGSizeMake(kScreenWidth - 20,MAXFRAG)];
            h = titleSize.height;
        }
        if (CGRectGetMaxX(lastTag.frame) + w > kScreenWidth - 20 /** 当标签超过当前行 */) {
            y = lastTag.y + lastTag.height + 5;
            x = 10;
            
        } else {
            if (index > 0) {
                y = lastTag.y ;
            }
        }
        tag.frame = CGRectMake(x,y,w,h);
        
        [self addSubview:tag];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UILabel *tag = self.labels.lastObject;
    CGFloat maxHeight = tag.y + tag.height + 5;
    
    self.contentSize = CGSizeMake(0, maxHeight);
    
    if (maxHeight > kScreenHeight - self.point.y) {
        maxHeight = kScreenHeight- self.point.y;
    }
    
    self.height = maxHeight;
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    
    UILabel *label = (UILabel *)gesture.view;
    
    if (self.textBlock) {
        self.textBlock(self,label.text,label.tag);
    }
}

- (NSMutableArray *)labels {
    if (_labels == nil) {
        _labels = [NSMutableArray array];
    }
    return _labels;
}

@end
