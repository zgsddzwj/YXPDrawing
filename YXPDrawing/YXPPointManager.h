//
//  YXPPointManager.h
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXPPointManager : NSObject

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat maxRadius;//当前点半径

@property (nonatomic, assign) NSInteger dataCount;

@property (nonatomic, strong) UIView *virturlPointView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) CGFloat currentRadius;//7.0
@property (nonatomic, strong) UIView *drawView;



+ (instancetype)sharedManager;
//虚拟点
- (void)drawVirtrulPoints:(NSArray *)values color:(UIColor *)color;

- (void)drawPointWithValues:(NSArray *)values WithColor:(UIColor *)color animated:(BOOL)animated;
@end
