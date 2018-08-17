//
//  WaterfallCollectionViewCell.h
//  WaterfallLayout
//
//  Created by mob on 2018/8/8.
//  Copyright © 2018年 mob. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopModel;
@interface WaterfallCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong)UIImageView *shopImgView;
@property(nonatomic, strong)UILabel *shopNameLabel;
@property(nonatomic, strong)ShopModel *shopModel;

@end
