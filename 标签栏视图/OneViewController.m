//
//  OneViewController.m
//  标签栏视图
//
//  Created by Sekorm on 16/9/6.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "OneViewController.h"

//@interface OneViewController () <UITableViewDataSource>
//
//@end

@implementation OneViewController 


- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * const ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"Hello World";
    }
    return cell;
}

@end
