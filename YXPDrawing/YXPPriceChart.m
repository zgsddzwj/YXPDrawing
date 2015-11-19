//
//  YXPChart.m
//  EMChart
//
//  Created by YXP on 15/8/15.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import "YXPPriceChart.h"
#import "UIBezierPath+EMThroughPointsBezier.h"



#import "YXPLineManager.h"
#import "YXPPointManager.h"
#import "YXPNumberManager.h"
#import "YXPChartManager.h"
#import "YXPDrawingManager.h"

#define _COLOR_RGB(rgbValue) [UIColor colorWith\
Red     :(rgbValue & 0xFF0000)     / (float)0xFF0000 \
green   :(rgbValue & 0xFF00)       / (float)0xFF00 \
blue    :(rgbValue & 0xFF)         / (float)0xFF \
alpha   :1.0]


@interface YXPPriceChart(){
    
    UIScrollView *_mainScrollView;
    

    NSInteger dataCount_;
    float _maxValue;
    float _minValue;
    NSMutableArray *_personalValues;
    NSMutableArray *_merchartValues;
    
    UIView *_drawView;
    UIView *_virturlPointView;
    CGFloat _maxRadius;
}

@end

@implementation YXPPriceChart


#pragma mark - Initialize
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self initChartView];
        [self initDataSource];
    }
    return self;
}

- (void)initChartView{

    
    _chartHeight = CGRectGetHeight(self.frame) - 40;
    _lineWidth = 2.0;
    _fontSize = 10;
    self.backgroundColor = [UIColor clearColor];
    _currentIndex = 0;
    _chartStartX = CGRectGetWidth(self.frame)/12.0;
    _chartXInterval = CGRectGetWidth(self.frame)/6.0;
    
    _radius = 3.5f;
    _maxRadius = 4.f;

    _currentRadius = 10.0f;//当前点

    _mainScrollView = [[UIScrollView alloc]init];
    _mainScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self addSubview:_mainScrollView];
    
    _gridColor = [UIColor colorWithRed:0.894 green:0.906 blue:0.914 alpha:1];
    
    _drawView = [[UIView alloc]init];
    [_mainScrollView addSubview:_drawView];
    
    _virturlPointView = [[UIView alloc]init];
    _virturlPointView.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_virturlPointView];

}

- (void)initDataSource{
    
}


#pragma mark - setters & getters


-(void)setGridColor:(UIColor *)gridColor{
    _gridColor = gridColor;
}


- (void)configureChartData{
    dataCount_ =  _dataSource.chartValues.count;//(_dataSource.chartValues.count > 5)? 5: _dataSource.chartValues.count;
    _maxValue = [_dataSource.maxValue floatValue];
    _minValue = [_dataSource.minValue floatValue];
}


-(void)configureChart{
    
    [self configureChartData];

    _contentWidth = _chartXInterval * dataCount_ + _chartStartX;
    
    CGFloat width = _contentWidth?_contentWidth:CGRectGetWidth(self.frame);
    
    CGFloat bgWidth = MAX(width, CGRectGetWidth(self.frame));
    _mainScrollView.contentSize = CGSizeMake(_contentWidth, 0);
    _mainScrollView.bounces = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;

    //FIXME:_drawView下移了64px
    _drawView.frame = CGRectMake(0, -64, bgWidth, _chartHeight);
    _drawView.backgroundColor = _chartBGColor;
    _virturlPointView.frame = _drawView.frame;
    
    [self setupManagers];
     
}

#pragma mark - draw methods
-(void)drawRect:(CGRect)rect
{
    
    if (!_dataSource.chartValues.count) {
        return;
    }
    
    [[YXPChartManager sharedManager]drawOrignalX];
    
    for (int i=0; i<dataCount_; i++) {
        //竖线
        [[YXPChartManager sharedManager] drawLineAtIndex:i];
        //X坐标
        NSString *titleForXLabel=[_dataSource dateValueAtIndex:i];
        if (titleForXLabel) {
            [[YXPChartManager sharedManager] drawXLabel:titleForXLabel index:i animated:YES];
        }
        
    }


    NSMutableArray *personalValues = [NSMutableArray array];
    NSMutableArray *merchartValues = [NSMutableArray array];
    for (int i = 0; i < _dataSource.personalValues.count; i ++) {
        [personalValues addObject:[_dataSource personalValueAtIndex:i]];
        [merchartValues addObject:[_dataSource merchartValueAtIndex:i]];
    }
    _personalValues = personalValues;
    _merchartValues = merchartValues;
    
 
    
    [self drawPathWithValues:personalValues Color:_COLOR_RGB(0x00a5ea) margin:-12];
    [self drawPathWithValues:merchartValues Color:_COLOR_RGB(0xff512b) margin:27];
    
}

- (void)drawPathWithValues:(NSArray *)values Color:(UIColor *)color margin:(CGFloat)margin{
    //拟合点
    [[YXPPointManager sharedManager] drawVirtrulPoints:values color:color];
    //曲线
    [[YXPLineManager sharedManager] drawBezierPathLine:values WithLineColor:color Completion:nil];
    //点
    [[YXPPointManager sharedManager] drawPointWithValues:values WithColor:color animated:YES];
    //数字
    [[YXPNumberManager sharedManager] drawNumberWithValues:values WithColor:color margin:margin];
 
}

#pragma mark - manager setters

- (void)setupManagers{
    
    [YXPDrawingManager sharedManager].maxValue = _maxValue;
    [YXPDrawingManager sharedManager].minValue = _minValue;
    [YXPDrawingManager sharedManager].chartHeight = _chartHeight;
    [YXPDrawingManager sharedManager].chartStartX = _chartStartX;
    [YXPDrawingManager sharedManager].chartXInterval = _chartXInterval;
    
    
    [YXPChartManager sharedManager].drawView = _drawView;
    [YXPChartManager sharedManager].valueColor = _valueColor;
    [YXPChartManager sharedManager].gridColor = _gridColor;
    
    
    [YXPLineManager sharedManager].lineWidth = _lineWidth;
    [YXPLineManager sharedManager].contractionFactor = _contractionFactor;
    [YXPLineManager sharedManager].dataCount = dataCount_;
    [YXPLineManager sharedManager].drawView = _drawView;
    [YXPLineManager sharedManager].virturlPointView = _virturlPointView;
    
    
    [YXPPointManager sharedManager].radius = _radius;
    [YXPPointManager sharedManager].maxRadius = _maxRadius;
    [YXPPointManager sharedManager].dataCount = dataCount_;
    [YXPPointManager sharedManager].virturlPointView = _virturlPointView;
    [YXPPointManager sharedManager].currentIndex = _currentIndex;
    [YXPPointManager sharedManager].currentRadius = _currentRadius;
    [YXPPointManager sharedManager].drawView = _drawView;
    
    
    [YXPNumberManager sharedManager].radius = _radius;
    [YXPNumberManager sharedManager].dataCount = dataCount_;
    [YXPNumberManager sharedManager].currentIndex = _currentIndex;
    [YXPNumberManager sharedManager].drawView = _drawView;
    [YXPNumberManager sharedManager].fontSize = _fontSize;
    [YXPNumberManager sharedManager].valueColor = _valueColor;

}

@end
