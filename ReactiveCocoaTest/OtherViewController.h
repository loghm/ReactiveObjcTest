//
//  OtherViewController.h
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/7.
//  Copyright © 2019 黄明族. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface OtherViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

@end

NS_ASSUME_NONNULL_END
