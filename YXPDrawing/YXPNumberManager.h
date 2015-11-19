//
//  YXPNumberManager.h
//  YXPDrawing
//
//  Created by AdwardGreen on 15/11/18.
//  Copyright © 2015年 AdwardGreen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YXPNumberManager : NSObject


@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger dataCount;

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIView *drawView;

@property (nonatomic, assign) NSInteger fontSize;
@property (nonatomic, strong) UIColor *valueColor;

+ (instancetype)sharedManager;

- (void)drawNumberWithValues:(NSArray *)values WithColor:(UIColor *)color margin:(CGFloat)margin;

- (void)drawStaticNumberWithValues:(NSArray *)values margin:(CGFloat)margin;

@end
