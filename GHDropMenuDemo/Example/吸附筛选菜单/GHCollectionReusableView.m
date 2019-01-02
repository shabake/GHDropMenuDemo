//
//  GHCollectionReusableView.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/2.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHCollectionReusableView.h"

@implementation GHCollectionReusableView
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
