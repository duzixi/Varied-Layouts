//
//  HoneycombViewCell.m
//  Demo-Layouts
//
//  Created by 杜子兮(duzixi) on 14-9-1.
//  Copyright (c) 2014年 lanou3g.com All rights reserved.
//

#import "HoneycombViewCell.h"

@implementation HoneycombViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // step 1: 生成六边形路径
    CGFloat longSide = SIZE * 0.5 * cosf(M_PI * 30 / 180);
    CGFloat shortSide = SIZE * 0.5 * sin(M_PI * 30 / 180);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, longSide)];
    [path addLineToPoint:CGPointMake(shortSide, 0)];
    [path addLineToPoint:CGPointMake(shortSide + SIZE * 0.5, 0)];
    [path addLineToPoint:CGPointMake(SIZE, longSide)];
    [path addLineToPoint:CGPointMake(shortSide + SIZE * 0.5, longSide * 2)];
    [path addLineToPoint:CGPointMake(shortSide, longSide * 2)];
    [path closePath];
    
    // step 2: 根据路径生成蒙板
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [path CGPath];
    
    // step 3: 给cell添加模版
    self.layer.mask = maskLayer;

    
    self.backgroundColor = [UIColor orangeColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = self.contentView.frame;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
