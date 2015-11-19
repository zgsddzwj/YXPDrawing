//
//  YXPChartManager.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import "YXPChartManager.h"
#import "YXPDrawingManager.h"
#import "YXPAnimationManager.h"


@implementation YXPChartManager

+(instancetype)sharedManager{
    static YXPChartManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPChartManager alloc]init];
    });
    return manager;
}

#pragma mark 横线
- (void)drawHorLine{
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    CGFloat lineY = [YXPDrawingManager sharedManager].chartHeight;
    while (lineY > 0) {
        [linePath moveToPoint:CGPointMake(0, lineY)];
        [linePath addLineToPoint:CGPointMake(_contentWidth, lineY)];
        [linePath closePath];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.strokeColor = _gridColor.CGColor;
        lineLayer.path = linePath.CGPath;
        [_drawView.layer addSublayer:lineLayer];
        lineY -= 30;
    }
}


#pragma mark - 竖线
- (void)drawLineAtIndex:(NSInteger)index;{
    
    CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:0 index:index];
    UILabel *lineLbl = [UILabel new];
    lineLbl.backgroundColor = _gridColor;
    lineLbl.frame = CGRectMake(point.x - 0.5, 0, 1, [YXPDrawingManager sharedManager].chartHeight);
    
    [self.drawView addSubview:lineLbl];
    [self.drawView sendSubviewToBack:lineLbl];
    
}


#pragma mark - X坐标上的数字
-(void)drawXLabel:(NSString *)text index:(NSInteger)index animated:(BOOL)animated;
{
    
    CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:0 index:index];
    CGRect frame=[text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    CGFloat y = 0;
    if (animated) {
        y = [YXPDrawingManager sharedManager].chartHeight + 60;
    }else{
        y = [YXPDrawingManager sharedManager].chartHeight + 10;
    }
    UILabel *xLabel = [[UILabel alloc]initWithFrame:CGRectMake(point.x - CGRectGetWidth(frame)/2.0,y, frame.size.width, frame.size.height)];
    xLabel.text = text;
    xLabel.textColor = self.valueColor;
    xLabel.font = [UIFont systemFontOfSize:14];
    [self.drawView addSubview:xLabel];
    if (animated) {
        [self addAnimationToXLabel:xLabel AtIndex:index];
    }
    
}


- (void)drawOrignalX{
    
    NSString *origin=@"车龄";
    CGRect frame=[origin boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    UILabel *originalLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, [YXPDrawingManager sharedManager].chartHeight + 10, frame.size.width, frame.size.height)];
    originalLbl.text = origin;
    originalLbl.textColor = self.valueColor;
    originalLbl.font = [UIFont systemFontOfSize:14];
    [self.drawView addSubview:originalLbl];
    
}

#pragma mark - Animation

- (void)addAnimationToXLabel:(UILabel *)label AtIndex:(NSInteger)index{
    
    [[YXPAnimationManager sharedManager]addAnimationToXLabel:label AtIndex:index];
}

@end
