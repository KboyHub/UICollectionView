//
//  MyCollectionViewController.h
//  UICollectionViewDemo
//
//  Created by wdxgtsh on 16/2/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, ZLCollectionViewLayoutType) {
    ZLCollectionViewLayoutStack              = 0,
    ZLCollectionViewLayoutLine               = 1 << 0,
    ZLCollectionViewLayoutCircle             = 1 << 1,
};
@interface MyCollectionViewController : UIViewController

@property(nonatomic, assign)ZLCollectionViewLayoutType type;

@end
