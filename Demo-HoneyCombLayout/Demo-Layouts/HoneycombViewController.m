//
//  HoneycombViewController.m
//  Demo-Layouts
//
//  Created by 杜子兮(duzixi) on 14-9-1.
//  Copyright (c) 2014年 lanou3g.com All rights reserved.
//

#import "HoneycombViewController.h"
#import "HoneyCombLayout.h"
#import "HoneycombViewCell.h"

@interface HoneycombViewController ()

@end

@implementation HoneycombViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arrayData = [NSMutableArray arrayWithObjects:@"0", @"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1. 选一个布局模版
    HoneyCombLayout *layout = [[HoneyCombLayout alloc] init];
    layout.margin = 10;
    layout.oX = -10;
    layout.oY = 20;
    
    // 2. 创建UICollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [self.collectionView registerClass:[HoneycombViewCell class] forCellWithReuseIdentifier:HONEYCELLID];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arrayData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HoneycombViewCell *cell = (HoneycombViewCell *)[cView dequeueReusableCellWithReuseIdentifier:HONEYCELLID forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"cell不可以为空！");
        return nil;
    }
    cell.titleLabel.text = self.arrayData[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected! %d", indexPath.row);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    HoneyCombLayout *layout = (HoneyCombLayout *)self.collectionView.collectionViewLayout;
    layout.oY = -scrollView.contentOffset.y + 20;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
