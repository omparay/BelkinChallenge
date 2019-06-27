//
//  NSDictionary+OpenWeatherData.h
//  iDeviceApp
//
//  Created by Oliver Paray on 6/27/19.
//  Copyright © 2019 Oliver Paray. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (OpenWeatherData)

- (NSDictionary *)fiveDayForecast;
- (NSDictionary *)todayForecast;

@end

NS_ASSUME_NONNULL_END
