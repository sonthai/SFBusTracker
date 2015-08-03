//
//  DirectionController.h
//  SFBusTracker
//
//  Created by Son Thai on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DirectionParser.h"

@interface DirectionController : UITableViewController
{
    DirectionParser *xmlParser;
}
@property (nonatomic,strong) NSString *tag;

@end
