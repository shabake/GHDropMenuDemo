//
//  GHDebugViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/27.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "GHDebugViewController.h"
#import "UILabel+GHome.h"
#import "UIView+Extension.h"
#import "NSArray+Bounds.h"
#import "GHWaterFallLabel.h"

@interface GHDebugViewController ()<UIScrollViewDelegate>
@property (nonatomic , strong) GHWaterFallLabel *waterFallLabel;
@property (nonatomic , strong) NSMutableArray *tags;

@end
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width

@implementation GHDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"debug";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tags addObject:@"家"];
    [self.tags addObject:@"同学"];
    [self.tags addObject:@"一个子控件都是定位或不定位"];
    [self.tags addObject:@"Flutter Widget采用现代响应式框架构建"];
    [self.tags addObject:@"当widget的状态发生变化时，widget会重新构建UI，Flutter会对比前后变化的不同， 以确定底层渲染树从一个状态转换到下一个状态所需的"];
    [self.tags addObject:@"现代响应式"];
    [self.tags addObject:@"现代响应式框"];
    [self.tags addObject:@"现代响"];
    [self.tags addObject:@"现代响应"];
    [self.tags addObject:@"现代响应式框架现代响应式框架现代响应式框架"];
    [self.tags addObject:@"现响应式框架"];
    [self.tags addObject:@"现代响应式框架"];
    [self.tags addObject:@"现代响应"];
    [self.tags addObject:@"现响应式框架"];
    [self.tags addObject:@"当widget的状态发生变化时，widget会重新构建UI，Flutter会对状态发生变化时，widget会重新状态发生变化时，widg当widget的状态发生变化时，widget会重新构建UI，Flutter会对状态发生变化时，widget会重新状态发生变化时"];


    [self.tags addObject:@"Flutter Widget采用现代响应式框架构建"];
    [self.tags addObject:@"asdsa"];
    
    GHWaterFallLabel *waterFallLabel = [GHWaterFallLabel creatWaterFallLabelWithFrame:CGRectMake(0, 64, kScreenWidth, 100) tags:self.tags];
    waterFallLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:waterFallLabel];

    waterFallLabel.heightBlock = ^(GHWaterFallLabel * _Nonnull waterFallLabel, CGFloat height) {
        waterFallLabel.contentSize = CGSizeMake(kScreenWidth, height);

        if (height > [UIScreen mainScreen].bounds.size.height - 64) {
            height = [UIScreen mainScreen].bounds.size.height - 64;
        }
        waterFallLabel.height = height;
        NSLog(@"高度%f",height);
    };
    waterFallLabel.textBlock = ^(NSString * _Nonnull text, NSInteger index) {
        [self.tags addObject:@"asdsa"]; [self.tags addObject:@"Flutter Widget采用现代响应式框架构建"];
        [self.tags addObject:@"asdsa"];
        
        [self.tags addObject:@"Flutter Widget采用现代响应式框架构建"];
        [self.tags addObject:@"asdsa"];
        self.waterFallLabel.tags = self.tags;
    };
    self.waterFallLabel = waterFallLabel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tags addObject:@"asdsa"]; [self.tags addObject:@"Flutter Widget采用现代响应式框架构建"];
    [self.tags addObject:@"asdsa"];
    
    [self.tags addObject:@"Flutter Widget采用现代响应式框架构建"];
    [self.tags addObject:@"asdsa"];
    self.waterFallLabel.tags = self.tags;
    
}

- (NSMutableArray *)tags {
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
@end
