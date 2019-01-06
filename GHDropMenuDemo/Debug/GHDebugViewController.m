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
    [label creatRichTextWithText:@"达阿达阿达阿达阿达阿达阿r" frame:CGRectMake(0, 100, 40, 30)  font:[UIFont systemFontOfSize:16] imageName:@"down_normal"];
    [self.view addSubview:label];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.label setText:@"122" imageName:@"up_normal"];
    
}
@end
