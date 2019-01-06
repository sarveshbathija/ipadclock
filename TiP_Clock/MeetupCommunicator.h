//
//  MeetupCommunicator.h
//  TiP_Clock
//
//  Created by Sarvesh Bathija on 1/6/19.
//
//

#import <Foundation/Foundation.h>

@protocol MeetupCommunicator <NSObject>
@interface MeetupCommunicator : NSObject
@property (weak, nonatomic) id delegate;

- (void)searchGroupsAtCoordinate:(CLLocationCoordinate2D)coordinate;
@end
