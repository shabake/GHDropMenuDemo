//
//  GHSuspendHeader.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/29.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHSuspendHeader.h"

@implementation GHSuspendHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (void)changeY:(CGFloat)y {
    self.frame = CGRectMake(0, y, self.frame.size.width, self.frame.size.height);
}
@end
