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
    [self updateClockLabel];
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

-(void)updateClockLabel {
    
    NSDateFormatter *clockFormat = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    self.clockLabel.text = [clockFormat stringFromDate:[NSDate date]];
    self.dateLabel.text = [dateFormat stringFromDate:[NSDate date]];

    [dateFormat setDateFormat:@"EEEE - MMM d, YYYY"];
    [clockFormat setDateFormat:@"h:mm"];
    
    [self performSelector:@selector(updateClockLabel) withObject:self afterDelay:1.0];
    [self performSelector:@selector(updateDateLabel) withObject:self afterDelay:30.0];
}

-(void)updateDateLabel {
    

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
