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

@end

@implementation TCViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self updateClockLabel];
    [self updateDateLabel];
    [self getTemp];
    [self getCustomMessage];
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    

}

- (void)getTemp {
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        yahooWeatherURL];
        if (data) {
            [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        }
    });
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
    
    [self performSelector:@selector(getTemp) withObject:self afterDelay:60.0];
    
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
