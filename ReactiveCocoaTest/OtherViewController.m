//
//  OtherViewController.m
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/7.
//  Copyright © 2019 黄明族. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    b1.backgroundColor = [UIColor blueColor];
    b1.frame = CGRectMake(100, 100, 44, 44);
    [self.view addSubview:b1];
    [b1 addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)popView:(UIButton *)sender {
    //告诉第一个界面按钮别点击了
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:nil];
    }
}


@end
