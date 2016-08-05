//
//  ViewController.m
//  标签栏视图
//
//  Created by Sekorm on 16/3/31.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "ViewController.h"
#import "HYTabbarView.h"

@interface ViewController ()

@property (nonatomic,strong) HYTabbarView * tabbarView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view addSubview:self.tabbarView];
}

//懒加载
- (HYTabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            
            HYTabbarView * tabbar = [[HYTabbarView alloc]initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            
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

@end
