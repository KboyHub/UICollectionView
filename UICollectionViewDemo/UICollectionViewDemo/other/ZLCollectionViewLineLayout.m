//
//  ZLCollectionViewLineLayout.m
//  UICollectionViewDemo
//
//  Created by wdxgtsh on 16/2/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//


#import "ZLCollectionViewLineLayout.h"

static const CGFloat ZLItemWH = 100;

@implementation ZLCollectionViewLineLayout


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)prepareLayout{
    [super prepareLayout];
    //初始化
    self.itemSize = CGSizeMake(ZLItemWH, ZLItemWH);
    CGFloat inset = (self.collectionView.frame.size.width - ZLItemWH) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal | UICollectionViewScrollDirectionVertical;
    self.minimumLineSpacing = ZLItemWH * 0.5;
    //每一个（cell）item都有自己的的  UICollectionViewLayoutAttributes
    //每一个indexpath都有自己的 UICollectionViewLayoutAttributes
    //        UICollectionViewLayoutAttributes
}

//只要显示的边界发生变化就重新布局   内部会重新调用prepareLayout  和layoutAttributesForElementsInRect 方法获得所有cell的布局属性
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//用来设置collectionVuew停止滚动那一刻的位置
/*
 @param proposedContentOffset 原本scrollView停止滚动的位置
 @param velocity 滚动速度
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    //1. 计算出scrollView最后会停留的范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    //计算屏幕最中间的x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //2.取出这个范围内的所有属性
    NSArray * array = [self layoutAttributesForElementsInRect:lastRect];
    
    //3.遍历所有属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if(ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)){
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    
    
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}


//有效距离 ： 当item的中间x距离屏幕的中间x在ZLActiveDistance以内  才会开始放大  其他情况下都是缩小
static CGFloat const ZLActiveDistance = 150;
// 缩放因素 ： 值越大  item就会越大
static CGFloat const ZLScaleFactor = 0.5;


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    // 0.计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    //1. 取出默认的cell的 UICollectionViewLayoutAttributes
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕最中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    //2. 遍历所有的布局属性
    for (UICollectionViewLayoutAttributes * attrs in array) {
        
        // 如果不在屏幕上,直接跳过
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) continue;
        
        //每一个item的中点x
        CGFloat itemCenterX = attrs.center.x;
        
        //差距越小  缩放比例越大
        
        //根据跟屏幕最中间的距离计算缩放比例
        
        //        if (ABS(itemCenterX - centerX) <= 150) {
        CGFloat scale = 1 + ZLScaleFactor * (1- (ABS(itemCenterX - centerX)/ZLActiveDistance));
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
        //        }else{
        //            attrs.transform3D = CATransform3DMakeScale(1.0, 1.0, 1.0);
        //        }
        //        attrs.transform = CGAffineTransformMakeScale(scale, scale);
        //        attrs.center.x;
        
    }
    
    return  array;
}



@end
