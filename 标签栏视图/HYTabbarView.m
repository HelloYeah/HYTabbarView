//
//  HYTabbarView.m
//  标签栏视图-多视图滑动点击切换
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "HYTabbarView.h"
#import "HYTabbarCollectionCell.h"

//#define  topBarHeight FitWidth(30)//顶部标签条的高度
@interface HYTabbarView () <UICollectionViewDataSource,UICollectionViewDelegate,HYTopBarDelegate>

@property (nonatomic,strong) NSMutableArray *subViewControllers;
@property (nonatomic,strong) UICollectionView *contentView;
@property (nonatomic,assign) CGFloat tabbarWidth; //顶部标签条的宽度

@property(nonatomic, strong)UICollectionViewFlowLayout *layout;

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
    
    self.topBar = [[HYTopBar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.topBar];
    self.topBar.backgroundColor = [UIColor whiteColor];
    self.topBar.topBarDelegate = self;
    
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


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSInteger index = (collectionView.contentOffset.x + collectionView.bounds.size.width * 0.5) / collectionView.bounds.size.width;
    [self.topBar setSelectedItem:index];
}


//HYTopBarDelegate方法
- (void)HYTopBarChangeSelectedItem:(HYTopBar *)topbar selectedIndex:(NSInteger)index {
    
    self.contentView.contentOffset = CGPointMake(HYScreenW * index, 0);
}

-(void)HYTopBarChangeContentViewHeight{
    self.layout.itemSize = (CGSize){self.bounds.size.width,(self.frame.size.height - self.topBar.topBarHeight - self.controllerWithTopBarMargin)};
    _contentView.frame = CGRectMake(0, self.topBar.topBarHeight + self.controllerWithTopBarMargin, HYScreenW, self.layout.itemSize.height);
}
#pragma mark - ************************* 对外接口 *************************


//外界传个控制器,添加一个栏目
- (void)addSubItemWithViewController:(UIViewController *)viewController{
    
    [self.topBar addTitleBtn:viewController.title];
    [self.topBar setSelectedItem:0];
    [self.subViewControllers addObject:viewController];
    [self.contentView reloadData];
}

- (void)selectNewItem{
    
    NSInteger index = self.subViewControllers.count - 1;
    self.contentView.contentOffset = CGPointMake(HYScreenW * (index - 1), 0);
    [self.contentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

#pragma mark - ************************* 懒加载 *************************
-(void)setControllerWithTopBarMargin:(CGFloat)controllerWithTopBarMargin{
    _controllerWithTopBarMargin = controllerWithTopBarMargin;
    self.layout.itemSize = (CGSize){self.bounds.size.width,(self.frame.size.height - self.topBar.topBarHeight - self.controllerWithTopBarMargin)};
    _contentView.frame = CGRectMake(0, self.topBar.topBarHeight + self.controllerWithTopBarMargin, HYScreenW, self.layout.itemSize.height);
    
}
- (NSMutableArray *)subViewControllers{
    
    if (!_subViewControllers) {
        _subViewControllers = [NSMutableArray array];
    }
    return _subViewControllers;
}

- (UICollectionView *)contentView {
    
    if (!_contentView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        self.layout = layout;
        //设置layout 属性
        layout.itemSize = (CGSize){self.bounds.size.width,(self.frame.size.height - self.topBar.topBarHeight - self.controllerWithTopBarMargin)};
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        
        _contentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.topBar.topBarHeight + self.controllerWithTopBarMargin, HYScreenW, layout.itemSize.height) collectionViewLayout:layout];
        
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
