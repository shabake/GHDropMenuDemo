//
//  GHDebugViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/27.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "GHDebugViewController.h"
struct MyDate1 {
    
    int year;
    int month;
    NSString *day;
    NSArray *a;

};
@interface GHDebugViewController ()

@end

@implementation GHDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    struct MyDate1 d1 = {2016, 1, @"2",@[@1,@2]};
    NSLog(@"%d",d1.year);
    NSLog(@"%@",d1.a);

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
