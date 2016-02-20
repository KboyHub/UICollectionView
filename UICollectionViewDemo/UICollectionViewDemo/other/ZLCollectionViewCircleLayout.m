//
//  ZLCollectionViewCircleLayout.m
//  UICollectionViewDemo
//
//  Created by wdxgtsh on 16/2/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ZLCollectionViewCircleLayout.h"

@implementation ZLCollectionViewCircleLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.size = CGSizeMake(50, 50);
    
    //圆的半径
    CGFloat circleRadius = 70;
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    //每个item之间的角度
    CGFloat angleData =  M_PI * 2 / [self.collectionView numberOfItemsInSection:indexPath.section];
    //计算每个item的角度
    CGFloat angle = indexPath.item * angleData;
    
    attrs.center = CGPointMake(circleCenter.x + circleRadius * cosf(angle), circleCenter.y -  circleRadius*sinf(angle));
    
    attrs.zIndex = indexPath.item;
    
    return attrs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray * array = [NSMutableArray array];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 1; i < count; i++) {
        [array addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    
    return array;
}


@end
