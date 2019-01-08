//
//  GHDropMenuTitleItem.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuTitleItem.h"
#import "GHDropMenuModel.h"
#import "UILabel+GHome.h"

@interface GHDropMenuTitleItem()
@property (nonatomic , strong) UILabel *label;
@end
@implementation GHDropMenuTitleItem

- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
  
    CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width / 4;
    if (dropMenuModel.titleSeleted) {
        self.label.textColor = dropMenuModel.titleSeletedColor;
        [self.label creatRichTextWithText:dropMenuModel.title frame:CGRectMake(0, 0, 40, 44) font:[UIFont systemFontOfSize:16] imageName:dropMenuModel.titleSeletedImageName maxWidth:maxWidth];

    } else {
        self.label.textColor = dropMenuModel.titleNormalColor;//
        [self.label creatRichTextWithText:dropMenuModel.title frame:CGRectMake(0, 0, 40, 44) font:[UIFont systemFontOfSize:16] imageName:dropMenuModel.titleNormalImageName maxWidth:maxWidth];
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self configuration];
        self.backgroundColor = [UIColor whiteColor];
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
}
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc]init];
        _label.frame = CGRectMake(10, 0, 80, 44);
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
        _label.numberOfLines = 1;
        _label.lineBreakMode = NSLineBreakByTruncatingHead;  //结尾部分的内容以……方式省略，显示头的文字内容。
    }
    return _label;
}

@end
