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

@interface GHLabel : UILabel
@property (nonatomic , copy) UIColor *normalColor;
@property (nonatomic , copy) UIColor *seletedColor;

@property (nonatomic , assign) BOOL isSeleted;


@end

@implementation GHLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self configuration];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        [self configuration];
    }
    return self;
}

- (void)configuration {
    self.isSeleted = NO;
    self.textColor = self.normalColor;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    if (!self.isSeleted) {
        self.textColor = normalColor;
    }
}

- (void)setSeletedColor:(UIColor *)seletedColor {
    _seletedColor = seletedColor;
    if (self.isSeleted) {
        self.textColor = seletedColor;
    }
}

- (void)setIsSeleted:(BOOL)isSeleted {
    _isSeleted = isSeleted;
    
    if (isSeleted) {
        self.textColor = self.seletedColor;
    } else {
        self.textColor = self.normalColor;
    }
}
@end
@interface GHWaterFallLabel()

/**
 存储tag的数组
 */
@property (nonatomic , strong) NSMutableArray *labels;
/**
 存储坐标
 */
@property (nonatomic , assign) CGPoint point;
/**
 当前选中
 */
@property (nonatomic , assign) NSInteger currentIndex;

@property (nonatomic , strong) NSMutableArray *multipleArray;

@end
@implementation GHWaterFallLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self configuration];

    }
    return self;
}
- (instancetype)init {
    if (self == [super init]) {
        [self configuration];

    }
    return self;
}
- (void)setPoint:(CGPoint)point {
    self.frame = CGRectMake(point.x, point.y, kScreenWidth, 0);
    
}
+ (instancetype)creatWaterFallLabelWithPoint: (CGPoint)point tags: (NSMutableArray *)tags {
    GHWaterFallLabel *waterFallLabel = [[GHWaterFallLabel alloc]initWithFrame:CGRectMake(point.x, point.y, kScreenWidth, 0)];
    waterFallLabel.tags = tags;
    waterFallLabel.point = point;
    return waterFallLabel;
}


- (void)configuration {
    self.maxHeight = 100;
    self.isMultiple = NO;
}
- (void)setTags:(NSMutableArray *)tags {
    _tags = tags;
    
    for (GHLabel *label in self.labels) {
        [label removeFromSuperview];
    }

    for (NSInteger index = 0; index < tags.count; index++) {
        GHLabel *tag = [[GHLabel alloc]init];
        tag.text = [self.tags by_ObjectAtIndex:index];
        [self.labels addObject:tag];
    }
    
    for (NSInteger index = 0;index < self.labels.count ;index++) {
        
        GHLabel *tag = [self.labels by_ObjectAtIndex:index];
        tag.font = [UIFont systemFontOfSize:16];
        tag.layer.masksToBounds = YES;
        tag.layer.cornerRadius = 5;
        tag.textAlignment = NSTextAlignmentCenter;
        tag.normalColor = [UIColor whiteColor];
        tag.seletedColor = [UIColor lightGrayColor];

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
    
    GHLabel *tag = self.labels.lastObject;
    CGFloat maxHeight = tag.y + tag.height + 5;
    
    self.contentSize = CGSizeMake(0, maxHeight);
    
    if (maxHeight > kScreenHeight - self.point.y) {
        maxHeight = kScreenHeight- self.point.y;
    }
    
    self.height = maxHeight;
    
    self.maxHeight = maxHeight;
    
    if (self.heightBlock) {
        self.heightBlock(maxHeight);
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    
    GHLabel *label = (GHLabel *)gesture.view;
    
    if (self.isMultiple) {
        label.isSeleted = !label.isSeleted;
        [self.multipleArray removeAllObjects];
        for (GHLabel *subLabel in self.labels) {
            if (subLabel.isSeleted) {
                [self.multipleArray addObject:subLabel.text];
            }
        }
        if (self.multipleBlock) {
            self.multipleBlock(self, self.multipleArray.copy);
        }
    } else {
        if (self.currentIndex != label.tag) {
            self.currentIndex = label.tag;
            if (label.isSeleted) {
                label.isSeleted = NO;
            } else {
                for (GHLabel *subLabel in self.labels) {
                    subLabel.isSeleted = NO;
                }
                label.isSeleted = YES;
            }
        } else {
            self.currentIndex = MAXFLOAT;
            if (label.isSeleted) {
                label.isSeleted = NO;
            } else {
                label.isSeleted = YES;
            }
        }
    }
  
    
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

- (NSMutableArray *)multipleArray {
    if (_multipleArray == nil) {
        _multipleArray = [NSMutableArray array];
    }
    return _multipleArray;
}

- (CGFloat)getHeightWithArray: (NSArray *)array {
    CGFloat height = 0;
    for (NSInteger index = 0;index < array.count ;index++) {
        
        GHLabel *tag = [array by_ObjectAtIndex:index];
        
        CGSize tagSize = [tag sizeThatFits:CGSizeMake(MAXFLOAT,16)];
        // 取出上一个tag
        UILabel *lastTag = [array by_ObjectAtIndex:index -1];
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
        if (index == array.count - 1) {
            height = tag.y + tag.height;
        }
    }
    return height;
}

@end
