//
//  NSDictionary+OpenWeatherData.m
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import "NSDictionary+OpenWeatherData.h"

@implementation NSDictionary (OpenWeatherData)

- (NSDictionary *)fiveDayForecast{
    NSArray *list = [self valueForKeyPath:@"list"];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];

    for (NSDictionary *json in list) {
        NSString *itemDate = (NSString *)[json valueForKey:@"dt_txt"];
        NSArray *components = [itemDate componentsSeparatedByString:@" "];
        NSString *component0 = components[0];

        if (result[component0] == nil){
            result[component0] = json;
        }
    }

    return result;
}

- (NSDictionary *)todayForecast{
    NSDictionary *result;
    NSDictionary *buffer = [self fiveDayForecast];

    NSArray *keys = [buffer allKeys];
    NSArray *sorted = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *string1 = (NSString *)obj1;
        NSString *string2 = (NSString *)obj2;
        return [string1 caseInsensitiveCompare:string2];
    }];

    result = buffer[sorted[0]];

    return result;
}

@end
