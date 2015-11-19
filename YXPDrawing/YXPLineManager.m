//
//  YXPLineManager.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/17.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "YXPLineManager.h"
#import "YXPDrawingManager.h"
#import "YXPAnimationManager.h"
#import "UIBezierPath+EMThroughPointsBezier.h"

#define LinePathAnimationDelay 2.5

#define kFillColor     [UIColor greenColor]


@interface YXPLineManager()
{
    UIScrollView *_mainScrollView;    
    
    CGFloat _maxRadius;

}

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation YXPLineManager

+ (instancetype)sharedManager{
    static YXPLineManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPLineManager alloc]init];
    });
    return manager;
}

- (UIBezierPath *)getPathWithValues:(NSArray *)values{
    NSMutableArray *pointValueArray = [NSMutableArray array];
    //画线
    UIBezierPath *_path;
    
    CGPoint startPoint = [self getStartPointWithValues:values];
    
    _path = [UIBezierPath bezierPath];
    [_path moveToPoint:startPoint];

    
    for (int i=0; i<self.dataCount; i++) {
        
        CGFloat value=[[values objectAtIndex:i] floatValue];
        CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:value index:i];
        [pointValueArray addObject:[NSValue valueWithCGPoint:point]];
    }
    
    CGPoint pointEnd = [self getEndPointWithValues:values];
    
    [pointValueArray addObject:[NSValue valueWithCGPoint:pointEnd]];
    
    if (_contractionFactor) {
        _path.contractionFactor = _contractionFactor;
    }
    
    if (pointValueArray.count) {
        [_path addBezierThroughPoints:pointValueArray];
    }
    return _path;
}


- (void)drawBezierPathLine:(NSArray *)values WithLineColor:(UIColor *)color Completion:(CompleteBlock)complete;
{
    
    _shapeLayer = [[CAShapeLayer alloc]init];
    _shapeLayer.strokeColor = color.CGColor;
    _shapeLayer.fillColor = nil;
    _shapeLayer.lineWidth = _lineWidth;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.hidden = YES;
    _shapeLayer.path = [self getPathWithValues:values].CGPath;
    
    [self.drawView.layer addSublayer:_shapeLayer];
    
    [self performSelector:@selector(addAnimationToPath:) withObject:self.shapeLayer afterDelay:LinePathAnimationDelay];
}



- (void)fillPathWithValues:(NSArray *)values WithLineColor:(UIColor *)color;{
    
    _shapeLayer = [[CAShapeLayer alloc]init];
    _shapeLayer.strokeColor = color.CGColor;
    _shapeLayer.fillColor = nil;
    _shapeLayer.lineWidth = _lineWidth;
    _shapeLayer.lineCap = kCALineCapRound;
    UIBezierPath *path = [self getPathWithValues:values];
    _shapeLayer.path = path.CGPath;

    
    CGPoint startPoint = [self getStartPointWithValues:values];
    CGPoint pointEnd = [self getEndPointWithValues:values];

    
    //先填充图
    [self fillColor:color toPath:path withStartPoint:startPoint endPoint:pointEnd];
    //再画线
    [_drawView.layer addSublayer:_shapeLayer];
}

- (void)fillColor:(UIColor *)fillColor toPath:(UIBezierPath *)path withStartPoint:(CGPoint )startP endPoint:(CGPoint )endP{
    
    UIBezierPath *fillPath = path;
    [fillPath addLineToPoint:CGPointMake(endP.x, [YXPDrawingManager sharedManager].chartHeight)];
    [fillPath addLineToPoint:CGPointMake(startP.x, [YXPDrawingManager sharedManager].chartHeight)];
    [fillPath closePath];
    [fillPath fill];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = fillPath.CGPath;
    fillLayer.backgroundColor = [UIColor clearColor].CGColor;
    fillLayer.opacity = 0.4f;
    fillLayer.fillColor = kFillColor.CGColor;
    fillLayer.strokeColor = [UIColor clearColor].CGColor;
    [_drawView.layer addSublayer:fillLayer];
    
    
}

#pragma mark - Animation

- (void)addAnimationToPath:(CALayer *)layer{
    
    [[YXPAnimationManager sharedManager] addStokeAnimationToPath:layer];
    [[YXPAnimationManager sharedManager] fadeOutView:_virturlPointView];
    
}


#pragma mark -

- (CGPoint)getStartPointWithValues:(NSArray *)values{
    
    CGFloat pointY = [[YXPDrawingManager sharedManager] pointYWithValue:[[YXPDrawingManager sharedManager] adjustNumberTo:values]];
    return CGPointMake(0, pointY);
}

- (CGPoint)getEndPointWithValues:(NSArray *)values{
#warning End!!!
    CGFloat valueEnd = [[YXPDrawingManager sharedManager] adjustNumberToEnd:values];
    CGPoint pointEnd=[[YXPDrawingManager sharedManager] pointWithValue:valueEnd index:self.dataCount];
    return pointEnd;
}

@end
