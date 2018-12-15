//
//  GHDropMenu.m
//  GHDropMenuDemo
//
//  Created by zhaozhiwei on 2018/12/14.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "GHDropMenu.h"
#import "NSArray+Bounds.h"

@interface  GHDropMenuCell : UITableViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@end
@interface GHDropMenuCell()
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , strong) UIImageView *imgView;

@end
@implementation GHDropMenuCell
- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.title;
    self.title.textColor = dropMenuModel.cellSeleted ? [UIColor orangeColor]:[UIColor darkGrayColor];
    self.imgView.hidden = !dropMenuModel.cellSeleted;

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.title];
    [self addSubview:self.line];
    [self addSubview:self.imgView];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(20, 0, 100, self.frame.size.height);
    self.line.frame = CGRectMake(20, self.frame.size.height - 1, self.frame.size.width - 40, 1);
    self.imgView.frame = CGRectMake(self.frame.size.width - 20 - 15, (self.frame.size.height - 15 ) * 0.5, 15, 15);
}
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"check_selected"];
        _imgView.hidden = YES;
    }
    return _imgView;
}
- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor darkGrayColor];
        _line.alpha = .1;
    }
    return _line;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.font = [UIFont systemFontOfSize:13];
    }
    return _title;
}
@end
@interface GHDropMenuFilterHeader : UICollectionReusableView
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@end
@interface GHDropMenuFilterHeader()
@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UILabel *details;

@end
@implementation GHDropMenuFilterHeader

- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.sectionHeaderTitle;
    self.details.text = dropMenuModel.sectionHeaderDetails;

}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubview:self.title];
    [self addSubview:self.details];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(10, 0, 100, self.frame.size.height);
    self.details.frame = CGRectMake(self.frame.size.width - 100, 0, 100, self.frame.size.height);

}
- (UILabel *)details {
    if (_details == nil) {
        _details = [[UILabel alloc]init];
        _details.textAlignment = NSTextAlignmentRight;
        _details.userInteractionEnabled = YES;
        _details.font = [UIFont boldSystemFontOfSize:11];
        _details.textColor = [UIColor orangeColor];
    }
    return _details;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.userInteractionEnabled = YES;
        _title.font = [UIFont boldSystemFontOfSize:14];
        _title.textColor = [UIColor darkGrayColor];
    }
    return _title;
}
@end
@class GHDropMenuFilterItem,GHDropMenuModel;
@protocol GHDropMenuFilterItemDelegate <NSObject>
- (void)dropMenuFilterItem: (GHDropMenuFilterItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel;
@end

@interface GHDropMenuFilterItem : UICollectionViewCell
@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <GHDropMenuFilterItemDelegate>delegate;
@end
@interface GHDropMenuFilterItem()
@property (nonatomic , strong) UILabel *title;

@end
@implementation GHDropMenuFilterItem
- (void)setDropMenuModel:(GHDropMenuModel *)dropMenuModel {
    _dropMenuModel = dropMenuModel;
    self.title.text = dropMenuModel.tagName;
    self.title.backgroundColor = dropMenuModel.tagSeleted ? [UIColor orangeColor]:[UIColor whiteColor];
    self.title.textColor = dropMenuModel.tagSeleted ?[UIColor whiteColor]:[UIColor darkGrayColor];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)changeColor {
    if (self.dropMenuModel.tagSeleted) {
//        [UIView animateWithDuration:.3 animations:^{
//            self.title.backgroundColor =  [UIColor orangeColor];
//            self.title.textColor = [UIColor whiteColor];
//        } completion:^(BOOL finished) {
//
//        }];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);

}

- (void)setupUI {
    [self addSubview:self.title];

}
- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenuFilterItem:dropMenuModel:)]) {
        [self.delegate dropMenuFilterItem:self dropMenuModel:self.dropMenuModel];
    }
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.userInteractionEnabled = YES;
        _title.text = @"1";
        _title.layer.masksToBounds = YES;
        _title.layer.cornerRadius = 10;
        _title.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _title.layer.borderWidth = 0.5;
        _title.font = [UIFont systemFontOfSize:13];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTouchesRequired = 1; //手指数
        tap.numberOfTapsRequired = 1; //tap次数
        [_title addGestureRecognizer:tap];
        
    }
    return _title;
}
@end
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
    self.title.textColor = dropMenuModel.titleSeleted ?[UIColor orangeColor]:[UIColor darkGrayColor];
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
        _line.alpha = 0.1;
    }
    return _line;
}
- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.userInteractionEnabled = YES;
        _title.font = [UIFont systemFontOfSize:13];
        _title.textColor = [UIColor darkGrayColor];
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
typedef NS_ENUM (NSUInteger,GHDropMenuButtonType ) {
    GHDropMenuButtonTypeSure = 1,
    GHDropMenuButtonTypeReset,
};
@interface GHDropMenu()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,GHDropMenuItemDelegate,GHDropMenuFilterItemDelegate>

