//
//  Stop.h
//  SFBusTracker
//
//  Created by Son Thai on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stop : NSObject
{
    NSString *tag;
    NSString *title;
    NSString *stopID;
    NSString *lon;
    NSString *lat;
}

@property(nonatomic,strong) NSString *tag;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *stopID;
@property(nonatomic,strong) NSString *lon;
@property(nonatomic,strong) NSString *lat;
@end
