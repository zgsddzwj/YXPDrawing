//
//  YXPAnimationManager.h
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXPAnimationManager : NSObject

+ (instancetype)sharedManager;

- (void)addStokeAnimationToPath:(CALayer *)layer;
- (void)fadeOutView:(UIView *)view;
- (void)aggregate:(UILabel *)point ToOriginalPoint:(CGPoint)originalPoint;
- (void)addAnimationToVirturlPoint:(UIView *)point WithDelay:(CGFloat)delay;
- (void)addAnimationToPoint:(UIView *)point Index:(NSInteger)index toDes:(CGPoint)desPoint;
- (void)addAnimationToNumber:(UIView *)number Index:(NSInteger)index toDes:(CGRect)desFrame;
- (void)addAnimationToNumber:(UIView *)number Index:(NSInteger)index;

- (void)addAnimationToXLabel:(UILabel *)label AtIndex:(NSInteger)index;

@end
