//
//  YXPAnimationManager.m
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import "YXPAnimationManager.h"

#define PointAnimationDelay 1.5
#define NumberAnimationDelay 3.0
#define XLabelAnimationDelay 2.5


@implementation YXPAnimationManager

+(instancetype)sharedManager{
    static YXPAnimationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YXPAnimationManager alloc]init];
    });
    return manager;
}

- (void)addStokeAnimationToPath:(CALayer *)layer;{
    
    layer.hidden = NO;
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5f;
    pathAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue=[NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses=NO;
    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
}

- (void)fadeOutView:(UIView *)view;{
    
    [UIView animateWithDuration:.5f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.alpha = 0.f;
                     }
                     completion:^(BOOL finished){
                     }];
    
    
}


- (void)aggregate:(UILabel *)point ToOriginalPoint:(CGPoint)originalPoint{
    
    [UIView animateWithDuration:1.f
                          delay:1.5f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         point.center = originalPoint;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)addAnimationToVirturlPoint:(UIView *)point WithDelay:(CGFloat)delay;{
    
    [UIView animateWithDuration:.5f
                          delay:delay
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         point.alpha = 1.f;
                     } completion:^(BOOL finished) {
                         
                     }];
}


- (void)addAnimationToPoint:(UIView *)point Index:(NSInteger)index toDes:(CGPoint)desPoint;{
    
    [UIView animateWithDuration:1.5
                          delay:PointAnimationDelay+(.1 * index)
         usingSpringWithDamping:.4
          initialSpringVelocity:.5
                        options:UIViewAnimationOptionLayoutSubviews animations:^{
                            point.center = desPoint;
                        }
                     completion:^(BOOL finished) {
                         if (finished) {
                         }
                     }];
}


- (void)addAnimationToNumber:(UIView *)number Index:(NSInteger)index toDes:(CGRect)desFrame{
    
    [UIView animateWithDuration:1.5
                          delay:(NumberAnimationDelay + index * .1)
         usingSpringWithDamping:.5
          initialSpringVelocity:.5
                        options:UIViewAnimationOptionLayoutSubviews animations:^{
                            number.frame = desFrame;
                        }
                     completion:^(BOOL finished) {
                         
                     }];
    
}


- (void)addAnimationToNumber:(UIView *)number Index:(NSInteger)index{
    [UIView animateWithDuration:1.5
                          delay:(NumberAnimationDelay + index * .1)
         usingSpringWithDamping:.3
          initialSpringVelocity:3
                        options:UIViewAnimationOptionLayoutSubviews animations:^{
                            number.alpha = 1.f;
                        }
                     completion:^(BOOL finished) {
                         
                     }];
}


- (void)addAnimationToXLabel:(UILabel *)label AtIndex:(NSInteger)index;{
    
    [UIView animateWithDuration:.1f
                          delay:(XLabelAnimationDelay + .1*index)
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         label.frame = CGRectMake(CGRectGetMinX(label.frame), CGRectGetMinY(label.frame)-50, CGRectGetWidth(label.frame), CGRectGetHeight(label.frame));
                     }
                     completion:^(BOOL finished){
                     }];
}


@end
