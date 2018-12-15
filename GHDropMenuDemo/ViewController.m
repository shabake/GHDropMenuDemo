//
//  ViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "ViewController.h"
#import "GHDropMenu.h"

@interface ViewController ()<GHDropMenuDelegate>
@property (nonatomic , strong)GHDropMenu *dropMenu;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSArray *titles = @[@"智能排序",@"价格",@"品牌",@"时间"];
    NSArray *data1 = @[@"价格从高到低",@"价格从低到高"];
    NSMutableArray *dataArray1 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data1.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = data1[index];
        [dataArray1 addObject:dropMenuModel];
    }
    
    NSArray *data2 = @[@"0 - 10 元",@"10-20 元",@"20-50 元",@"50-100 元",@"100 - 1000元"];
    NSMutableArray *dataArray2 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data2.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = data2[index];
        [dataArray2 addObject:dropMenuModel];
    }
    
    NSArray *data3 = @[@"psp",@"psv",@"nswitch"];
    NSMutableArray *dataArray3 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data3.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = data3[index];
        [dataArray3 addObject:dropMenuModel];
    }
    
    NSArray *data4 = @[@"上午"];
    NSMutableArray *dataArray4 = [NSMutableArray array];
    for (NSInteger index = 0 ; index < data4.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = data4[index];
        [dataArray4 addObject:dropMenuModel];
    }
    
    NSMutableArray *titlesArray = [NSMutableArray array];
    for (NSInteger index = 0 ; index < titles.count; index++) {
        GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
        dropMenuModel.title = titles[index];
        if (index == 0) {
            dropMenuModel.dataArray = dataArray1;
        } else if (index == 1) {
            dropMenuModel.dataArray = dataArray2;
        } else if (index == 2) {
            dropMenuModel.dataArray = dataArray3;
        } else if (index == 3) {
            dropMenuModel.dataArray = dataArray4;
        }
        dropMenuModel.identifier = index;
        [titlesArray addObject:dropMenuModel];
    }
    
    GHDropMenuModel *dropMenuModel = [[GHDropMenuModel alloc]init];
    dropMenuModel.frame = CGRectMake(0, kSafeAreaTopHeight, [UIScreen mainScreen].bounds.size.width, 44);
    dropMenuModel.titles = titlesArray.mutableCopy;
    dropMenuModel.menuHeight = 60;

    GHDropMenu *dropMenu = [[GHDropMenu alloc]creatDropMenuWithConfiguration:dropMenuModel];
    dropMenu.delegate = self;
    self.dropMenu = dropMenu;
    
    [self.view addSubview:dropMenu];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(clickButton)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)clickButton {
    [self.dropMenu resetMenuStatus];
}
- (void)dropMenu:(GHDropMenu *)dropMenu dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    NSLog(@"%@",dropMenuModel.title);
}

@end
