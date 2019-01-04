//
//  GHDropMenuTitleItem.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuTitleItem.h"
#import "GHDropMenuModel.h"

@interface GHDropMenuTitleItem()
@property (nonatomic , strong) UILabel *label;
@property (nonatomic , strong) UIImageView *imageView;
@end
@implementation GHDropMenuTitleItem

- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.label.text = dropMenuModel.title;
    self.label.font = dropMenuModel.titleFont;
    if (dropMenuModel.titleSeleted) {
        self.imageView.image = [UIImage imageNamed:dropMenuModel.titleSeletedImageName];
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        self.label.textColor = dropMenuModel.titleSeletedColor;
    } else {
        self.imageView.image = [UIImage imageNamed:dropMenuModel.titleNormalImageName];
        self.imageView.transform = CGAffineTransformMakeRotation(0);
        self.label.textColor = dropMenuModel.titleNormalColor;
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        [self setupUI];
        [self configuration];
    }
    return self;
}
- (void)configuration {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];    
    [self addGestureRecognizer:tap];
}
- (void)tap:(UITapGestureRecognizer *)gesture {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuTitleItem:dropMenuModel:)]) {
        [self.delegate dropMenuTitleItem:self dropMenuModel:self.dropMenuModel];
    }
}
- (void)setupUI {
    [self addSubview:self.label];
    [self addSubview:self.imageView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(self.label.frame.size.width + 3, (self.bounds.size.height - 8 ) *.5, 10, 8);
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(CGRectGetMaxX(self.label.frame), 0, 10, 8);
    }
    return _imageView;
}
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc]init];
        _label.frame = CGRectMake(10, 0, 80, 44);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor darkGrayColor];
        _label.backgroundColor = [UIColor whiteColor];
        _label.layer.borderColor = [UIColor clearColor].CGColor;
    }
    return _label;
}

@end
