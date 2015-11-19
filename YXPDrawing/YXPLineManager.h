//
//  YXPLineManager.h
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/17.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)();

@interface YXPLineManager : NSObject

@property (nonatomic)     NSInteger dataCount;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic) CGFloat contractionFactor;//曲率(0~1,0.7)
@property (nonatomic, strong) UIView *drawView;
@property (nonatomic, strong) UIView *virturlPointView;


+ (instancetype)sharedManager;
//曲线
- (void)drawBezierPathLine:(NSArray *)values WithLineColor:(UIColor *)color Completion:(CompleteBlock)complete;
//填充图
- (void)fillPathWithValues:(NSArray *)values WithLineColor:(UIColor *)color;

@end
