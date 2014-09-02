//
//  HoneyCombLayout.m
//  Demo-Layouts
//
//  Created by 杜子兮(duzixi) on 14-9-1.
//  Copyright (c) 2014年 lanou3g.com All rights reserved.
//

#import "HoneyCombLayout.h"

@implementation HoneyCombLayout

///  返回内容大小，用于判断是否需要加快滑动

-(CGSize)collectionViewContentSize
{
    float height = (SIZE + self.margin) * ([self.collectionView numberOfItemsInSection:0] / 4 + 1);
    return CGSizeMake(320, height);
}


///  返回YES，改变布局
/*
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
*/
#pragma mark - UICollectionViewLayout
///  为每一个Item生成布局特性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    UICollectionView *collection = self.collectionView;

    float x = (SIZE + self.margin) * (indexPath.item % COL + 1) * 0.75;
    float y = (SIZE + self.margin) * (indexPath.item / COL + 0.5) * cos(M_PI * 30.0f / 180.0f);
    if (indexPath.item % 2 == 1) {
        y += (SIZE + self.margin) * 0.5 * cosf(M_PI * 30.0f / 180.0f);
    }
    
    x += self.oX;
    y += self.oY;
    
    attributes.center = CGPointMake(x + collection.contentOffset.x, y + collection.contentOffset.y);
    attributes.size = CGSizeMake(SIZE, SIZE * cos(M_PI * 30.0f / 180.0f));
    
    return attributes;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    if ([arr count] > 0) {
        return arr;
    }
    NSMutableArray *attributes = [NSMutableArray array];
    for (NSInteger i = 0 ; i < [self.collectionView numberOfItemsInSection:0 ]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}



@end



