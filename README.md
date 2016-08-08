###导读:
下面这个视图(多视图滑动点击切换)在很多App都有用到.我对这个View进行了封装,外界只需要调用一个接口,就能实现这个效果.使用方法和系统的tabbarController很相似.相当好用的一个轮子,github源码分享https://github.com/HelloYeah/HYTabbarView.
大家checkout时顺手点个星星,与人为乐，自得其乐.

#####HYTabbarView效果图如下
![1.gif](http://upload-images.jianshu.io/upload_images/1338042-05d7e531dbd15359.gif?imageMogr2/auto-orient/strip) 


#####HYTabbarView可灵活配置一屏宽显示多少个标题,以及标题栏的高度,具体看项目需求	
	#define HYTabbarViewHeight 49    //顶部标签条的高度
	#define HYColumn 4      //一屏幕宽显示4个标题

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
	        }else if (_selectedIndex >= self.titles.count - min) {
	            UIButton * tempBtn = self.titles[self.titles.count - min - 1];
	            CGFloat btnX = (HYColumn % 2 ) ? tempBtn.center.x : (tempBtn.center.x + btn.frame.size.width * 0.5) ;
	            CGFloat offsetX = _tabbar.center.x - btnX;
	            [UIView animateWithDuration:0.25 animations:^{
	                _tabbar.contentOffset = CGPointMake(- offsetX, 0);
	            }];     
	        }else if (_selectedIndex > min && _selectedIndex < self.titles.count - min && self.titles.count > HYColumn ) {
	            CGFloat btnX  = (HYColumn % 2 ) ? btn.center.x : (btn.center.x - btn.frame.size.width * 0.5) ;
	            CGFloat offsetX = _tabbar.center.x - btnX;
	            [UIView animateWithDuration:0.25 animations:^{
	                _tabbar.contentOffset = CGPointMake( - offsetX, 0);
	            }];
	        }
	    } else {
	        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
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
	           
	           HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 600)];
	           
	           for (NSInteger i = 0; i< 10; i ++) {
	               UIViewController * vc = [[UIViewController alloc]init];
	               vc.title = [NSString stringWithFormat:@"第%ld个",i+1];
	               [tabbar addSubItemWithViewController:vc];
	           }
	           tabbar;
	       });
	   }
	   return _tabbarView;
	}