@property (nonatomic , strong) NSMutableArray *titles;
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) NSMutableArray *contents;
@property (nonatomic , assign) CGFloat menuHeight;
@property (nonatomic , strong) UIView *topLine;
@property (nonatomic , strong) UIView *bottomLine;
@property (nonatomic , assign) NSInteger currentIndex;
/** 筛选器 */
@property (nonatomic , strong) UICollectionView *filter;
@property (nonatomic , strong) UICollectionViewFlowLayout *filterFlowLayout;
/** 重置 */
@property (nonatomic , strong) UIButton *reset;
/** 确定 */
@property (nonatomic , strong) UIButton *sure;
/** 遮罩 */
@property (nonatomic , strong) UIControl *cover;

@end
@implementation GHDropMenu

#define kFilterButtonHeight 44
#define kFilterButtonWidth 44

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
        [UIView animateWithDuration:.3 animations:^{
            self.collectionView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, configuration.menuHeight);
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
    
    GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];
    self.backgroundColor = [UIColor clearColor];
    
    if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
        self.cover.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        self.cover.backgroundColor = [UIColor clearColor];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
    
        if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeTitle /** 普通菜单 */) {
            self.tableView.frame = CGRectMake(0, self.menuHeight, self.configuration.frame.size.width, 0);
//            self.backgroundColor = [UIColor clearColor];

        } else if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
//            self.filter.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
//            self.cover.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
//            self.cover.backgroundColor = [UIColor clearColor];

        }

    } completion:^(BOOL finished) {

        [self.tableView reloadData];
    }];
    
}

#pragma mark - 弹出菜单
- (void)show {
    [self.tableView reloadData];
    [self.filter reloadData];
    
    GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];
    
    self.tableView.frame = CGRectMake(0, self.menuHeight, self.configuration.frame.size.width, 0);
    self.backgroundColor = [UIColor clearColor];

    if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
        self.cover.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeTitle /** 普通菜单 */) {
            self.tableView.frame = CGRectMake(0, self.menuHeight, self.configuration.frame.size.width, dropMenuTitleModel.dataArray.count * 44);
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];

        } else if (dropMenuTitleModel.dropMenuType == GHDropMenuTypeFilter /** 筛选菜单 */) {
//            self.filter.frame = CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, kScreenHeight - kFilterButtonHeight);
//            self.cover.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//            self.cover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        }

    } completion:^(BOOL finished) {
    }];
 
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, self.menuHeight);
    self.topLine.frame = CGRectMake(0, 0, kScreenWidth, 1);
    self.bottomLine.frame = CGRectMake(0, self.menuHeight - 1, kScreenWidth, 1);
}
#pragma mark - 创建UI
- (void)setupUI {
    [self addSubview:self.collectionView];
    [kKeyWindow addSubview:self.cover];
    [self.cover addSubview:self.filter];
    [self.cover addSubview:self.sure];
    [self.cover addSubview:self.reset];
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
- (void)dropMenuFilterItem: (GHDropMenuFilterItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];
    GHDropMenuModel *dropMenuSectionModel = dropMenuTitleModel.sections[dropMenuModel.indexPath.section];
    for (GHDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
        dropMenuTagModel.tagSeleted = NO;
    }
    dropMenuModel.tagSeleted = !dropMenuModel.tagSeleted;
    dropMenuSectionModel.sectionHeaderDetails = dropMenuModel.tagName;
    [self.filter reloadData];
}

