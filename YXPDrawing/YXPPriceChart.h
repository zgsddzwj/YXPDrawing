//
//  YXPChart.h
//  YXPChart
//
//  Created by YXP on 15/8/15.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXP_ChartDataSource.h"
//#import "YXPValuation_Define.h"

@interface YXPPriceChart : UIView

#pragma mark line
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic) CGFloat contractionFactor;//曲率(0~1,0.7)


@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) UIColor *chartBGColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *gridColor;//竖线颜色
@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, assign) CGFloat chartHeight;//默认view.height-20
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) CGFloat chartStartX;//1/12view.width
@property (nonatomic, assign) CGFloat chartXInterval;//1/6view.width

@property (nonatomic, assign) CGFloat radius;//3.5
@property (nonatomic, assign) CGFloat currentRadius;//7.0


@property (nonatomic, assign) CGFloat contentWidth;

@property (nonatomic, strong) YXP_ChartDataSource *dataSource;

-(void)configureChart;


@end
