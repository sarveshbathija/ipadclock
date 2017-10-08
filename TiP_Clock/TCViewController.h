#import <UIKit/UIKit.h>

@interface TCViewController : UIViewController

/******** 1 ********/
@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

/******** 2 ********/
-(void)updateClockLabel;

@end