- (void)dropMenuItem:(GHDropMenuItem *)item dropMenuModel:(GHDropMenuModel *)dropMenuModel {
    dropMenuModel.titleSeleted = !dropMenuModel.titleSeleted;
    self.currentIndex = dropMenuModel.indexPath.row;
    if (dropMenuModel.titleSeleted) {
        self.contents = dropMenuModel.dataArray.copy;
        /** 取出数组 展示*/
        for (GHDropMenuModel *model in self.titles) {
            if (model.identifier != dropMenuModel.identifier) {
                model.titleSeleted = NO;
            }
        }
        [self show];
    } else {
        [self dismiss];
    }
//    [self.collectionView reloadData];

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
    GHDropMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GHDropMenuCellID"];
    cell.dropMenuModel = dropMenuModel;
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
    for (GHDropMenuModel *dropMenuContentModel  in dropMenuModel.dataArray) {
        dropMenuContentModel.cellSeleted = NO;
    }
    GHDropMenuModel *contentModel = dropMenuModel.dataArray[indexPath.row];
    dropMenuModel.title = contentModel.title;
    contentModel.cellSeleted = !contentModel.cellSeleted;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:dropMenuModel:tagArray:)]) {
        [self.delegate dropMenu:self dropMenuModel:contentModel tagArray:@[]];
    }
    [self resetMenuStatus];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.filter == collectionView) {
        return CGSizeMake(kScreenWidth * 0.8, 44);
    } else {
        return CGSizeZero;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];
    GHDropMenuModel *dropMenuSectionModel = dropMenuTitleModel.sections[indexPath.section];
    dropMenuSectionModel.indexPath = indexPath;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && self.filter == collectionView) {
        GHDropMenuFilterHeader *header  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"GHDropMenuFilterHeaderID" forIndexPath:indexPath];
        header.dropMenuModel = dropMenuSectionModel;
        return header;
    } else {
        return [UICollectionReusableView new];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        return CGSizeMake(kScreenWidth /self.titles.count, self.menuHeight - 0.01f);
    } else if (collectionView == self.filter) {
        return CGSizeMake((kScreenWidth * 0.8 - 4 * 10) / 3.01f, 30.01f);
    } else {
        return CGSizeZero;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];
    if (self.filter == collectionView) {
        return dropMenuTitleModel.sections.count;
    } else if (collectionView == self.collectionView){
        return 1;
    } else {
        return 0;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (self.collectionView == collectionView) {
        return self.titles.count;
    } else if (self.filter == collectionView) {
        GHDropMenuModel *dropMenuModel = self.titles[self.currentIndex];
        return dropMenuModel.dataArray.count;
    } else {
        return 10;
    }
}
#pragma mark - 返回collectionView item
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (collectionView == self.collectionView) {
        GHDropMenuModel *dropMenuModel = self.titles[indexPath.row];
        dropMenuModel.indexPath = indexPath;
        GHDropMenuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDropMenuItemID" forIndexPath:indexPath];
        cell.dropMenuModel = dropMenuModel;
        cell.delegate = self;
        return cell;
    } else if (collectionView == self.filter) {
        GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];
        GHDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex:indexPath.section];
        GHDropMenuModel *dropMenuTagModel = [dropMenuSectionModel.dataArray by_ObjectAtIndex:indexPath.row];
        dropMenuTagModel.indexPath = indexPath;
        GHDropMenuFilterItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GHDropMenuFilterItemID" forIndexPath:indexPath];
        cell.dropMenuModel = dropMenuTagModel;
        cell.delegate = self;
        return cell;
    } else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    }
 
}

