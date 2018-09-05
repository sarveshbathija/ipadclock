//
//  TCViewController.m
//  TiP_Clock
//
//  Created by Kyle Frost on 3/27/14.
//  Copyright (c) 2014 Today's iPhone. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define yahooWeatherURL [NSURL URLWithString:@"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22union%20city%2C%20ca%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"]

#define sarveshURL [NSURL URLWithString:@"http://sarveshbathija.myq-see.com:81/~sarveshbathija/ipadclock/custom_message.php"]

#import "TCViewController.h"

@interface TCViewController ()
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) int index;
@end

@implementation TCViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self updateClockLabel];
    [self updateDateLabel];
    [self getTemp];
    //[self getCustomMessage];
    
    UIColor *color = [UIColor redColor];
    [self.clockLabel setTextColor:color];
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    self.colors = @[
                    [UIColor colorWithRed:0.42 green:0.73 blue:0.45 alpha:1.0],
                    [UIColor colorWithRed:0.23 green:0.73 blue:0.62 alpha:1.0],
                    [UIColor colorWithRed:0.30 green:0.65 blue:0.39 alpha:1.0],
                    [UIColor colorWithRed:0.17 green:0.65 blue:0.53 alpha:1.0],
                    [UIColor colorWithRed:0.36 green:0.68 blue:0.81 alpha:1.0],
                    [UIColor colorWithRed:0.21 green:0.52 blue:0.77 alpha:1.0],
                    [UIColor colorWithRed:0.27 green:0.56 blue:0.71 alpha:1.0],
                    [UIColor colorWithRed:0.18 green:0.42 blue:0.68 alpha:1.0],
                    [UIColor colorWithRed:0.28 green:0.34 blue:0.46 alpha:1.0],
                    [UIColor colorWithRed:0.16 green:0.20 blue:0.30 alpha:1.0],
                    [UIColor colorWithRed:0.60 green:0.00 blue:0.00 alpha:1.0],
                    [UIColor colorWithRed:0.56 green:0.41 blue:0.71 alpha:1.0],
                    [UIColor colorWithRed:0.33 green:0.24 blue:0.50 alpha:1.0],
                    [UIColor colorWithRed:0.95 green:0.83 blue:0.44 alpha:1.0],
                    [UIColor colorWithRed:0.97 green:0.76 blue:0.24 alpha:1.0],
                    [UIColor colorWithRed:0.97 green:0.62 blue:0.24 alpha:1.0],
                    [UIColor colorWithRed:0.90 green:0.42 blue:0.36 alpha:1.0],
                    [UIColor colorWithRed:0.80 green:0.28 blue:0.27 alpha:1.0],
                    [UIColor colorWithRed:0.86 green:0.31 blue:0.28 alpha:1.0],
                    [UIColor colorWithRed:0.70 green:0.20 blue:0.20 alpha:1.0],
                    [UIColor colorWithRed:0.64 green:0.56 blue:0.52 alpha:1.0],
                    [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0],
                    [UIColor colorWithRed:0.82 green:0.84 blue:0.85 alpha:1.0],
                    [UIColor colorWithRed:0.46 green:0.44 blue:0.42 alpha:1.0],
                    [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.0]
                    ];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    self.index = 0;
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    [self.clockLabel setTextColor:[self.colors objectAtIndex:self.index]];
    
    self.index++;
    
    if (self.index >= self.colors.count) {
        self.index = 0;
    }
}


- (void)getTemp {
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        yahooWeatherURL];
        //NSLog(@"value of a is : %@ !\n", data);
        if (data) {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        } else {
            self.forecastText.text = @"Data Error";
        }
    });
    [self performSelector:@selector(getTemp) withObject:self afterDelay:10.0];
    
}

- (void)getTempError {
    
    [self performSelector:@selector(getTemp) withObject:self afterDelay:60.0];
    
    
}

- (void)getCustomMessage {
    dispatch_async(kBgQueue, ^{
        NSData* customData = [NSData dataWithContentsOfURL:
                              sarveshURL];
        if (customData) {
            [self performSelectorOnMainThread:@selector(fetchedCustomMessage:) withObject:customData waitUntilDone:YES];
        }
        
    });
}

- (void)fetchedCustomMessage:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    self.custom.text = [json objectForKey:@"custom"];
    
    [self performSelector:@selector(getCustomMessage) withObject:self afterDelay:60.0];
    
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
    
    NSDictionary* weather = [json objectForKey:@"query"]; //2
    
    NSDictionary* results = [weather objectForKey:@"results"];
    
    NSDictionary* channel = [results objectForKey:@"channel"];
    
    NSDictionary* item = [channel objectForKey:@"item"];
    
    NSDictionary* condition = [item objectForKey:@"condition"];
    
    NSArray* forecast = [item objectForKey:@"forecast"];
    
    NSDictionary* latestForecast = [forecast objectAtIndex:0];
    
    self.forecastText.text =[condition objectForKey:@"text"];
    self.forecastHigh.text =[latestForecast objectForKey:@"high"];
    self.forecastLow.text =[latestForecast objectForKey:@"low"];
    
    self.currentTempLabel.text = [condition objectForKey:@"temp"];
    
    
}

-(void)updateClockLabel {
    
    NSDateFormatter *clockFormat = [[NSDateFormatter alloc] init];
    
    [clockFormat setDateFormat:@"h:mm"];
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger second = [components second];
    
    //    NSLog(@"value of a is : %d !\n", second);
    
    //    if (hour == 5 || hour == 20) {
    //        self.custom.text = @"YOU CAN DO IT DOLLY!";
    //    }
    //    else {
    //        self.custom.text = @"";
    //    }
    
    self.clockLabel.text = [clockFormat stringFromDate:[NSDate date]];
    
    [self performSelector:@selector(updateClockLabel) withObject:self afterDelay:1.0];
}

-(void)updateDateLabel {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE - MMM d, YYYY"];
    self.dateLabel.text = [dateFormat stringFromDate:[NSDate date]];
    [self performSelector:@selector(updateDateLabel) withObject:self afterDelay:30.0];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        return YES;
    else
        return NO;
}

@end
