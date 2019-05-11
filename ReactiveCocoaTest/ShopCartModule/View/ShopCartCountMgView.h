//
//  ShopCartCountMgView.h
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/10.
//  Copyright © 2019 黄明族. All rights reserved.
//

/** 商品加减管理视图*/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OperationType) {
    OperationTypeSub = 1,
    OperationTypeAdd,
    OperationTypeInput
};

NS_ASSUME_NONNULL_BEGIN

@interface ShopCartCountMgView : UIView

@property (nonatomic, assign) NSInteger countNum;

//数量改变的回调
@property (nonatomic, copy) void(^CountNumChangeBlock)(NSInteger countNum, OperationType operationType);

@end

NS_ASSUME_NONNULL_END
