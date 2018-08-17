//
//  ZXWaterfallLayout.h
//  WaterfallLayout
//
//  Created by mob on 2018/8/9.
//  Copyright © 2018年 mob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXWaterfallLayout;

@protocol ZXWaterfallLayoutDelegate<NSObject>

@required

/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(ZXWaterfallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
-(NSUInteger)columnCountInwaterFallLayout:(ZXWaterfallLayout *)waterFallLayout;
/**
 * 每列之间的间距
 */
-(CGFloat)columnMerginInwaterFallLayout:(ZXWaterfallLayout *)waterFallLayout;
/**
 每行之间的间距
**/
-(CGFloat)rowMerginInWaterFallLayout:(ZXWaterfallLayout *)waterFallLayout;
/**
 *每个item的内边距
 **/
-(UIEdgeInsets)edgeInsetdInWaterFallLayout:(ZXWaterfallLayout *)waterFallLayout;

@end

@interface ZXWaterfallLayout : UICollectionViewLayout
/*********代理**********/
@property(nonatomic, weak) id<ZXWaterfallLayoutDelegate> delegate;
@end
