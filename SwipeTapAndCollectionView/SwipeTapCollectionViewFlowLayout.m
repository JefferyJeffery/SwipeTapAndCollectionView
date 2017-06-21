//
//  SwipeTapCollectionViewFlowLayout.m
//  SwipeTapAndCollectionView
//
//  Created by Jeffery on 6/19/17.
//  Copyright © 2017 JY_Test. All rights reserved.
//

#import "SwipeTapCollectionViewFlowLayout.h"

static const CGFloat ItemMaigin = 40;

@implementation SwipeTapCollectionViewFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = ItemMaigin;
    self.collectionView.pagingEnabled = NO;
}


/**
 *  @param proposedContentOffset 原本UICollectionView停止滾動那一刻的位置
 *  @param velocity              滾動速度
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGRect targetRect = CGRectMake(proposedContentOffset.x,
                                   0.0,
                                   CGRectGetWidth(self.collectionView.frame),
                                   CGRectGetHeight(self.collectionView.frame));
    
    NSArray *array = [self layoutAttributesForElementsInRect:targetRect];
    
    
    CGFloat offsetAdjustMent = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.frame) / 2.0);
    for (UICollectionViewLayoutAttributes *layoutAttribute in array) {
        CGFloat itemHorizontalCenter = layoutAttribute.center.x;
        
        CGFloat gapDistance = itemHorizontalCenter - horizontalCenter;
        
        if (ABS(gapDistance) < ABS(offsetAdjustMent)) {
            offsetAdjustMent = gapDistance;
        }
    }
    
    
    CGPoint newContentOffset = CGPointMake(proposedContentOffset.x + offsetAdjustMent, proposedContentOffset.y);
    
    return newContentOffset;
}

/**
 *  返回yes，只要顯示的邊界發生改變，就需要重新佈局：(會自動調用layoutAttributesForElementsInRect方法，獲得所有cell的佈局屬性)
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //0:计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    //get centerX of content of collectionView
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.frame) / 2.0 ;
    
    //1.取出默认cell的UICollectionViewLayoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //2.先copy所有cell 的 layout 屬性 --> 更改copied layout 屬性 ，再另存一個array
    //以避免以下warning :
    // This is likely occurring because the flow layout subclass SwipeTapCollectionViewFlowLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
    
    NSMutableArray *copyArray = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *layoutAttributes in array) {
        UICollectionViewLayoutAttributes *copyLayoutAttributes = [layoutAttributes copy];
        
        //不在 in vision 的 layout 就不處理跳過，直接存到 copyArray
        if (!CGRectIntersectsRect(visiableRect, copyLayoutAttributes.frame)) {
            [copyArray addObject:copyLayoutAttributes];
            continue;
        }
        
        //每一個 item 的中心 x 值
        CGFloat itemCenterx = copyLayoutAttributes.center.x;
        //差距越小，缩放比例越大
        //根據與銀幕最中間的距離計算缩放比例
        
        CGFloat X = ABS(itemCenterx - centerX);
        
        CGFloat reduceRate = 0.3;
        
        // 可以google這個方程式： cos(log2(x+77.8803))
        CGFloat scale = 1 + ABS(cosf(log2(X+77.8803)) * reduceRate);
        
        copyLayoutAttributes.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
        
        [copyArray addObject:copyLayoutAttributes];
    }
    
    return copyArray;
}

@end
