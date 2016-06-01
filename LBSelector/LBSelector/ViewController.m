//
//  ViewController.m
//  LBSelector
//
//  Created by plum on 16/5/31.
//  Copyright © 2016年 plum. All rights reserved.
//

#import "ViewController.h"
#import "LBSelector.h"
#import <Masonry.h>

static NSString *cellname = @"cell";
@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
    NSArray *array = @[@{@"类型":@[@"战士",@"法师",@"法师",@"法师",@"法师",@"法师",@"法师"]},@{@"价格":@[@"上架时间",@"法师",@"法师"]}];
    LBSelector *listingView = [[LBSelector alloc]initWithArray:array];
    listingView.backgroundColor = [UIColor redColor];
    [self.view addSubview:listingView];
    [listingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(36);
        make.top.offset(100);
        make.leading.trailing.equalTo(self.view);
    }];
    
     //调整位置
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"哈哈" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.frame = CGRectMake(20, 200, 100, 36);
    UIImage *image = [UIImage imageNamed:@"下拉_默认"];
    [button setImage:image forState:UIControlStateNormal];
    UIEdgeInsets tInset = button.titleEdgeInsets;
    UIEdgeInsets iInset = button.imageEdgeInsets;
    tInset.left = - image.size.width /2;
    tInset.right = image.size.width /2;;
   
  CGRect size =  [button.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil ];
    iInset.top = 13;
    iInset.bottom = -13;
    iInset.left = size.size.width /2;
    iInset.right = -size.size.width /2;
    CGRect r = button.titleLabel.frame;
    [button setImageEdgeInsets:iInset];
    [button setTitleEdgeInsets:tInset];
    [self.view addSubview:button];
    */
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellname];
    [self.view addSubview:collectionView];
    
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellname forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(40, 40);
    } else if (indexPath.section == 1){
        return CGSizeMake(80, 80);
    } else {
        return CGSizeMake(120, 120);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
@end
