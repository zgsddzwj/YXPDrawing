//
//  YXPNumberManager.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import "YXPNumberManager.h"
#import "YXPAnimationManager.h"
#import "YXPDrawingManager.h"


@implementation YXPNumberManager

+ (instancetype)sharedManager;{
    static YXPNumberManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPNumberManager alloc]init];
    });
    return manager;
}


#pragma mark - 数字
- (void)drawNumberWithValues:(NSArray *)values WithColor:(UIColor *)color margin:(CGFloat)margin{
    
    for (int index =0; index < self.dataCount; index++) {
        CGFloat value=[[values objectAtIndex:index] floatValue];
        CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:value index:index];
        
        
        NSString *valueString=[NSString stringWithFormat:@"%.2lf万",value];
        CGRect frame=[valueString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.fontSize]} context:nil];
        CGPoint pointForValueString=CGPointMake(point.x-frame.size.width/2, point.y-frame.size.height + margin);
        
        UILabel *valueLabel = nil;
        
        CGRect desRect ;
        
        if (index == self.currentIndex) {
            
            valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(pointForValueString.x-10, -frame.size.height-4, frame.size.width+20, frame.size.height+4)];
            valueLabel.text = valueString;
            valueLabel.textColor = [UIColor whiteColor];
            valueLabel.textAlignment = NSTextAlignmentCenter;
            valueLabel.backgroundColor = color;
            valueLabel.font = [UIFont systemFontOfSize:12];
            valueLabel.layer.cornerRadius = 4.0f;
            valueLabel.layer.masksToBounds = YES;
            desRect = CGRectMake(pointForValueString.x-10, pointForValueString.y-2, frame.size.width+20, frame.size.height+4);
            [self.drawView addSubview:valueLabel];
            
        }else{
            
            valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(pointForValueString.x, pointForValueString.y, frame.size.width, frame.size.height)];
            valueLabel.text = valueString;
            valueLabel.textColor = self.valueColor;
            valueLabel.font = [UIFont systemFontOfSize:self.fontSize];
            [self.drawView addSubview:valueLabel];
            
            valueLabel.alpha = 0.f;
        }
        
        [self addAnimationToNumber:valueLabel Index:index toDes:desRect];
    }
}


- (void)drawStaticNumberWithValues:(NSArray *)values margin:(CGFloat)margin {
    
    for (int index =0; index < self.dataCount; index++) {
        NSInteger value=[[values objectAtIndex:index] floatValue];
        CGPoint point=[[YXPDrawingManager sharedManager] pointWithValue:value index:index];
        
        
        NSString *valueString=[NSString stringWithFormat:@"%@",@(value)];
        CGRect frame=[valueString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_fontSize]} context:nil];
        CGPoint pointForValueString=CGPointMake(point.x-frame.size.width/2, point.y-frame.size.height + margin);
        
        UILabel *valueLabel = nil;
        
        
        valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(pointForValueString.x, pointForValueString.y, frame.size.width, frame.size.height)];
        valueLabel.text = valueString;
        valueLabel.textColor = _valueColor;
        valueLabel.font = [UIFont systemFontOfSize:_fontSize];
        [_drawView addSubview:valueLabel];
        
    }
}

#pragma mark - Animation

- (void)addAnimationToNumber:(UIView *)number Index:(NSInteger)index toDes:(CGRect)desFrame{
    
    if (index == self.currentIndex) {
        [[YXPAnimationManager sharedManager]addAnimationToNumber:number Index:index toDes:desFrame];
    }else{
        
        [[YXPAnimationManager sharedManager]addAnimationToNumber:number Index:index];
    }
    
}



@end
