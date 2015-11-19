//
//  YXPDrawingManager.h
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXPDrawingManager : NSObject

@property (nonatomic, assign) float maxValue;
@property (nonatomic, assign) float minValue;
@property (nonatomic, assign) CGFloat chartHeight;//默认view.height-20
@property (nonatomic, assign) CGFloat chartStartX;//1/12view.width
@property (nonatomic, assign) CGFloat chartXInterval;//1/6view.width




+ (instancetype)sharedManager;
//加一个测试数据，画在Y轴上
- (CGFloat )adjustNumberTo:(NSArray *)arr;
//末端测试数据，画在Y轴上
- (CGFloat )adjustNumberToEnd:(NSArray *)arr;

- (CGFloat)pointYWithValue:(CGFloat)value;
-(CGPoint)pointWithValue:(CGFloat)value index:(NSInteger)index;

@end
