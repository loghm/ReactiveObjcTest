//
//  ShopTableViewCell.m
//  ReactiveCocoaTest
//
//  Created by 黄明族 on 2019/5/9.
//  Copyright © 2019 黄明族. All rights reserved.
//

#import "ShopTableViewCell.h"

@interface ShopTableViewCell()

@property (nonatomic, strong) UIImageView *productImageView;


@end

@implementation ShopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
