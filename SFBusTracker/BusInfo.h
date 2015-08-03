//
//  BusInfo.h
//  SFBusTracker
//
//  Created by Son Thai on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusInfo : NSObject
{
    NSString *vehicle;
    NSString *time;
}

@property(nonatomic,strong) NSString *vehicle;
@property(nonatomic,strong) NSString *time;
@end
