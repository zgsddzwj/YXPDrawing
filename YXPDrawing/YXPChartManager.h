//
//  YXPChartManager.h
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXPChartManager : NSObject

@property (nonatomic, strong) UIView *drawView;
@property (nonatomic, strong) UIColor *gridColor;//竖线颜色
@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, assign) CGFloat contentWidth;//scrollView滑动区域

+(instancetype)sharedManager;

//竖线
- (void)drawLineAtIndex:(NSInteger)index;
//X坐标
-(void)drawXLabel:(NSString *)text index:(NSInteger)index animated:(BOOL)animated;
//X轴原点
- (void)drawOrignalX;
//横线
- (void)drawHorLine;

@end
