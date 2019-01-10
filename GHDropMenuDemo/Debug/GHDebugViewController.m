//
//  GHDebugViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/27.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "GHDebugViewController.h"
#import "UILabel+GHome.h"

@interface GHDebugViewController ()
@property (nonatomic , strong) UILabel *label;
@end

@implementation GHDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"debug";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]init];
    self.label = label;
    [self.view addSubview:label];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}
@end
