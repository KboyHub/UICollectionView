//
//  ZLImageCell.m
//  UICollectionViewDemo
//
//  Created by wdxgtsh on 16/2/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "ZLImageCell.h"
#import "Masonry.h"

@interface ZLImageCell()

@property(nonatomic, strong) UIImageView * imageView;

@end

@implementation ZLImageCell

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
}

- (void)setImageStr:(NSString *)imageStr{
    _imageStr = [imageStr copy];
    self.imageView.image = [UIImage imageNamed:imageStr];
}

@end
