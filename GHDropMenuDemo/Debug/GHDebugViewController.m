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
    [self.tags addObject:@"一个"];
    [self.tags addObject:@"Fl"];
    [self.tags addObject:@"当wi"];
    [self.tags addObject:@"现代"];
    [self.tags addObject:@"现式框"];
    [self.tags addObject:@"现代响"];
    [self.tags addObject:@"现应"];
    [self.tags addObject:@"现"];
    [self.tags addObject:@"现响应"];
    [self.tags addObject:@"现代框架"];
    [self.tags addObject:@"现代响应"];
    [self.tags addObject:@"现框架"];
    [self.tags addObject:@"当w"];


    [self.tags addObject:@"Fl建"];
    [self.tags addObject:@"asdsa"];
    
    GHWaterFallLabel *waterFallLabel = [GHWaterFallLabel creatWaterFallLabelWithPoint:CGPointMake(0, 0) tags:self.tags];
  
    [self.view addSubview:waterFallLabel];
   
    waterFallLabel.backgroundColor = [UIColor redColor];
    waterFallLabel.heightBlock = ^(GHWaterFallLabel * _Nonnull waterFallLabel, CGFloat height, CGPoint point) {

        if (height > [UIScreen mainScreen].bounds.size.height - point.y) {
            height = [UIScreen mainScreen].bounds.size.height - point.y;
        }
        waterFallLabel.height = height;
    };
    
    waterFallLabel.textBlock = ^(NSString * _Nonnull text, NSInteger index) {
      
        self.waterFallLabel.tags = self.tags;
    };
    self.waterFallLabel = waterFallLabel;
}



- (NSMutableArray *)tags {
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
@end
