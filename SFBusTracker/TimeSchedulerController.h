//
//  TimeSchedulerController.h
//  SFBusTracker
//
//  Created by Son Thai on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeScheduleParser.h"
@interface TimeSchedulerController : UITableViewController
{
    TimeScheduleParser *xmlParser;
}

@property(nonatomic,strong) NSString *route_tag;
@property(nonatomic,strong) NSString *stopId;
@property(nonatomic,strong) NSMutableArray *stopList;
@property(nonatomic,strong) NSString *direction;
@end
