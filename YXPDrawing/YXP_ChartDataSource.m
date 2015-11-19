//
//  YXP_ChartDataSource.m
//  YXPSeller-iPhone
//
//  Created by AdwardGreen on 15/8/26.
//  Copyright (c) 2015年 youxinpai. All rights reserved.
//

#import "YXP_ChartDataSource.h"
//#import "NSArray+Safe.h"
//#import "OCDefine.h"

@implementation YXP_ChartDataSource

-(instancetype)initWithChartValues:(NSArray *)chartValues WithCarNoTime:(NSString *)carNoTime{
    if (self = [super init]) {
        _chartValues = chartValues;
        _carNoTime_ = carNoTime;
        [self configureDataSource];
    }
    return self;
}

- (void)initDataSource{
    if (_dateValues == nil) {
        _dateValues = [NSMutableArray array];
    }
    if (_personalValues == nil) {
        _personalValues = [NSMutableArray array];
    }
    if (_merchartValues == nil) {
        _merchartValues = [NSMutableArray array];
    }
}

- (void)configureDataSource{
    
    [self initDataSource];
    
    
    for (int idx = 0; idx < _chartValues.count; idx ++) {
        
        NSDictionary *obj = (NSDictionary *)[_chartValues objectAtIndex:idx];
        NSObject *dataValue = [obj objectForKey:@"v_x"]?[obj objectForKey:@"v_x"]:nil;
        NSObject *personValue = [obj objectForKey:@"v_y"]?[obj objectForKey:@"v_y"]:nil;
        NSObject *merchartValue = [obj objectForKey:@"v_y_s"]?[obj objectForKey:@"v_y_s"]:nil;
        [_dateValues addObject:dataValue];
        [_personalValues addObject:personValue];
        [_merchartValues addObject:merchartValue];
        
    }
    
//    _dateValues = [@[_T(@"1年"),_T(@"2年"),_T(@"3年"),_T(@"4年"),_T(@"5年及以上")] mutableCopy];
    
    [self caculateMaxValue];
    [self caculateMinValue];
    [self caculateCurrentDateIndex];
    
}

-(NSString *)dateValueAtIndex:(NSInteger)index{
    return [_dateValues objectAtIndex:index];
}


-(NSNumber *)personalValueAtIndex:(NSInteger)index{
    return [_personalValues objectAtIndex:index];
}

-(NSNumber *)merchartValueAtIndex:(NSInteger)index{
    return [_merchartValues objectAtIndex:index];
}


-(void)caculateMaxValue{
    float max = 0;
    for (int i=0; i<_chartValues.count; i++) {
        float value=[[self personalValueAtIndex:i] floatValue];
        max= value>max?value:max;
    }
    for (int i=0; i<_chartValues.count; i++) {
        float value=[[self merchartValueAtIndex:i] floatValue];
        max= value>max?value:max;
    }
    max =  (max > 0)?max : MAXFLOAT;
    _maxValue = @(max);
}

-(void)caculateMinValue{
    float min = MAXFLOAT;
    for (int i=0; i<_chartValues.count; i++) {
        float value=[[self personalValueAtIndex:i] floatValue];
        min= value<min?value:min;
    }
    for (int i=0; i<_chartValues.count; i++) {
        float value=[[self merchartValueAtIndex:i] floatValue];
        min= value<min?value:min;
    }
    _minValue = @(min);
}


- (void)caculateCurrentDateIndex{
    
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger currentYear = [dateComponent year];
    
    NSInteger carNoYear = (self.carNoTime_)?[[[self.carNoTime_ componentsSeparatedByString:@"-"] firstObject] integerValue]:currentYear;
    
    
    NSInteger index = 0;
    
    NSInteger calIndex = (currentYear - carNoYear);
    
    if (calIndex <= 0) {
        index = 0;
    }else if (calIndex > 0 && calIndex <= 4){
        index = calIndex - 1;
    }else{
        index = 4;
    }
    
    
    self.currentDateValue = @(index);
}

@end


@implementation YXP_CarStatusDataSource

-(instancetype)initWithChartValues:(NSArray *)chartValues{
    if (self == [super init]) {
        _chartValues = chartValues;
        [self configureDataSource];
    }return self;
}

-(void)configureDataSource{
    
    _carNumbers = [NSMutableArray arrayWithCapacity:_chartValues.count];
    _dateValues = [NSMutableArray arrayWithCapacity:_chartValues.count];
    
    [_chartValues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        NSDictionary *value = (NSDictionary *)obj;
        [_carNumbers addObject:[value objectForKey:@"v_y"]];
        [_dateValues addObject:[value objectForKey:@"v_x"]];
    }];
    
    [self caculateMaxValue];
    [self caculateMinValue];
}

-(void)caculateMaxValue{
    float max = 0;
    for (int i=0; i<_chartValues.count; i++) {
        float value=[[self numberValueAtIndex:i] floatValue];
        max= value>max?value:max;
    }
    max =  (max > 0)?max : MAXFLOAT;
    _maxValue = @(max);
}

-(void)caculateMinValue{
    float min = MAXFLOAT;
    for (int i=0; i<_chartValues.count; i++) {
        float value=[[self numberValueAtIndex:i] floatValue];
        min= value<min?value:min;
    }
    _minValue = @(min);
}

-(NSString *)dateValueAtIndex:(NSInteger)index{
    return [_dateValues objectAtIndex:index];
}


-(NSNumber *)numberValueAtIndex:(NSInteger)index{
    return [_carNumbers objectAtIndex:index];
}



@end



