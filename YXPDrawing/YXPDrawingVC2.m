//
//  YXPDrawingVC2.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/17.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import "YXPDrawingVC2.h"
#import "YXPCarStatusChart.h"

#define _COLOR_RGB(rgbValue) [UIColor colorWith\
Red     :(rgbValue & 0xFF0000)     / (float)0xFF0000 \
green   :(rgbValue & 0xFF00)       / (float)0xFF00 \
blue    :(rgbValue & 0xFF)         / (float)0xFF \
alpha   :1.0]

@interface YXPDrawingVC2()
{
    YXPCarStatusChart *_chart;
}
@end

@implementation YXPDrawingVC2

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"DrawingView2";
    
    // chart
    if (!_chart)
    {
        
        _chart=[[YXPCarStatusChart alloc]initWithFrame:CGRectMake(10, 100, 355, 155)];
        _chart.chartBGColor = _COLOR_RGB(0xedf0f2);//表格背景颜色
        _chart.valueColor = [UIColor grayColor];//数字 颜色
        _chart.lineColor = _COLOR_RGB(0xff5a37);//线和数字背景图
        //    _chart.contractionFactor = 0.7;//曲线曲率
        
#warning 重要！不设置表格无法正常显示
        _chart.chartHeight = 120;
        _chart.chartStartX = (53);
        _chart.chartXInterval = (53);
        [self.view addSubview:_chart];
    }
    
    NSArray *chartValues =
  @[@{@"v_x":@"8-15",@"v_y":@"0"},@{@"v_x":@"8-31",@"v_y":@"2"},
  @{@"v_x":@"9-15",@"v_y":@"2"},@{@"v_x":@"9-30",@"v_y":@"2"},
  @{@"v_x":@"10-15",@"v_y":@"2"},@{@"v_x":@"10-31",@"v_y":@"1"},
  @{@"v_x":@"11-15",@"v_y":@"0"},];
    
    [self updateChart:chartValues];
    
}

- (void)updateChart:(NSArray *)chart_values;{

    //    ASSERT_Class(chart_values, [NSArray class]);
    YXP_CarStatusDataSource *dataSource = [[YXP_CarStatusDataSource alloc]initWithChartValues:chart_values];
    _chart.dataSource = dataSource;
    [_chart configureChart];

}
@end
