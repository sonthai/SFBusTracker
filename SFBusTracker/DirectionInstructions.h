//
//  FindClosestBusStop.h
//  SFBusTracker
//
//  Created by Son Thai on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GoogleXMLParser.h"
@interface DirectionInstructions : UITableViewController<NSXMLParserDelegate>
{
    GoogleXMLParser *xmlParser;
}
@property (nonatomic,strong) NSString *start;
@property (nonatomic,strong) NSString *end;
@property (nonatomic,strong) NSString *travelMode;

@end
