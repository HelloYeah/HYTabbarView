//
//  HYTabbarView.m
//  标签栏视图-多视图滑动点击切换
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "HYTabbarView.h"
#import "HYTabbarCollectionCell.h"
#import "HYTopBar.h"

static CGFloat const topBarHeight = 40; //顶部标签条的高度
@interface HYTabbarView () <UICollectionViewDataSource,UICollectionViewDelegate,HYTopBarDelegate>

@property (nonatomic,strong) NSMutableArray *subViewControllers;
@property (nonatomic,strong) HYTopBar *tabbar;
@property (nonatomic,strong) UICollectionView *contentView;
@property (nonatomic,assign) CGFloat tabbarWidth; //顶部标签条的宽度

@end

@implementation HYTabbarView

#pragma mark - ************************* 重写构造方法 *************************
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubview];
    }
    return self;
}

#pragma mark -   ************************* UI处理 *************************
//添加子控件
- (void)setUpSubview{
    
    self.tabbar = [[HYTopBar alloc] initWithFrame:CGRectMake(0, 0, HYScreenW, topBarHeight)];
    [self addSubview:self.tabbar];
    self.tabbar.backgroundColor = [UIColor orangeColor];
    self.tabbar.topBarDelegate = self;
    
    [self addSubview:self.contentView];
}

#pragma mark - ************************* 代理方法 *************************
//CollectionViewDataSource方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.subViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYTabbarCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYTabbarCollectionCell" forIndexPath:indexPath];

    cell.subVc = self.subViewControllers[indexPath.row] ;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.tabbar setSelectedItem:indexPath.item];

}

//HYTopBarDelegate方法
- (void)HYTopBarChangeSelectedItem:(HYTopBar *)topbar selectedIndex:(NSInteger)index {
    
    self.contentView.contentOffset = CGPointMake(HYScreenW * index, 0);
}

#pragma mark - ************************* 对外接口 *************************
//外界传个控制器,添加一个栏目
- (void)addSubItemWithViewController:(UIViewController *)viewController{
    
    [self.tabbar addTitleBtn:viewController.title];
    [self.subViewControllers addObject:viewController];
    [self.contentView reloadData];
}

- (void)selectNewItem{
    
    NSInteger index = self.subViewControllers.count - 1;
    self.contentView.contentOffset = CGPointMake(HYScreenW * (index - 1), 0);
    [self.contentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

#pragma mark - ************************* 懒加载 *************************
- (NSMutableArray *)subViewControllers{
    
    if (!_subViewControllers) {
        _subViewControllers = [NSMutableArray array];
    }
    return _subViewControllers;
}

- (UICollectionView *)contentView {
    
    if (!_contentView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置layout 属性
        layout.itemSize = (CGSize){self.bounds.size.width,(self.bounds.size.height - topBarHeight)};
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        
        _contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, topBarHeight, HYScreenW, HYScreenH - topBarHeight - 64) collectionViewLayout:layout];
        
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.dataSource = self;
        _contentView.delegate = self;
        //注册cell
        [_contentView registerClass:[HYTabbarCollectionCell class] forCellWithReuseIdentifier:@"HYTabbarCollectionCell"];
    }
    return _contentView;
}
@end
