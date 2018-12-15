//
//  GHDropMenu.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHDropMenu.h"

#pragma mark - - - - GHDropMenuItem
@class GHDropMenuItem,GHDropMenuModel;
@protocol GHDropMenuItemDelegate <NSObject>
- (void)dropMenuItem: (GHDropMenuItem *)item dropMenuModel: (GHDropMenuModel *)dropMenuModel;
@end

@interface GHDropMenuItem : UICollectionViewCell
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuItemDelegate> delegate;
@property (nonatomic , strong) UIView *line;

@end
@implementation GHDropMenuItem
- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.title;
    self.title.font = dropMenuModel.titleFont;
    self.title.textColor = dropMenuModel.titleSeleted ?[UIColor redColor]:[UIColor blackColor];
    self.line.backgroundColor = self.title.textColor ;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.title];
    [self.title addSubview:self.line];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = self.bounds;
    self.line.frame = CGRectMake(self.frame.size.width - 1, (self.frame.size.height -self.frame.size.height * 0.2) * 0.5, 1, self.frame.size.height * 0.2);
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuItem:dropMenuModel:)]) {
        [self.delegate dropMenuItem:self dropMenuModel:self.dropMenuModel];
    }
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTouchesRequired = 1; //手指数
        tap.numberOfTapsRequired = 1; //tap次数
        [_title addGestureRecognizer:tap];

    }
    return _title;
}
@end

#pragma mark - - - - GHDropMenuModel

@implementation GHDropMenuModel

@end

#pragma mark - - - - GHDropMenu

@interface GHDropMenu()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,GHDropMenuItemDelegate>

@property (nonatomic , strong) NSMutableArray *titles;
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *contents;
@property (nonatomic , assign) CGFloat menuHeight;
@property (nonatomic , strong) UIView *topLine;
@property (nonatomic , strong) UIView *bottomLine;
@property (nonatomic , assign) NSInteger currentIndex;

@end
@implementation GHDropMenu

#pragma mark - 初始化
- (instancetype)creatDropMenuWithConfiguration: (GHDropMenuModel *)configuration {
    GHDropMenu *dropMenu = [[GHDropMenu alloc]initWithFrame:CGRectMake(0, configuration.frame.origin.y, configuration.frame.size.width, kScreenHeight - configuration.frame.origin.y - kSafeAreaBottomHeight)];
    dropMenu.configuration = configuration;
    return dropMenu;
}
- (void)setTitleViewBackGroundColor:(UIColor *)titleViewBackGroundColor {
    self.backgroundColor = titleViewBackGroundColor;
}
- (void)setConfiguration:(GHDropMenuModel *)configuration {
    _configuration = configuration;
    self.titles = configuration.titles.copy;
    if (configuration.menuHeight) {
        [UIView animateWithDuration:.5 animations:^{
            self.collectionView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, configuration.menuHeight);
            self.topLine.frame = CGRectMake(0, 0, kScreenWidth, 1);
            self.bottomLine.frame = CGRectMake(0, configuration.menuHeight - 1, kScreenWidth, 1);
        } completion:^(BOOL finished) {
            
        }];
        self.menuHeight = configuration.menuHeight;
    }
    if (configuration.titleFont) {
        for (GHDropMenuModel *dropMenuTitleModel in self.titles) {
            dropMenuTitleModel.titleFont = configuration.titleFont;
        }
    }
    [self resetMenuStatus];
}
- (instancetype)init {
    if (self == [super init]) {
        [self setupUI];
        [self defaultConfiguration];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
        [self defaultConfiguration];
    }
    return self;
}
- (void)defaultConfiguration {
    self.backgroundColor = [UIColor clearColor];
    self.menuHeight = 44;
    self.currentIndex = 0;
}
- (void)dismiss {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, self.menuHeight, self.configuration.frame.size.width, 0);
        self.backgroundColor = [UIColor clearColor];

    } completion:^(BOOL finished) {
        [self.tableView reloadData];
    }];
    
}
- (void)show {
    [self.tableView reloadData];
    GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];
    
    self.tableView.frame = CGRectMake(0, self.menuHeight, self.configuration.frame.size.width, 0);
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, self.menuHeight, self.configuration.frame.size.width, dropMenuTitleModel.dataArray.count * 44);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];

    } completion:^(BOOL finished) {
    }];
 
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.menuHeight);
    self.topLine.frame = CGRectMake(0, 0, kScreenWidth, 1);
    self.bottomLine.frame = CGRectMake(0, self.menuHeight - 1, kScreenWidth, 1);

}

- (void)setupUI {
    [self addSubview:self.collectionView];
    [self.collectionView addSubview:self.topLine];
    [self.collectionView addSubview:self.bottomLine];

    [self addSubview:self.tableView];
}

/** 重置menu 状态 */
- (void)resetMenuStatus {
    for (GHDropMenuModel *dropMenuModel in self.titles) {
        dropMenuModel.titleSeleted = NO;
    }
    [self.collectionView reloadData];
    [self dismiss];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resetMenuStatus];
}

- (void)dropMenuItem:(GHDropMenuItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    dropMenuModel.titleSeleted = !dropMenuModel.titleSeleted;
    self.currentIndex = dropMenuModel.indexPath.row;
    if (dropMenuModel.titleSeleted) {
        /** 取出数组 展示*/
        self.contents = dropMenuModel.dataArray.mutableCopy;
        for (GHDropMenuModel *model in self.titles) {
            if (model.identifier != dropMenuModel.identifier) {
                model.titleSeleted = NO;
            }
        }
        [self show];
    } else {
        [self dismiss];
    }
    [self.collectionView reloadData];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *seletedIndexPath = nil;
    for (GHDropMenuModel *dropMenuModel in self.titles) {
        if (dropMenuModel.titleSeleted) {
            seletedIndexPath = dropMenuModel.indexPath;
        }
    }
    GHDropMenuModel *dropMenuTitleModel = self.titles[seletedIndexPath.row];

    GHDropMenuModel *dropMenuModel = dropMenuTitleModel.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.textLabel.text = dropMenuModel.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *seletedIndexPath = nil;
    for (GHDropMenuModel *dropMenuModel in self.titles) {
        if (dropMenuModel.titleSeleted) {
            seletedIndexPath = dropMenuModel.indexPath;
        }
    }
    GHDropMenuModel *dropMenuModel = self.titles[seletedIndexPath.row];
    GHDropMenuModel *contentModel = dropMenuModel.dataArray[indexPath.row];
    dropMenuModel.title = contentModel.title;
 
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:dropMenuModel:)]) {
        [self.delegate dropMenu:self dropMenuModel:contentModel];
    }
    [self resetMenuStatus];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width /self.titles.count, self.menuHeight - 0.01f);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GHDropMenuModel *dropMenuModel = self.titles[indexPath.row];
    dropMenuModel.indexPath = indexPath;
    GHDropMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDropMenuItemID" forIndexPath:indexPath];
    cell.dropMenuModel = dropMenuModel;
    cell.delegate = self;
    return cell;
}

#pragma mark - get
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
    }
    return _tableView;
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.01f;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[GHDropMenuItem class] forCellWithReuseIdentifier:@"GHDropMenuItemID"];
    }
    return _collectionView;
}
- (NSMutableArray *)contents {
    if (_contents == nil) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}
- (NSMutableArray *)titles {
    if (_titles == nil) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor blackColor];
    }
    return _bottomLine;
}
- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = [UIColor blackColor];
    }
    return _topLine;
}
@end
