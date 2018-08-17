//
//  WaterfallCollectionViewCell.m
//  WaterfallLayout
//
//  Created by mob on 2018/8/8.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "WaterfallCollectionViewCell.h"
#import "ShopModel.h"

@interface WaterfallCollectionViewCell()

//@property(nonatomic, strong) ShopModel *shopModel;
@end

@implementation WaterfallCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        _shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 188, 137)];
        [_shopImgView setBackgroundColor:[UIColor greenColor]];
        [self addSubview:_shopImgView];
        
        _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 137, 188, 30)];
        [_shopNameLabel setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_shopNameLabel];
        
        
    }
    
    return self;
}

-(void)setShopModel:(ShopModel *)shopModel
{
    _shopModel = shopModel;
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:shopModel.img] placeholderImage:[UIImage imageNamed:@"loading"]];
//    self.shopNameLabel.text = ShopModel.
}

@end
