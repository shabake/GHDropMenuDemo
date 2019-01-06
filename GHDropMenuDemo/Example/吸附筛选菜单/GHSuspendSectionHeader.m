//
//  GHSuspendSectionHeader.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/6.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHSuspendSectionHeader.h"

@implementation GHSuspendSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
