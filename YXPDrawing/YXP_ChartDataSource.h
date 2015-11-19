//
//  YXP_ChartDataSource.h
//  YXPSeller-iPhone
//
//  Created by AdwardGreen on 15/8/26.
//  Copyright (c) 2015年 youxinpai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXP_ChartDataSource : NSObject

@property (nonatomic, copy) NSArray *chartValues;
@property (nonatomic, strong) NSString *carNoTime_;
@property (nonatomic, retain) NSMutableArray *personalValues;//个人价
@property (nonatomic, retain) NSMutableArray *merchartValues;//商家价
@property (nonatomic, retain) NSMutableArray *dateValues;//日期

@property (nonatomic) NSNumber *maxValue;
@property (nonatomic) NSNumber *minValue;

@property (nonatomic) NSNumber *currentDateValue;

-(instancetype)initWithChartValues:(NSArray *)chartValues WithCarNoTime:(NSString *)carNoTime;

- (NSNumber *)personalValueAtIndex:(NSInteger)index;
- (NSNumber *)merchartValueAtIndex:(NSInteger)index;

- (NSString *)dateValueAtIndex:(NSInteger)index;

@end


@interface YXP_CarStatusDataSource : NSObject

@property (nonatomic, copy) NSArray *chartValues;
@property (nonatomic) NSNumber *maxValue;
@property (nonatomic) NSNumber *minValue;

@property (nonatomic, retain) NSMutableArray *carNumbers;
@property (nonatomic, retain) NSMutableArray *dateValues;

-(instancetype)initWithChartValues:(NSArray *)chartValues;

-(NSString *)dateValueAtIndex:(NSInteger)index;
-(NSNumber *)numberValueAtIndex:(NSInteger)index;

@end




