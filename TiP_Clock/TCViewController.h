#import <UIKit/UIKit.h>

@interface TCViewController : UIViewController {
    IBOutlet UILabel* humanReadble;
    IBOutlet UILabel* jsonSummary;
}

@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *forecastText;
@property (weak, nonatomic) IBOutlet UILabel *forecastHigh;
@property (weak, nonatomic) IBOutlet UILabel *forecastLow;

-(void)updateClockLabel;

@end
