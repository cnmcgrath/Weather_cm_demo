//
//  ViewController.m
//  WeatherApp
//
//  Created by Chris McGrath on 2/5/15.
//  Copyright (c) 2015 Chris McGrath. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *zipcode;
    NSDictionary *data;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDelegate:self];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWeather{
    WeatherData *weather = [[WeatherData alloc] init];
    [weather getDataFromWeatherServiceWithZipCode:zipcode :^(NSDictionary *weatherData, NSError *err) {
        if (err) {
            NSLog(@"%@",[err localizedFailureReason]);
        }else{
            //Update are UI
            data = weatherData;
            self.tempLabel.text = [weatherData objectForKey:@"temp"];
            self.conditionLabel.text = [weatherData objectForKey:@"remark"];
            self.jokeLabel.text = [weatherData objectForKey:@"wit"];
        }
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Locaiton Failed" message:@"Unable to find location" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation = newLocation;
    CLGeocoder *locationGeocoded = [[CLGeocoder alloc] init];
    [locationGeocoded reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        if (!placemark){
            NSLog(@"%@",error);
        }else{
            zipcode = [placemark.addressDictionary objectForKey:@"ZIP"];
            [self refreshWeather];
            [self.locationManager stopUpdatingLocation];
        }
    }];

}
- (IBAction)tweetWeatherButton:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *message = [NSString stringWithFormat:@"It's %@ out. %@",[NSString stringWithFormat:@"%@°?!",[data objectForKey:@"temp"]], [data objectForKey:@"remark"]];
        [tweetSheet setInitialText:message];
        [self presentViewController:tweetSheet animated:YES completion:nil];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                        message:@"Looks like you don't have a Twitter account linked to this device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    

    
}

- (IBAction)refreshWeatherButton:(id)sender {
    [self refreshWeather];
}
@end
