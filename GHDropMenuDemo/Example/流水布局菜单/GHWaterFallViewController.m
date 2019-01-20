//
//  GHWaterFallViewController.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2019/1/19.
//  Copyright © 2019年 GHome. All rights reserved.
//

#import "GHWaterFallViewController.h"
#import "GHDropMenuHeader.h"
#import "GHWaterFallCell.h"

@interface GHWaterFallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** 顶部菜单 */
@property (nonatomic , strong) UICollectionView *collectionView;
/** 顶部菜单布局 */
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation GHWaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GHWaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHWaterFallCellID" forIndexPath:indexPath];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kGHScreenWidth,  kGHScreenHeight);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.01f;
        _flowLayout.itemSize = CGSizeMake(kGHScreenWidth, 100);
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kGHSafeAreaTopHeight, kGHScreenWidth, kGHScreenHeight - kGHSafeAreaTopHeight - kGHSafeAreaBottomHeight) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderColor = [UIColor clearColor].CGColor;
        [_collectionView registerClass:[GHWaterFallCell class] forCellWithReuseIdentifier:@"GHWaterFallCellID"];
    }
    return _collectionView;
}


@end
