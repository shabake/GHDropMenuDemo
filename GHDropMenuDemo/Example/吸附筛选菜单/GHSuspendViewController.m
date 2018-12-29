//
//  GHSuspendViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/29.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHSuspendViewController.h"
#import "GHDropMenu.h"
#import "GHSuspendHeader.h"
#define kHeaderHeight 400

@interface GHSuspendViewController ()<GHDropMenuDelegate,UITableViewDataSource,UITableViewDelegate,GHDropMenuDelegate>
@property (nonatomic , strong) GHDropMenu *dropMenu;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , strong) GHSuspendHeader *header;

@end

@implementation GHSuspendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.header];
    [self.view bringSubviewToFront:self.header];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}
- (void)back {
    /** 返回时候 需要将菜单收起 */
    [self.dropMenu resetMenuStatus];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = self.tableView.contentOffset.y;
  
    [self.header changeY:-contentOffsetY +kSafeAreaTopHeight - kHeaderHeight];
    if (contentOffsetY >=(kHeaderHeight - 44) - kHeaderHeight) {
        [self.header changeY:-(kHeaderHeight - 44)+ kSafeAreaTopHeight];
    }
    self.dropMenu.tableY = CGRectGetMaxY(self.header.frame);

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor yellowColor]:[UIColor brownColor];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 + kSafeAreaTopHeight, kScreenWidth, kScreenHeight - 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSArray arrayWithObjects:@"学习iOS",@"一定要",@"眼高手低",@"纸上谈兵",@"夸夸二滩",@"多学少练",@"开开心心",@"学习iOS",@"一定要",@"眼高手低",@"纸上谈兵",@"夸夸二滩",@"多学少练",@"开开心心",@"学习iOS",@"一定要",@"眼高手低",@"纸上谈兵",@"夸夸二滩",@"多学少练",@"开开心心" ,nil];
    }
    return _dataArray;
}

- (GHSuspendHeader *)header {
    if (_header == nil) {
        _header = [[GHSuspendHeader alloc]init];
        _header.frame = CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kHeaderHeight);
        GHDropMenuModel *configuration = [[GHDropMenuModel alloc]init];
        /** 配置筛选菜单是否记录用户选中 默认NO */
        configuration.recordSeleted = NO;
        /** 设置数据源 */
        configuration.titles = [configuration creatNormalDropMenuData];
        /** 创建dropMenu 配置模型 && frame */
        weakself(self);
        GHDropMenu *dropMenu = [GHDropMenu creatDropMenuWithConfiguration:configuration frame:CGRectMake(0, kHeaderHeight - 44,kScreenWidth, 44) dropMenuTitleBlock:^(GHDropMenuModel * _Nonnull dropMenuModel) {
            weakSelf.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuModel.title];
        } dropMenuTagArrayBlock:^(NSArray * _Nonnull tagArray) {
    
        }];
    
        dropMenu.delegate = self;
        self.dropMenu = dropMenu;
        [_header addSubview:dropMenu];
    }
    return _header;
}
@end
