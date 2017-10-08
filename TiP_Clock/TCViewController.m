//
//  TCViewController.m
//  TiP_Clock
//
//  Created by Kyle Frost on 3/27/14.
//  Copyright (c) 2014 Today's iPhone. All rights reserved.
//

#import "TCViewController.h"

@interface TCViewController ()

@end

@implementation TCViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /******** 1 ********/
    [self updateClockLabel];
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

/******** 1 ********/
-(void)updateClockLabel {
    
    /******** 2 ********/
    NSDateFormatter *clockFormat = [[NSDateFormatter alloc] init];
    [clockFormat setDateFormat:@"h:mm a"];
    
    /******** 3 ********/
    self.clockLabel.text = [clockFormat stringFromDate:[NSDate date]];
    
    /******** 4 ********/
    [self performSelector:@selector(updateClockLabel) withObject:self afterDelay:1.0];
    
    /******** 2 ********/
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE - MMM d, YYYY"];
    
    /******** 3 ********/
    self.dateLabel.text = [dateFormat stringFromDate:[NSDate date]];
    
    /******** 4 ********/
    [self performSelector:@selector(updateDateLabel) withObject:self afterDelay:30.0];
}

-(void)updateDateLabel {
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        return YES;
    else
        return NO;
}

@end