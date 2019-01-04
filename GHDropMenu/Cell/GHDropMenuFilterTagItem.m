//
//  GHDropMenuFilterTagItem.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/4.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHDropMenuFilterTagItem.h"
#import "GHDropMenuModel.h"

@interface GHDropMenuFilterTagItem()
@property (nonatomic , strong) UILabel *title;
@end
@implementation GHDropMenuFilterTagItem

- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.tagName;
    self.title.backgroundColor = dropMenuModel.tagSeleted ? [UIColor orangeColor]:[UIColor whiteColor];
    self.title.textColor = dropMenuModel.tagSeleted ?[UIColor whiteColor]:[UIColor darkGrayColor];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
    
}
- (void)setupUI {
    [self addSubview:self.title];
    
}
- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterTagItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterTagItem:self dropMenuModel:self.dropMenuModel];
    }
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.userInteractionEnabled = YES;
        _title.text = @"1";
        _title.layer.masksToBounds = YES;
        _title.layer.cornerRadius = 10;
        _title.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _title.layer.borderWidth = 0.5;
        _title.font = [UIFont systemFontOfSize:13];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [_title addGestureRecognizer:tap];
        
    }
    return _title;
}
@end
