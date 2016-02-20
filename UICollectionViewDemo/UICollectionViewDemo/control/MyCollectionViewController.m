//
//  MyCollectionViewController.m
//  UICollectionViewDemo
//
//  Created by wdxgtsh on 16/2/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "ZLCollectionViewCircleLayout.h"
#import "ZLCollectionViewLineLayout.h"
#import "ZLCollectionViewStackLayout.h"
#import "ZLImageCell.h"
#import "Masonry.h"


static NSString * const ID = @"ID";

@interface MyCollectionViewController()
<
UICollectionViewDataSource,
UICollectionViewDelegate
>

@property(nonatomic, strong) UICollectionView * myCollectionView;
@property(nonatomic, strong) NSMutableArray * imageArray;

@end

@implementation MyCollectionViewController

- (UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewLayout alloc] init]];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.backgroundColor = [UIColor purpleColor];
        [_myCollectionView registerClass:[ZLImageCell class] forCellWithReuseIdentifier:ID];
    }
    return _myCollectionView;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 30; i++) {
            [self.imageArray addObject:[NSString stringWithFormat:@"%02d.jpg", i]];
            NSLog(@"------>  %@", [NSString stringWithFormat:@"%02d.jpg", i]);
        }
    }
    return _imageArray;
}


- (void)loadUI{
    [self.view addSubview:self.myCollectionView];
    if (self.type == ZLCollectionViewLayoutStack) {
        self.navigationItem.title = @"照片浏览器二";
        [self.myCollectionView setCollectionViewLayout:[[ZLCollectionViewStackLayout alloc] init] animated:YES];
    }else if (self.type == ZLCollectionViewLayoutLine){
        self.navigationItem.title = @"照片浏览器三";
        [self.myCollectionView setCollectionViewLayout:[[ZLCollectionViewLineLayout alloc] init] animated:YES];
    }else if (self.type == ZLCollectionViewLayoutCircle){
        self.navigationItem.title = @"照片浏览器一";
        [self.myCollectionView setCollectionViewLayout:[[ZLCollectionViewCircleLayout alloc] init] animated:YES];
    }
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(100);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(@200);
    }];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }

    self.view.backgroundColor = [UIColor whiteColor];
    [self loadUI];
}

#pragma mark |---> UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZLImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageStr = self.imageArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == ZLCollectionViewLayoutCircle || self.type == ZLCollectionViewLayoutStack) {
        [self.imageArray removeObjectAtIndex:indexPath.row];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }
}

@end
