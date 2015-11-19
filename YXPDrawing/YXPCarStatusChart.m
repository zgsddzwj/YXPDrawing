//
//  YXPCarStatusChart.m
//  YXPSeller-iPhone
//
//  Created by AdwardGreen on 15/9/25.
//  Copyright © 2015年 youxinpai. All rights reserved.
//

#import "YXPCarStatusChart.h"
#import "UIBezierPath+EMThroughPointsBezier.h"

#import "YXPLineManager.h"
#import "YXPAnimationManager.h"
#import "YXPPointManager.h"
#import "YXPNumberManager.h"
#import "YXPChartManager.h"
#import "YXPDrawingManager.h"



@interface YXPCarStatusChart(){
    
    NSInteger dataCount_;
    float _maxValue;
    float _minValue;
    
    UIView *_drawView;
    
    UIView *bgView;
}
@end

@implementation YXPCarStatusChart

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
    _chartStartX = CGRectGetWidth(self.frame)/12.0;
    _chartXInterval = CGRectGetWidth(self.frame)/6.0;
    _radius = 3.5f;
    
    bgView = [UIView new];
    [self addSubview:bgView];
    
    
    _mainScrollView = [[UIScrollView alloc]init];
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.contentOffset = CGPointMake(MAXFLOAT, 0);
    
    [self addSubview:_mainScrollView];
//    [_mainScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    _mainScrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    _gridColor = [UIColor colorWithRed:0.894 green:0.906 blue:0.914 alpha:1];
    
    _drawView = [[UIView alloc]init];
    [_mainScrollView addSubview:_drawView];
    _drawView.backgroundColor = [UIColor clearColor];

    
}

- (void)initDataSource{}

#pragma mark - Initialize


- (void)configureChartData{
    dataCount_ = _dataSource.chartValues.count;
    _maxValue = [_dataSource.maxValue floatValue];
    _minValue = [_dataSource.minValue floatValue];
}


-(void)configureChart{
    
    [self configureChartData];
    
    bgView.backgroundColor = _chartBGColor;
    bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), _chartHeight);
    
    _contentWidth = _chartXInterval * dataCount_ + _chartStartX;
    CGFloat width = _contentWidth?_contentWidth:CGRectGetWidth(self.frame);
    _mainScrollView.contentSize = CGSizeMake(_contentWidth, _chartHeight);
    
    CGFloat bgWidth = MAX(width, CGRectGetWidth(self.frame));
    _drawView.frame = CGRectMake(0, 0, bgWidth, _chartHeight);
    
    [self setupManagers];
    
 }

#pragma mark - draw methods


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    if (!_dataSource.chartValues.count) {
        return;
    }
    
    
    for (int i=0; i<dataCount_; i++) {
        //竖线
        [[YXPChartManager sharedManager] drawLineAtIndex:i];
        //X坐标
        NSString *titleForXLabel=[_dataSource dateValueAtIndex:i];
        if (titleForXLabel) {
            [[YXPChartManager sharedManager] drawXLabel:titleForXLabel index:i animated:NO];
        }
        
    }
    
    //网格横线
    [[YXPChartManager sharedManager] drawHorLine];
    
    NSMutableArray *carNumbers = [NSMutableArray array];
    for (int i = 0; i < _dataSource.carNumbers.count; i ++) {
        [carNumbers addObject:[_dataSource numberValueAtIndex:i]];
    }
    
    [self drawPathWithValues:carNumbers Color:[UIColor orangeColor] margin:-12];
}


- (void)drawPathWithValues:(NSArray *)values Color:(UIColor *)color margin:(CGFloat)margin{
    
    [[YXPLineManager sharedManager] fillPathWithValues:values WithLineColor:color];
    
    [[YXPPointManager sharedManager] drawPointWithValues:values WithColor:color animated:NO];
    [[YXPNumberManager sharedManager] drawStaticNumberWithValues:values margin:margin];
    
}

#pragma mark - managers setters
- (void)setupManagers{
    
    [YXPDrawingManager sharedManager].maxValue = _maxValue;
    [YXPDrawingManager sharedManager].minValue = _minValue;
    [YXPDrawingManager sharedManager].chartHeight = _chartHeight;
    [YXPDrawingManager sharedManager].chartStartX = _chartStartX;
    [YXPDrawingManager sharedManager].chartXInterval = _chartXInterval;
    
    
    [YXPChartManager sharedManager].drawView = _drawView;
    [YXPChartManager sharedManager].valueColor = _valueColor;
    [YXPChartManager sharedManager].gridColor = _gridColor;
    [YXPChartManager sharedManager].contentWidth = _contentWidth;
    
    [YXPLineManager sharedManager].lineWidth = _lineWidth;
    [YXPLineManager sharedManager].contractionFactor = _contractionFactor;
    [YXPLineManager sharedManager].dataCount = dataCount_;
    [YXPLineManager sharedManager].drawView = _drawView;
    
    [YXPPointManager sharedManager].radius = _radius;
    [YXPPointManager sharedManager].dataCount = dataCount_;
    [YXPPointManager sharedManager].drawView = _drawView;
    
    [YXPNumberManager sharedManager].radius = _radius;
    [YXPNumberManager sharedManager].dataCount = dataCount_;
    [YXPNumberManager sharedManager].drawView = _drawView;
    [YXPNumberManager sharedManager].fontSize = _fontSize;
    [YXPNumberManager sharedManager].valueColor = _valueColor;
    

}

@end
