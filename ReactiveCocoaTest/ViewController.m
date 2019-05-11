//
//  ViewController.m
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/7.
//  Copyright © 2019 黄明族. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "OtherViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *tfield;
@property (nonatomic, strong) NSString *str;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //RAC基础应用
    //    [self basicRacSignal];
//    [self racSubject];
//    [self racReplaySubject];
    
    //RACSubject代替 代理
    [self initUI];
    
    [self test];
    
}

- (void)initUI {
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *b1 = [UIButton buttonWithType:UIButtonTypeCustom];
    b1.backgroundColor = [UIColor blueColor];
    b1.frame = CGRectMake(100, 100, 44, 44);
    [self.view addSubview:b1];
    [b1 addTarget:self action:@selector(pushOtherView:) forControlEvents:UIControlEventTouchUpInside];
    
    self.str = @"a";
    self.tfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 100, 44)];
    [self.view addSubview:_tfield];
    [RACObserve(self, str) subscribeNext:^(NSString *newName) {
        NSLog(@"tfield:..%@", newName);
    }];
}

- (void)pushOtherView:(UIButton *)sender {//RACSubject充当代理
    self.str = @"b";
    OtherViewController *othVC = [[OtherViewController alloc] init];
    othVC.delegateSignal = [RACSubject subject];
    //订阅信号
    [othVC.delegateSignal subscribeNext:^(id x) {
        NSLog(@"otherVC点击了按钮");
        self.str = @"c";
    }];
    [self.navigationController pushViewController:othVC animated:YES];
}

#pragma mark - RAC基础应用

- (void)basicRacSignal {
    // 1.创建信号 默认创建的信号都是冷信号，只有订阅信号才会激活变成热信号，值改变的时候才会触发。
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        NSLog(@"还未发送信号");
        // 2.发送信号 内部调用了subscribeNext方法
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    // 3.订阅信号,才会激活信号. 内部调用了didsubscriber的block
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
}

- (void)racSubject {
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    // 2.订阅信号
    [subject subscribeNext:^(id x) {// block调用时刻：当信号发出新值，就会调用
        NSLog(@"第一个订阅者%@", x);
    }];
    [subject subscribeNext:^(id x) {// block调用时刻：当信号发出新值，就会调用
        NSLog(@"第二个订阅者%@", x);
    }];
    // 3.发送信号
    [subject sendNext:@"1"];
}

- (void)racReplaySubject {
    /// 设置接受事件的数量为2
    RACReplaySubject *replaySubject = [RACReplaySubject replaySubjectWithCapacity:2];
    
    [replaySubject sendNext:@"hello world"]; //这句打印会被移除，原因是因为前面设置了接收事件的数量为2
    [replaySubject sendNext:@"rac"];
    [replaySubject sendNext:@"text 3"];
    
    [replaySubject subscribeNext:^(id x) {//如果订阅操作放到sendNext之前，跟racSubject没有区别
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}


- (void)test {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [subscriber sendNext:@"A"];
        });
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@"Another B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(doA:withB:) withSignals:signalA, signalB, nil];
}

- (void)doA:(NSString *)A withB:(NSString *)B
{
    NSLog(@"A:%@ and B:%@", A, B);
}

@end
