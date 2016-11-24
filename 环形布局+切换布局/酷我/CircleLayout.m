//
//  CircleLayout.m
//  酷我
//
//  Created by xin on 2016/11/13.
//  Copyright © 2016年 DogeEggEgg. All rights reserved.
//

#import "CircleLayout.h"
#import "CZAdditions.h"

// 环形大小比例 可修改以修改半径大小
#define RadiusScale 0.7
@interface CircleLayout()
@property (nonatomic, strong) NSMutableArray *attributes;
@end


// 这个方法能返回每个item的布局对象们
@implementation CircleLayout
- (void)prepareLayout{
    
    [super prepareLayout];
    
    [self.attributes removeAllObjects];
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    // items的数量
    NSInteger itemNum = [self.collectionView numberOfItemsInSection:0];

    // 循环每个布局对象
    for (int i = 0; i < itemNum; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attributes addObject:attribute];
    }
    
   return self.attributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 环形布局
    // 确定环形的半径
    CGFloat radius = MIN(self.collectionView.bounds.size.width/2, self.collectionView.bounds.size.height/2) * RadiusScale;
    
    // 环形的圆心
    CGPoint center = CGPointMake(self.collectionView.bounds.size.width/2, self.collectionView.bounds.size.height/2);
    
    // 布局对象
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // items的数量
    NSInteger itemNum = [self.collectionView numberOfItemsInSection:0];
    
    // 确定平均每个角度的大小
    CGFloat angle = 2 * M_PI / itemNum;
    
    CGFloat singalAngle = angle * indexPath.item;
        
    // 进行布局
    attribute.bounds = CGRectMake(0, 0, 40, 40);
    attribute.center = CGPointMake(center.x + radius * cos(singalAngle), center.y + radius * sin(singalAngle));
    
    // 当只有一个item的时候, 让最后一个cell 放置到中间
    if (itemNum == 1) {
        
        attribute.center = center;
    }

    return attribute;

}

- (NSMutableArray *)attributes{
    if (_attributes == nil) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

@end
