//
//  HoneycombViewController.h
//  Demo-Layouts
//
//  Created by 杜子兮(duzixi) on 14-9-1.
//  Copyright (c) 2014年 lanou3g.com All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoneycombViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate>

@property (retain, nonatomic) UICollectionView *collectionView;
@property (retain, nonatomic) NSMutableArray *arrayData;

@end
