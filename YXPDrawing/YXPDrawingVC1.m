//
//  YXPDrawingVC1.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/17.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import "YXPDrawingVC1.h"
#define _COLOR_RGB(rgbValue) [UIColor colorWith\
Red     :(rgbValue & 0xFF0000)     / (float)0xFF0000 \
green   :(rgbValue & 0xFF00)       / (float)0xFF00 \
blue    :(rgbValue & 0xFF)         / (float)0xFF \
alpha   :1.0]


@implementation YXPDrawingVC1
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"DrawingView1";
    
    if (!_chart)
    {
        
        _chart=[[YXPPriceChart alloc]initWithFrame:CGRectMake(10, 100, 355, 200)];
        _chart.chartBGColor = _COLOR_RGB(0xedf0f2);//表格背景颜色
        _chart.valueColor = [UIColor grayColor];//数字 颜色
        _chart.lineColor = _COLOR_RGB(0xff5a37);//线和数字背景图
        _chart.currentIndex = -1;//选中点
        //    _chart.contractionFactor = 0.7;//曲线曲率
        //    _chart.cdelegate = self;
#warning 重要！不设置表格无法正常显示
        _chart.chartHeight = 166;
        _chart.chartStartX = (59);
        _chart.chartXInterval = (59);
        
        [self.view addSubview:_chart];
    }
#if 1
    NSArray *chartValues = @[@{@"v_x":@"1年",@"v_y":@"18.92",@"v_y_s":@"17.41"},
                             @{@"v_x":@"2年",@"v_y":@"17.64",@"v_y_s":@"16.23"},
                             @{@"v_x":@"3年",@"v_y":@"16.44",@"v_y_s":@"15.12"},
                             @{@"v_x":@"4年",@"v_y":@"15.32",@"v_y_s":@"14.09"},
                             @{@"v_x":@"5年",@"v_y":@"14.28",@"v_y_s":@"13.14"},
                             @{@"v_x":@"6年及以上",@"v_y":@"13.52",@"v_y_s":@"12.29"}
                             ];
#endif
        
    [self updateChart:chartValues WithCarNoTime:nil];
    
}


- (void)updateChart:(NSArray *)chart_values WithCarNoTime:(NSString *)carNoTime;{
    
    YXP_ChartDataSource *dataSource = [[YXP_ChartDataSource alloc]initWithChartValues:chart_values WithCarNoTime:carNoTime];
    _chart.dataSource = dataSource;
    
    _chart.currentIndex = [dataSource.currentDateValue integerValue];
    
    [_chart configureChart];
}

@end
