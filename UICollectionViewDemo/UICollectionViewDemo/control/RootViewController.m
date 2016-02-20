//
//  RootViewController.m
//  UICollectionViewDemo
//
//  Created by wdxgtsh on 16/2/20.
//  Copyright © 2016年 zhaolei. All rights reserved.
//

#import "RootViewController.h"
#import "Masonry.h"
#import "MyCollectionViewController.h"
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView * mainTableView;

@end

@implementation RootViewController

#pragma mark |--> lazy load
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
//        _mainTableView.backgroundColor = [UIColor purpleColor];
    }
    return _mainTableView;
}

#pragma mark |--> load UI
- (void)loadTableView{
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self loadTableView];
}

#pragma mark |--> UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellID = @"CellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.text =  indexPath.row == 0 ? @"照片浏览器一" : (indexPath.row == 1 ? @"照片浏览器二" : @"照片浏览器三") ;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"照片浏览器";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0000f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewController * collectionVC = [[MyCollectionViewController alloc] init];
    switch (indexPath.row) {
        case 0://照片浏览器一
            collectionVC.type = ZLCollectionViewLayoutCircle;
            break;
        case 1://照片浏览器二
            collectionVC.type = ZLCollectionViewLayoutStack;
            break;
        case 2://照片浏览器三
            collectionVC.type = ZLCollectionViewLayoutLine;
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:collectionVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
