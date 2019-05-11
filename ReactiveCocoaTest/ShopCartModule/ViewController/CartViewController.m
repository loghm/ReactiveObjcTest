//
//  CartViewController.m
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/9.
//  Copyright © 2019 黄明族. All rights reserved.
//

#import "CartViewController.h"
#import "CartBottomBar.h"
#import "CartLayoutManager.h"
#import "CartUIService.h"

@interface CartViewController ()

@property (nonatomic, strong) UITableView *cartTableView;
@property (nonatomic, strong) CartBottomBar *botmBar;
@property (nonatomic, strong) CartUIService *service;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - lazy

-(UITableView *)cartTableView {
    if (!_cartTableView) {
        _cartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 55)];
        _cartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _cartTableView.dataSource   = self.service;
        _cartTableView.delegate     = self.service;
        _cartTableView.backgroundColor = [UIColor lightTextColor];
        //        _cartTableView.bounces         = NO;
        _cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        _cartTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    }
    return _cartTableView;
}

-(CartBottomBar *)botmBar {
    if (!_botmBar) {
        _botmBar = [[CartBottomBar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 10 - 50, kScreenWidth, 50)];
    }
    return _botmBar;
}

@end
