//
//  ViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import "ViewController.h"
#import "GHComplexMenuViewController.h"
#import "GHSlipMenuViewController.h"
#import "GHNormalMenuViewController.h"
#import "GHSuspendViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view = self.tableView;
    self.navigationItem.title = @"筛选菜单";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *navTitle = self.dataArray[indexPath.row];
    if (indexPath.row == 0) {
        GHComplexMenuViewController *vc = [[GHComplexMenuViewController alloc]init];
        vc.navTitle = navTitle;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 1) {
        GHSlipMenuViewController *vc = [[GHSlipMenuViewController alloc]init];
        vc.navTitle = navTitle;

        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        GHNormalMenuViewController *vc = [[GHNormalMenuViewController alloc]init];
        vc.navTitle = navTitle;

        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        GHSuspendViewController *vc = [[GHSuspendViewController alloc]init];
        vc.navTitle = navTitle;

        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"复杂筛选菜单",@"只有侧滑筛选菜单",@"普通筛选菜单",@"悬浮筛选菜单(tableView)",@"流水菜单",nil];
    }
    return _dataArray;
}
@end
