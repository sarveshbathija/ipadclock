//
//  MeetupCommunicatorDelegate.h
//  TiP_Clock
//
//  Created by Sarvesh Bathija on 1/6/19.
//
//


@protocol MeetupCommunicatorDelegate <NSObject>
- (void)receivedGroupsJSON:(NSData *)objectNotation;
- (void)fetchingGroupsFailedWithError:(NSError *)error;
@end
