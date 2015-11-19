//
//  UIBezierPath+EMThroughPointsBezier.h
//  EMChart
//
//  Created by YXP on 15/8/15.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (EMThroughPointsBezier)

/**
 *  The curve‘s bend level. The good value is about 0.6 ~ 0.8. The default and recommended value is 0.7.
 */
@property (nonatomic, assign) CGFloat contractionFactor;

/**
 *  You must wrap CGPoint struct to NSValue object.
 *
 *  @param pointArray Points you want to through. You must give at least 1 point for drawing curve.
 */
- (void)addBezierThroughPoints:(NSArray *)pointArray;

CGPoint CenterPointOf(CGPoint point1, CGPoint point2);


@end
