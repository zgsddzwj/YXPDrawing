//
//  YXPCarStatusChart.h
//  YXPSeller-iPhone
//
//  Created by AdwardGreen on 15/9/25.
//  Copyright © 2015年 youxinpai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXP_ChartDataSource.h"
//#import "YXPValuation_Define.h"

@interface YXPCarStatusChart : UIView

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) UIColor *chartBGColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *gridColor;//竖线颜色
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, assign) CGFloat chartHeight;//默认view.height-20
@property (nonatomic, assign) CGFloat chartStartX;//1/12view.width
@property (nonatomic, assign) CGFloat chartXInterval;//1/6view.width
@property (nonatomic, assign) CGFloat radius;//3.5

@property (nonatomic) CGFloat contractionFactor;//曲率(0~1,0.7)

@property (nonatomic, assign) CGFloat contentWidth;

@property (nonatomic, strong) YXP_CarStatusDataSource *dataSource;

-(void)configureChart;
@end
