//
//  GHSuspendItem.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/29.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHSuspendItem.h"
@interface GHSuspendItem()
@end
@implementation GHSuspendItem

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.title];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(10, 0, self.frame.size.width, self.frame.size.height);
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
    }
    return _title;
}
@end
