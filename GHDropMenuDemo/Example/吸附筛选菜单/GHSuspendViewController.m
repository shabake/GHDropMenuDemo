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
#import "GHSuspendItem.h"

#define kHeaderHeight 400

@interface GHSuspendViewController ()<GHDropMenuDelegate,UITableViewDataSource,UITableViewDelegate,GHDropMenuDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) GHDropMenu *dropMenu;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , strong) GHSuspendHeader *header;
@property (nonatomic , strong) UICollectionView *collectionView ;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout ;

@end

@implementation GHSuspendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.view  addSubview:self.collectionView];
    [self.view addSubview:self.header];
    [self.view bringSubviewToFront:self.header];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton *change = [[UIButton alloc]init];
    [change setTitle:@"tableView" forState:UIControlStateNormal];
    [change setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [change setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [change setTitle:@"collectionView" forState:UIControlStateSelected];
    [change addTarget:self action:@selector(clickChange:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:change];
    [self clickChange:change];
}
- (void)clickChange : (UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        self.collectionView.hidden = NO;
        
    } else {
        self.collectionView.hidden = YES;
    }
    self.tableView.hidden = ! self.collectionView.hidden;
    [self.tableView reloadData];
    [self.collectionView reloadData];

}
- (void)back {
    /** 返回时候 需要将菜单收起 */
    [self.dropMenu resetMenuStatus];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    [self.header changeY:-contentOffsetY +kSafeAreaTopHeight - kHeaderHeight];
    if (contentOffsetY >=(kHeaderHeight - 44) - kHeaderHeight) {
        [self.header changeY:-(kHeaderHeight - 44)+ kSafeAreaTopHeight];
    }
    self.dropMenu.tableY = CGRectGetMaxY(self.header.frame);

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHSuspendItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHSuspendItemID" forIndexPath:indexPath];
    cell.title.text = [NSString stringWithFormat:@"我是collectionView:%@",self.dataArray[indexPath.row]];

    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor redColor]:[UIColor purpleColor];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击collectionView");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"我是tableView:%@",self.dataArray[indexPath.row]];
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor yellowColor]:[UIColor brownColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击tableView");
}
#pragma mark - 代理方法;
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuTitleModel:(GHDropMenuModel *)dropMenuTitleModel {
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",dropMenuTitleModel.title];
}
- (void)dropMenu:(GHDropMenu *)dropMenu tagArray:(NSArray *)tagArray {
    [self getStrWith:tagArray];
}

- (void)getStrWith: (NSArray *)tagArray {
    NSMutableString *string = [NSMutableString string];
    if (tagArray.count) {
        for (GHDropMenuModel *dropMenuTagModel in tagArray) {
            if (dropMenuTagModel.tagSeleted) {
                if (dropMenuTagModel.tagName.length) {
                    [string appendFormat:@"%@",dropMenuTagModel.tagName];
                }
            }
            if (dropMenuTagModel.maxPrice.length) {
                [string appendFormat:@"最大价格%@",dropMenuTagModel.maxPrice];
            }
            if (dropMenuTagModel.minPrice.length) {
                [string appendFormat:@"最小价格%@",dropMenuTagModel.minPrice];
            }
        }
    }
    self.navigationItem.title = [NSString stringWithFormat:@"筛选结果: %@",string];
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.itemSize = CGSizeMake(kScreenWidth, 44);
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.01f;

    }
    return _flowLayout;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 + kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight) collectionViewLayout:self.flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[GHSuspendItem class] forCellWithReuseIdentifier:@"GHSuspendItemID"];
    }
    return _collectionView;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 + kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaTopHeight) style:UITableViewStylePlain];
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
