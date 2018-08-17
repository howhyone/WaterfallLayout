//
//  ZXWaterfallLayout.m
//  WaterfallLayout
//
//  Created by mob on 2018/8/9.
//  Copyright © 2018年 mob. All rights reserved.
//

#import "ZXWaterfallLayout.h"

/** 默认的列数  **/
static const CGFloat ZXDefaultColumnCount = 3;
/** 每一列之间的间距 **/
static const CGFloat ZXDefaultColumnMargin = 10;
/** 每一行之间的间距 **/
static const CGFloat ZXDefaultRowMergin =10;
/** 内边距 **/
static const UIEdgeInsets ZXDefaultEdgeInsets = {10,10,10,10};

@interface ZXWaterfallLayout()
/** 存放所有的布局属性 **/
@property(nonatomic, strong) NSMutableArray *attrsArr;
/** 存放所有列的当前高度 **/
@property(nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 **/
@property(nonatomic, assign) CGFloat contentHeight;

-(NSUInteger)columnCount;
-(CGFloat)columnMergin;
-(CGFloat)rowMergin;
-(UIEdgeInsets)edgeInsets;
@end

@implementation ZXWaterfallLayout

#pragma mark --- 懒加载
-(NSMutableArray *)attrsArr
{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _attrsArr;
}
-(NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray arrayWithCapacity:1];
    }
    return _columnHeights;
}

#pragma mark   ------- 数据处理
/**
 *列数
 **/
-(NSUInteger)columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInwaterFallLayout:)]) {
        return [self.delegate columnCountInwaterFallLayout:self];
    }
    else{
        return ZXDefaultColumnCount;
    }
}

/**
 *列间距
 **/
-(CGFloat)columnMergin
{
    if ([self.delegate respondsToSelector:@selector(columnMerginInwaterFallLayout:)]) {
        return [self.delegate columnMerginInwaterFallLayout:self];
    }
    else{
        return ZXDefaultColumnMargin;
    }
}

/**
 *行间距
 **/
-(CGFloat)rowMergin
{
    if ([self.delegate respondsToSelector:@selector(rowMerginInWaterFallLayout:)]) {
        return [self.delegate rowMerginInWaterFallLayout:self];
    }
    else{
        return ZXDefaultRowMergin;
    }
}
/**
 *item的内边距
 **/
-(UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetdInWaterFallLayout:)]) {
        return [self.delegate edgeInsetdInWaterFallLayout:self];
    }
    else{
        return ZXDefaultEdgeInsets;
    }
}

/**
 *初始化
 **/

-(void)prepareLayout
{
    [super prepareLayout];
    self.contentHeight = 0;
    // 清除之前计算的所有高度
    [self.columnHeights removeAllObjects];
    
    for (NSInteger i = 0; i < ZXDefaultColumnCount; i++) {
        [self.columnHeights addObject:@(ZXDefaultEdgeInsets.top)];
    }
    
    //清除之前所有的布局
    [self.attrsArr removeAllObjects];
//    开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath位置上cell对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArr addObject:attrs];
    }
    
}

#pragma mark ---------- 返回indexPath位置cell对应的布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //collectinView的宽度
    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
//    设置布局属性的frame
    CGFloat cellWidth = (collectionViewWidth - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMergin) / self.columnCount;
    CGFloat cellHeight = [self.delegate waterFallLayout:self heightForItemAtIndexPath:indexPath.item itemWidth:cellWidth];
//    CGFloat cellHeight = 100;
    //找出最短的一列
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (int i = 1; i < ZXDefaultColumnCount; i++) {
        //取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    CGFloat cellX = self.edgeInsets.left + destColumn *(cellWidth + self.columnMergin);
    CGFloat cellY = minColumnHeight;
    if (cellY != self.edgeInsets.top) {
        cellY += self.rowMergin;
    }
    attrs.frame = CGRectMake(cellX, cellY, cellWidth, cellHeight);
//    最短那一列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attrs.frame));
    //记录内容的高度 -- 即最长那一列的高度
    CGFloat maxColumnHeight = [self.columnHeights[destColumn] doubleValue];
    if (self.contentHeight < maxColumnHeight) {
        self.contentHeight = maxColumnHeight;
    }
    return attrs;
}

/**
 *决定cell的高度
 **/
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInrect:(CGRect)rect
{
    return self.attrsArr;
}
/**
 *内容高度
 */
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end
