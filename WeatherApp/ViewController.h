//
//  ViewController.h
//  WeatherApp
//
//  Created by Chris McGrath on 2/5/15.
//  Copyright (c) 2015 Chris McGrath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Twitter/Twitter.h>

#import "WeatherData.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *jokeLabel;

@property (strong, nonatomic)CLLocationManager *locationManager;

- (IBAction)tweetWeatherButton:(id)sender;
- (IBAction)refreshWeatherButton:(id)sender;

@end

