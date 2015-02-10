//
//  WeatherData.m
//  WeatherApp
//
//  Created by Chris McGrath on 2/5/15.
//  Copyright (c) 2015 Chris McGrath. All rights reserved.
//

#import "WeatherData.h"

@implementation WeatherData

- (void)getDataFromWeatherServiceWithZipCode:(NSString*)zipcode :(void (^)(NSDictionary *weatherData, NSError *err))block{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://35.11.202.208/%@",zipcode]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //Handle response code here
        if (connectionError) {
            //Handle Error
            NSLog(@"%@",[connectionError localizedFailureReason]);
        }else{
            //We actually got a response that wasn't a failure
            NSError *err = nil;
            NSDictionary *raw = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
            block(raw,nil);
        }
    }];
}


@end
