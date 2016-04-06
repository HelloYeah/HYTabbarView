//
//  HYTabbarView.m
//  标签栏视图
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//



#import "HYTabbarView.h"

#define HYTabbarViewHeight 49
#define HYContentViewHeight (self.bounds.size.height - HYTabbarViewHeight)
#define HYColumn 5
#define HYScreenW [UIScreen mainScreen].bounds.size.width

@interface HYTabbarView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray * titles;
@property (nonatomic,strong) NSMutableArray * subViewControllers;
@property (nonatomic,weak) UIScrollView * tabbar;
@property (nonatomic,weak) UICollectionView * contentView;
@property (nonatomic,assign) NSInteger  selectedIndex;
@property (nonatomic,assign) NSInteger  prevSelectedIndex;
@property (nonatomic,assign) CGFloat  btnW;

@end

@implementation HYTabbarView

#pragma mark - ************************* 重写构造方法 *************************
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectedIndex = 0;
        [self setUpSubview];
    }
    return self;
}

#pragma mark - ************************* 懒加载 *************************

- (NSMutableArray *)titles{
    
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)subViewControllers{
    
    if (!_subViewControllers) {
        _subViewControllers = [NSMutableArray array];
    }
    return _subViewControllers;
}

#pragma mark -   ************************* UI处理 *************************
//添加子控件
- (void)setUpSubview{
    
    UIScrollView * tabbar = [[UIScrollView alloc]init];
    [self addSubview:tabbar];
    tabbar.showsHorizontalScrollIndicator = NO;
    tabbar.showsVerticalScrollIndicator = NO;
    tabbar.bounces = NO;
    self.tabbar = tabbar;

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置layout 属性
    layout.itemSize = (CGSize){self.bounds.size.width,HYContentViewHeight};
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    UICollectionView * contentView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self addSubview:contentView];
    
    self.contentView = contentView;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.pagingEnabled = YES;
    contentView.bounces = NO;
    
    contentView.dataSource = self;
    contentView.delegate = self;
    
    //注册cell
    [contentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"HYCollectionViewCell"];
    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew context:@"test"];
}

//布局子控件
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    self.tabbar.frame = CGRectMake(0, 0, rect.size.width, HYTabbarViewHeight);
    
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.tabbar.frame), rect.size.width,HYContentViewHeight);
    
    //设置tabbar内部的按钮位置
    NSInteger count = (self.titles.count > HYColumn)? HYColumn : self.titles.count;
    _btnW = rect.size.width / (count * 1.0);
    CGFloat btnH = HYTabbarViewHeight;
    self.tabbar.contentSize = CGSizeMake(self.titles.count * _btnW, 0);
    
    for (int i = 0 ; i < self.titles.count; i++) {
        
        UIButton * btn = self.tabbar.subviews[i];
        btn.enabled = (i!=0);
        btn.frame = CGRectMake(i * _btnW, 0, _btnW, btnH);
    
        btn.backgroundColor = i%2?[UIColor orangeColor]:[UIColor greenColor];
    }
}


#pragma mark -   *************************  KVO监听方法 *************************

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (context == @"test") {
    
        self.prevSelectedIndex = [change[@"old"] integerValue];
        if (self.prevSelectedIndex == self.selectedIndex) {
            return;
        }

        //设置按钮选中
        [self itemSelectedIndex:self.selectedIndex];
        UIButton * btn = self.titles[self.selectedIndex];
    
        //让选中按钮居中
        NSInteger  min = HYColumn  / 2 ;
        if (_selectedIndex <= min) {
           
            [UIView animateWithDuration:0.25 animations:^{
                
                _tabbar.contentOffset = CGPointMake(0, 0);
            }];
           
        }
        if (_selectedIndex >= self.titles.count - min) {
            
            UIButton * tempBtn = self.titles[self.titles.count - min - 1];
            CGFloat btnX = (HYColumn % 2 ) ? tempBtn.center.x : (tempBtn.center.x + btn.frame.size.width * 0.5) ;
            CGFloat offsetX = _tabbar.center.x - btnX;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                _tabbar.contentOffset = CGPointMake(- offsetX, 0);
            }];
            
        }
        
        if (_selectedIndex > min && _selectedIndex < self.titles.count - min && self.titles.count > HYColumn ) {
            
            CGFloat   btnX  = (HYColumn % 2 ) ? btn.center.x : (btn.center.x - btn.frame.size.width * 0.5) ;
            CGFloat offsetX = _tabbar.center.x - btnX;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                _tabbar.contentOffset = CGPointMake( - offsetX, 0);
            }];
           
        }
    } else {
        
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - ************************* 代理方法 *************************

//CollectionViewDataSource方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.subViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor greenColor
                                
                                ];
    }
    
    return cell;
}

//UIScrollViewDelegate代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.selectedIndex = (scrollView.contentOffset.x + HYScreenW * 0.5) / HYScreenW;
}

#pragma mark - ************************* Private方法 *************************

- (void)itemSelectedIndex:(NSInteger)index{

    UIButton * selectedBtn = self.titles[self.prevSelectedIndex];
    selectedBtn.enabled = YES;
    _selectedIndex = index;
    UIButton * btn = self.titles[index];
    btn.enabled = NO;
}

- (void)itemSelected:(UIButton *)btn{
    
    NSInteger index = [self.titles indexOfObject:btn];
    self.selectedIndex = index;
    self.contentView.contentOffset = CGPointMake(index * self.bounds.size.width, 0);
}
#pragma mark - ************************* 对外接口 *************************
//外界传个控制器和一个标题,添加一个栏目
- (void)addSubItemWithViewController:(NSString *)viewController title:(NSString *)title{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tabbar addSubview:btn];
    [self setupBtn:btn withTitle:title];
    [btn addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    UIViewController * Vc = [[NSClassFromString(viewController) alloc]init];
    [self.subViewControllers addObject:Vc];
    
}
- (void)setupBtn:(UIButton *)btn withTitle:(NSString *)title{

    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    [self.titles addObject:btn];
}
@end
