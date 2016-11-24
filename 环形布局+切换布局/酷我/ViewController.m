//
//  ViewController.m
//  酷我
//
//  Created by xin on 2016/11/13.
//  Copyright © 2016年 DogeEggEgg. All rights reserved.
//

#import "ViewController.h"
#import "CircleLayout.h"
#import "CZAdditions.h"
#define DataNum 20
static NSString *circleCellID = @"circleCell";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewLayout *circleLayout;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 新建自定义布局参数
    _circleLayout = [[CircleLayout alloc] init];
    
    // 新建一个collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300) collectionViewLayout:_circleLayout];
    _collectionView.center = self.view.center;
    [self.view addSubview:_collectionView];
    
    // 添加数据源代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    // 注册
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:circleCellID];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:circleCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cz_randomColor];
    return cell;
    
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i < DataNum; i++) {
            NSString *str = @"str";
            [_dataArr addObject:str];
        }
    }
    return _dataArr;
}

// 点击item的时候删除对应item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.dataArr removeObjectAtIndex:indexPath.item];
    [_collectionView.collectionViewLayout prepareLayout];
    [_collectionView reloadData];
}

// 触摸屏幕切换布局
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_collectionView.collectionViewLayout == _circleLayout) {
        
        // 如果是环形布局 就切换流水布局
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 设置流水布局
        flowLayout.itemSize = CGSizeMake(50, 50);
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(50, 50, 50, 50);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.collectionViewLayout = flowLayout;
    }else{
        _collectionView.collectionViewLayout = _circleLayout;
    }
    
}

@end
