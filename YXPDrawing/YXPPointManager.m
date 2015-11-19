//
//  YXPPointManager.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import "YXPPointManager.h"
#import "YXPAnimationManager.h"
#import "YXPDrawingManager.h"


@implementation YXPPointManager

+(instancetype)sharedManager{
    static YXPPointManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPPointManager alloc]init];
    });
    return manager;
}

#pragma mark - VirtrulPoints

- (void)drawVirtrulPoints:(NSArray *)values color:(UIColor *)color;{
    
    CGFloat startPointY = [[YXPDrawingManager sharedManager] pointYWithValue:[[YXPDrawingManager sharedManager] adjustNumberTo:values]];
    CGFloat valueEnd = [[YXPDrawingManager sharedManager] adjustNumberToEnd:values];
    CGPoint pointEnd=[[YXPDrawingManager sharedManager] pointWithValue:valueEnd index:_dataCount];
        
    //起始点
    [self drawPointInRectWithCenter:CGPointMake(0, startPointY) color:color];
    //终点
    [self drawPointInRectWithCenter:pointEnd color:color];
    
    for (int index = 0; index <_dataCount; index ++) {
        CGFloat value=[[values objectAtIndex:index] floatValue];
        CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:value index:index];
        [self drawPointInRectWithCenter:point color:color];
    }
}

- (void)drawPointInRectWithCenter:(CGPoint)center color:(UIColor *)color{
    //rect.width.height adjustHeightToScreenForSmall(59)
    CGFloat rectLength = (59);
    
    CGFloat maxX = center.x + rectLength/2.f;
    CGFloat minX = center.x - rectLength/2.f;
    CGFloat maxY = center.y + rectLength/2.f;
    CGFloat minY = center.y - rectLength/2.f;
    
    //r = R
    
    int point1Num = [self randomFloatBetween:1 andLargerFloat:3];
    
    for (int num = 0; num < point1Num; num ++) {
        
        CGFloat rminX = minX + rectLength / 4.f;
        CGFloat rmaxX = minX + rectLength * 3/4.f;
        
        CGFloat rminY = minY + rectLength / 4.f;
        CGFloat rmaxY = minY + rectLength * 3/4.f;
        
        CGFloat randomX = [self randomFloatBetween:rminX andLargerFloat:rmaxX];
        CGFloat randomY = [self randomFloatBetween:rminY andLargerFloat:rmaxY];
        
        
        CGPoint vPointCenter = CGPointMake(randomX, randomY);
        
        [self drawVirturlPointWithCenter:vPointCenter originalCenter:center Radius:_maxRadius color:color];
        
    }
    
    //r = 2R/3
    
    int point2Num = [self randomFloatBetween:2 andLargerFloat:5];
    
    for (int num = 0; num < point2Num; num ++) {
        
        
        CGFloat rminX = minX + rectLength / 8.f;
        CGFloat rmaxX = minX + rectLength * 7/8.f;
        
        CGFloat rminY = minY + rectLength / 8.f;
        CGFloat rmaxY = minY + rectLength * 7/8.f;
        
        CGFloat randomX = [self randomFloatBetween:rminX andLargerFloat:rmaxX];
        CGFloat randomY = [self randomFloatBetween:rminY andLargerFloat:rmaxY];
        
        
        CGPoint vPointCenter = CGPointMake(randomX, randomY);
        
        [self drawVirturlPointWithCenter:vPointCenter originalCenter:center Radius:_maxRadius*2/3.f color:color];
    }
    
    //r = R/2
    
    int point3Num = [self randomFloatBetween:4 andLargerFloat:9];
    for (int num = 0; num < point3Num; num ++){
        
        CGFloat randomX = [self randomFloatBetween:minX andLargerFloat:maxX];
        CGFloat randomY = [self randomFloatBetween:minY andLargerFloat:maxY];
        
        CGPoint vPointCenter = CGPointMake(randomX, randomY);
        
        [self drawVirturlPointWithCenter:vPointCenter originalCenter:center Radius:_maxRadius/2.f color:color];
    }
    
}

