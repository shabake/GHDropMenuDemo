//
//  GHDebugViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/27.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "GHDebugViewController.h"

@interface GHDebugViewController ()

@end

@implementation GHDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"debug";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 100)];
    [path addLineToPoint:CGPointMake(50, 100)];
    [path addLineToPoint:CGPointMake(0, 64)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 2.8;
    layer.fillColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
}


@end
