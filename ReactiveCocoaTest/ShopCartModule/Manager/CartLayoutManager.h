//
//  CartLayoutManager.h
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/10.
//  Copyright © 2019 黄明族. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 屏幕宽度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define WEAK __weak typeof(self) weakSelf = self;
#define STRONG __strong typeof(weakSelf) strongSelf = weakSelf;

//兼容swift 在这两个宏之间的代码，所有简单指针对象都被假定为nonnull，因此我们只需要去指定那些nullable的指针。
NS_ASSUME_NONNULL_BEGIN

@interface CartLayoutManager : NSObject

+(CGFloat)ScreenWidth;
+(CGFloat)ScreenHeight;

@end

NS_ASSUME_NONNULL_END
