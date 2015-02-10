//
//  WeatherData.h
//  WeatherApp
//
//  Created by Chris McGrath on 2/5/15.
//  Copyright (c) 2015 Chris McGrath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherData : NSObject

- (void)getDataFromWeatherServiceWithZipCode:(NSString*)zipcode :(void (^)(NSDictionary *weatherData, NSError *err))block;


@end
