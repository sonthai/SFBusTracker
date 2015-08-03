//
//  VehicleLocation.h
//  SFBusTracker
//
//  Created by Son Thai on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VehicleLocation : NSObject
{
    NSString *lon;
    NSString *lat;
}
@property(nonatomic,strong) NSString *lon;
@property(nonatomic,strong) NSString *lat;
@end
