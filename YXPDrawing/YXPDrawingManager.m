//
//  YXPDrawingManager.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import "YXPDrawingManager.h"


CGFloat chartMargin_ = 84.f;

CGFloat adjHeight_ = 50;

@implementation YXPDrawingManager

+(instancetype)sharedManager{
    static YXPDrawingManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPDrawingManager alloc]init];
    });
    return manager;
}

#pragma mark - 计算每个点的具体位置


-(CGPoint)pointWithValue:(CGFloat)value index:(NSInteger)index
{
    return  CGPointMake(self.chartXInterval*index + self.chartStartX, [self pointYWithValue:value]);
}

- (CGFloat)pointYWithValue:(CGFloat)value{
    
    CGFloat height = self.chartHeight;
    CGFloat pointY = 0;
    pointY = (height - adjHeight_) - (height - chartMargin_)*(value - self.minValue)/(self.maxValue - self.minValue);
    return (isinf(pointY)?0.f:pointY);
}

#pragma mark - 测试数据，补充曲线

//加一个测试数据，画在Y轴上
- (CGFloat )adjustNumberTo:(NSArray *)arr{
    
    CGFloat curNumber0 = [[arr objectAtIndex:0] floatValue];
    CGFloat curNumber1 = [[arr objectAtIndex:1] floatValue];
    CGFloat adjustNumber = curNumber0 + (curNumber0 - curNumber1);
    return adjustNumber;
}
//末端测试数据，画在Y轴上
- (CGFloat )adjustNumberToEnd:(NSArray *)arr{
    
    CGFloat curNumber0 = [[arr objectAtIndex:(arr.count - 2)] floatValue];
    CGFloat curNumber1 = [[arr objectAtIndex:(arr.count - 1)] floatValue];
    CGFloat adjustNumber = curNumber1 + (curNumber1 - curNumber0);
    return adjustNumber;
}


@end