-(void)drawVirturlPointWithCenter:(CGPoint)center originalCenter:(CGPoint)originalCenter Radius:(CGFloat)radius color:(UIColor *)color{
    
    UILabel *vPoint = [UILabel new];
    vPoint.frame = CGRectMake(0, 0,radius *2, radius *2);
    vPoint.center = center;
    
    vPoint.backgroundColor = color;
    vPoint.layer.cornerRadius = radius;
    vPoint.layer.masksToBounds = YES;
    vPoint.alpha = 0.f;
    [_virturlPointView addSubview:vPoint];
    
    [self addAnimationToVirturlPoint:vPoint WithRadius:radius];
    [self aggregate:vPoint ToOriginalPoint:originalCenter];
}

-(float)randomFloatBetween:(float)num1 andLargerFloat:(float)num2
{
    int startVal = num1*10000;
    int endVal = num2*10000;
    
    int randomValue = startVal +(arc4random()%(endVal - startVal));
    float a = randomValue;
    
    return(a /10000.0);
}

#pragma mark - Points

- (void)drawPointWithValues:(NSArray *)values WithColor:(UIColor *)color animated:(BOOL)animated;{
    
    for (int index = 0; index <_dataCount; index ++) {
        CGFloat value=[[values objectAtIndex:index] floatValue];
        CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:value index:index];
        if (animated) {
            
            UIView *pointView = [UIView new];
            
            if (index == _currentIndex) {
                
                pointView.frame = CGRectMake(point.x, -_currentRadius * 2, _currentRadius * 1.5, _currentRadius * 1.5);
                pointView.layer.cornerRadius = _currentRadius-2;
                pointView.layer.masksToBounds = YES;
                pointView.backgroundColor = [UIColor whiteColor];
                pointView.layer.borderColor = color.CGColor;
                pointView.layer.borderWidth = _currentRadius/4.0;
                [_drawView addSubview:pointView];
                
            }else{
                
                pointView.frame = CGRectMake(point.x, -_radius * 2, _radius * 2, _radius *2);
                pointView.backgroundColor = color;
                pointView.layer.cornerRadius = _radius;
                pointView.layer.masksToBounds = YES;
                [_drawView addSubview:pointView];
                
            }
            
            [self addAnimationToPoint:pointView Index:index toDes:point];
            
        }else{//无动画
            
            
            CGFloat value=[[values objectAtIndex:index] floatValue];
            CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:value index:index];
            UIView *pointView = [UIView new];

            pointView.frame = CGRectMake(0, 0, _radius * 2, _radius *2);
            pointView.center = point;
            pointView.backgroundColor = color;
            pointView.layer.cornerRadius = _radius;
            pointView.layer.masksToBounds = YES;
            [_drawView addSubview:pointView];
            
        }
    }
}



#pragma mark - Animation

- (void)addAnimationToVirturlPoint:(UIView *)point WithRadius:(CGFloat)radius{
    
    CGFloat delay = 0.f;
    if (radius == _maxRadius) {
        delay = 0.f;
    }else if(radius == _maxRadius *2/3.f){
        delay = .5f;
    }else if (radius == _maxRadius /2.f){
        delay = 1.f;
    }
    [[YXPAnimationManager sharedManager]addAnimationToVirturlPoint:point WithDelay:delay];

}

- (void)aggregate:(UILabel *)point ToOriginalPoint:(CGPoint)originalPoint{
    [[YXPAnimationManager sharedManager]aggregate:point ToOriginalPoint:originalPoint];
}



- (void)addAnimationToPoint:(UIView *)point Index:(NSInteger)index toDes:(CGPoint)desPoint{
    [[YXPAnimationManager sharedManager] addAnimationToPoint:point Index:index toDes:desPoint];
}



@end
