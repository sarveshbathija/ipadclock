#import <UIKit/UIKit.h>

@interface TCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *clockLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

-(void)updateClockLabel;

@end
