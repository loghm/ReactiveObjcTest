//
//  ShopCartCountMgView.m
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/10.
//  Copyright © 2019 黄明族. All rights reserved.
//

#import "ShopCartCountMgView.h"

static const CGFloat widthInNumberCount = 30;

#define MAXSHOPNUM 999

@interface ShopCartCountMgView()

@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UITextField *numberField;

@end

@implementation ShopCartCountMgView

-(void)awakeFromNib {
    [super awakeFromNib];
    [self createUI];
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.borderColor = [UIColor redColor].CGColor;
    bgView.layer.borderWidth = 1;
    bgView.layer.masksToBounds = YES;
    [self addSubview:bgView];
    // 减
    self.subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _subBtn.frame = CGRectMake(0, 0, widthInNumberCount, widthInNumberCount);
    [_subBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_subBtn setTitle:@"-" forState:UIControlStateNormal];
    [_subBtn setTitle:@"-" forState:UIControlStateDisabled];
    WEAK
    [[self.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        STRONG
        strongSelf.countNum--;
        if (strongSelf.countNum <= 0) {
            strongSelf.countNum = 1;
        }
        if (strongSelf.CountNumChangeBlock) {
            strongSelf.CountNumChangeBlock(strongSelf.countNum, OperationTypeSub);
        }
    }];
    [bgView addSubview:_subBtn];
    
    self.numberField = [[UITextField alloc] init];
    self.numberField.frame = CGRectMake(CGRectGetMaxX(_subBtn.frame), 0, widthInNumberCount, _subBtn.frame.size.height);
    self.numberField.keyboardType=UIKeyboardTypeNumberPad;
    self.numberField.text=[NSString stringWithFormat:@"%@",@(0)];
    self.numberField.backgroundColor = [UIColor whiteColor];
    self.numberField.textColor = [UIColor greenColor];
    self.numberField.adjustsFontSizeToFitWidth = YES;
    self.numberField.textAlignment=NSTextAlignmentCenter;
    self.numberField.tintColor = [UIColor magentaColor];
    self.numberField.layer.borderColor = [UIColor redColor].CGColor;
    self.numberField.layer.borderWidth = 1;
    self.numberField.font= [UIFont systemFontOfSize:17.0];
    [bgView addSubview:self.numberField];
    //处理tfied的数量限制
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UITextFieldTextDidEndEditingNotification" object:self.numberField] subscribeNext:^(id x) {
        STRONG
        
    }];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(CGRectGetMaxX(_numberField.frame), 0, widthInNumberCount, widthInNumberCount);
    [_addBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_addBtn setTitle:@"+" forState:UIControlStateNormal];
    [_addBtn setTitle:@"+" forState:UIControlStateDisabled];
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        STRONG
        strongSelf.countNum++;
        if (strongSelf.countNum >= 999) {
            strongSelf.countNum = 999;
        }
        if (strongSelf.CountNumChangeBlock) {
            strongSelf.CountNumChangeBlock(strongSelf.countNum, OperationTypeAdd);
        }
    }];
    [bgView addSubview:_addBtn];
    
    
}

@end
