//
//  TriangleViewController.m
//  TriangleLayout
//
//  Created by 杜子兮(duzixi) on 14-8-24.
//  Copyright (c) 2014年 lanou3g.com All rights reserved.
//

#import "TriangleViewController.h"
#import "Triangle.h"
#import <QuartzCore/QuartzCore.h>

#define PADDING 10
#define SIZE 100
#define COL (self.view.frame.size.width / SIZE)
#define ROW (self.view.frame.size.height / SIZE)

@interface TriangleViewController ()

@end

@implementation TriangleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _randomPoints = [NSMutableArray array];
    _triangles = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor yellowColor];
    int oy = - SIZE / 2;
    
    for (int i = 0; i < ROW + 2; i++) {
        for (int j = 0; j < COL; j++) {
            int ox = (i % 2 == 1) ? j * SIZE : j * SIZE - 0.5 * SIZE;
            ox -= SIZE / 4;
            // step 1:画格子
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(ox, i * SIZE + oy, SIZE, SIZE)];
            if ((j + i ) % 2 == 0) {
                view.backgroundColor = [UIColor grayColor];
            }
            // [self.view addSubview:view];
            
            // step 2:在格子中产生随机点
            int x = arc4random() % (SIZE - PADDING * 2) + view.frame.origin.x + PADDING;
            int y = arc4random() % (SIZE - PADDING * 2) + view.frame.origin.y + PADDING;
            CGPoint p = CGPointMake(x, y);
            NSValue *v = [NSValue valueWithCGPoint:p];
            [_randomPoints addObject:v];
            UIView *pView = [[UIView alloc] initWithFrame:CGRectMake(p.x, p.y, 2, 2)];
            pView.backgroundColor = [UIColor blueColor];
            // [self.view addSubview:pView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(p.x, p.y, 50, 20)];
            label.text = [NSString stringWithFormat:@"%lu",(unsigned long)[_randomPoints count]];
            // [self.view addSubview:label];
        }
    }
    
    int k = 0;
    for (int i = 0; i < ROW; i++) {
        NSLog(@"-----------------");
        for (int j = 0; j < COL - 1; j++) {
            // step 3: 俺三角形将点归类
            k = i * COL + j + i;
            Triangle *t = [[Triangle alloc] init];
            t.p1 = [_randomPoints[k] CGPointValue];
            t.p2 = [_randomPoints[k + 1] CGPointValue];
            int col = i % 2 == 0  ?  COL : COL + 1;
            t.p3 = [_randomPoints[k + 1 + col] CGPointValue];
            
            NSLog(@"%d %d %d", k , k + 1, k + 1 + col);
            [_triangles addObject:t];
            
            // step 4: 生成三角形所在的矩形区域
            int minX = t.p1.x < t.p2.x ? t.p1.x : t.p2.x;
            minX = minX < t.p3.x ? minX : t.p3.x;
            int minY = t.p1.y < t.p2.y ? t.p1.y : t.p2.y;
            minY = minY < t.p3.y ? minY : t.p3.y;
            
            int maxX = t.p1.x > t.p2.x ? t.p1.x : t.p2.x;
            maxX = maxX > t.p3.x ? maxX : t.p3.x;
            int maxY = t.p1.y > t.p2.y ? t.p1.y : t.p2.y;
            maxY = maxY > t.p3.y ? maxY : t.p3.y;
            
            k++;
            
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(minX, minY, maxX - minX, maxY - minY)];
            view.backgroundColor = [UIColor orangeColor];
            view.alpha = 0.8;
            
            
            // step 5: 根据三角形生成蒙板
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(t.p1.x - minX, t.p1.y - minY)];
            [path addLineToPoint:CGPointMake(t.p2.x - minX,  t.p2.y - minY)];
            [path addLineToPoint:CGPointMake(t.p3.x - minX, t.p3.y - minY)];
            [path closePath];
            
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.path = [path CGPath];
            view.layer.mask = maskLayer;
            
            [self.view addSubview:view];
            
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
