###导读:

下面这个效果(多视图滑动点击切换)在很多App都有用到.我相信大家都写过很多遍了.

网上也有大量的Demo,设计思路,大致差不多,代码繁杂程度不忍直视.笔者自己对这个视图效果进行了封装,代码精简美观,接口简单.外界只需要调用一个接口,就能实现这个效果.

使用方法和系统的tabbarController相似,只需要给HYTabbarView添加对应控制器即可.

个人简书链接:http://www.jianshu.com/users/cc9c23e60cbf/latest_articles

大家checkout时顺手点个星星,与人为乐，自得其乐.

#####HYTabbarView效果图如下
![1.gif](http://chuantu.biz/t5/30/1471921557x2031068758.gif) 
#####HYTabbarView可灵活配置UI界面

	static CGFloat const topBarItemMargin = 15; ///标题之间的间距
	static CGFloat const topBarHeight = 40; //顶部标签条的高度

####实现思路详解
- 界面分析:分为上下部分,顶部UIScrollView,底部UICollectionView.再实现两部分的联动即可实现 (底部视图相对复杂,占用内存大,底部用UICollectionView实现会比用UIScrollView性能好很多)
- 每一个标题对应一个View视图,View视图交由相应的控制器来管理,代码结构十分清晰.做到不同View上的业务逻辑高聚合.也不会产生耦合性
- 上下两部分的联动,这里是同过KVO实现的,监听当前的selectedIndex,底部视图滚动时,修改selectedIndex的值.在KVO监听的回调方法里让标题居中.
- 其他细节相对简单,大家不看代码都知道如何处理,比如:点击顶部标题,设置按钮选中,切换到对应的CollectionCell等

#####代码片段:

1.外界传个控制器和一个标题,添加一个栏目

	//外界传个控制器,添加一个栏目
	- (void)addSubItemWithViewController:(UIViewController *)viewController{
	    
	    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
	    [self.tabbar addSubview:btn];
	    [self setupBtn:btn withTitle:viewController.title];
	    [btn addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
	    [self.subViewControllers addObject:viewController];
	}	
2.KVO监听当前选中View的序号值
        
    //viewDidLoad中添加观察者
	[self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionOld |NSKeyValueObservingOptionNew context:@"scrollToNextItem"];

      //让标题按钮居中算法
	- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
	{
	    if (context == @"scrollToNextItem") {
	        //设置按钮选中
	        [self itemSelectedIndex:self.selectedIndex];
	        UIButton * btn = self.titles[self.selectedIndex];
	        // 计算偏移量
	        CGFloat offsetX = btn.center.x - HYScreenW * 0.5;
	        if (offsetX < 0) offsetX = 0;
	        // 获取最大滚动范围
	        CGFloat maxOffsetX = self.tabbar.contentSize.width - HYScreenW;
	        if (offsetX > maxOffsetX) offsetX = maxOffsetX;
	        // 滚动标题滚动条
	        [self.tabbar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
	    }
	}

####控制器代码如下

使用方法类似系统的UITabbarController,外界只需直接传入控制器.

	- (void)viewDidLoad {
	   
	   [super viewDidLoad];
	
	   [self.view addSubview:self.tabbarView];
	}
		
	//懒加载
	- (HYTabbarView *)tabbarView{
	    
	    if (!_tabbarView) {
	        _tabbarView = ({
	            
	            HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
	            
	            //传入九个控制器,每个控制器分别管理对应的视图
	            UIViewController * vc0 = [[UIViewController alloc]init];
	            vc0.title = @"推荐";
	            [tabbar addSubItemWithViewController:vc0];
	    
	            UIViewController * vc1 = [[UIViewController alloc]init];
	            vc1.title = @"热点";
	            [tabbar addSubItemWithViewController:vc1];
	            
	            UIViewController * vc2 = [[UIViewController alloc]init];
	            vc2.title = @"视频";
	            [tabbar addSubItemWithViewController:vc2];
	            
	            UIViewController * vc3 = [[UIViewController alloc]init];
	            vc3.title = @"中国好声音";
	            [tabbar addSubItemWithViewController:vc3];
	            
	            UIViewController * vc4 = [[UIViewController alloc]init];
	            vc4.title = @"数码";
	            [tabbar addSubItemWithViewController:vc4];
	            
	            UIViewController * vc5 = [[UIViewController alloc]init];
	            vc5.title = @"头条号";
	            [tabbar addSubItemWithViewController:vc5];
	            
	            UIViewController * vc6 = [[UIViewController alloc]init];
	            vc6.title = @"房产";
	            [tabbar addSubItemWithViewController:vc6];
	            
	            UIViewController * vc7 = [[UIViewController alloc]init];
	            vc7.title = @"奥运会";
	            [tabbar addSubItemWithViewController:vc7];
	            
	            UIViewController * vc8 = [[UIViewController alloc]init];
	            vc8.title = @"时尚";
	            [tabbar addSubItemWithViewController:vc8];
	
	            tabbar;
	        });
	    }
	    return _tabbarView;
	}