- (void)tap: (UITapGestureRecognizer *)gesture {
    [self resetMenuStatus];
}
- (void)clickButton: (UIButton *)button {
    GHDropMenuModel *dropMenuTitleModel = self.titles[self.currentIndex];

    if (button.tag == GHDropMenuButtonTypeSure) {
        [self resetMenuStatus];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (GHDropMenuModel *dropMenuSectionModel in dropMenuTitleModel.sections) {
            for (GHDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
                if (dropMenuTagModel.tagSeleted) {
                    [dataArray addObject:dropMenuTagModel];
                }
            }
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:dropMenuModel:tagArray:)]) {
            [self.delegate dropMenu:self dropMenuModel:nil tagArray:dataArray.copy];
        }
    } else if (button.tag == GHDropMenuButtonTypeReset){
        for (GHDropMenuModel *dropMenuSectionModel in dropMenuTitleModel.sections) {
            for (GHDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
                dropMenuTagModel.tagSeleted = NO;
            }
        }
        [self.filter reloadData];
    }
}
- (void)clickControl {
    [self resetMenuStatus];
}
#pragma mark - 懒加载
- (UIControl *)cover {
    if (_cover == nil) {
        _cover = [[UIControl alloc]init];
        _cover.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [_cover addTarget:self action:@selector(clickControl) forControlEvents:UIControlEventTouchUpInside];

    }
    return _cover;
}
- (UIButton *)reset {
    if (_reset == nil) {
        _reset = [[UIButton alloc]init];
        _reset.frame = CGRectMake(self.filter.frame.origin.x, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        _reset.backgroundColor = [UIColor whiteColor];
        [_reset setTitle:@"重置" forState:UIControlStateNormal];
        [_reset setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_reset addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _reset.tag = GHDropMenuButtonTypeReset;
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = .1;
        line.frame = CGRectMake(0, 0, _reset.frame.size.width, 1);
        [_reset addSubview:line];
    }
    return _reset;
}
- (UIButton *)sure {
    if (_sure == nil) {
        _sure = [[UIButton alloc]init];
        _sure.frame = CGRectMake(kScreenWidth - self.filter.frame.size.width * 0.5, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        _sure.backgroundColor = [UIColor orangeColor];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.tag = GHDropMenuButtonTypeSure;
        [_sure addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sure;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[GHDropMenuCell class] forCellReuseIdentifier:@"GHDropMenuCellID"];
    }
    return _tableView;
}
- (UICollectionViewFlowLayout *)filterFlowLayout {
    if (_filterFlowLayout == nil) {
        _filterFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _filterFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _filterFlowLayout.minimumLineSpacing = 10.01f;
        _filterFlowLayout.minimumInteritemSpacing = 10.01f;
    }
    return _filterFlowLayout;
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

- (UICollectionView *)filter {
    if (_filter == nil) {
        _filter = [[UICollectionView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, kScreenHeight - kFilterButtonHeight) collectionViewLayout:self.filterFlowLayout];
        _filter.delegate = self;
        _filter.dataSource = self;
        _filter.backgroundColor = [UIColor whiteColor];
        [_filter registerClass:[GHDropMenuFilterItem class] forCellWithReuseIdentifier:@"GHDropMenuFilterItemID"];
        [_filter registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        _filter.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [_filter registerClass:[GHDropMenuFilterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GHDropMenuFilterHeaderID"];
    }
    return _filter;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 0) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[GHDropMenuItem class] forCellWithReuseIdentifier:@"GHDropMenuItemID"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
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
        _bottomLine.backgroundColor = [UIColor darkGrayColor];
        _bottomLine.alpha = .1;
    }
    return _bottomLine;
}
- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = [UIColor darkGrayColor];
        _topLine.alpha = .1;
    }
    return _topLine;
}
@end
