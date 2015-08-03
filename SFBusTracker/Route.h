//
//  Route.h
//  SFBusTracker
//
//  Created by Son Thai on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject
{
    NSString *tag;
    NSString *title;
}

@property(nonatomic,strong) NSString *tag;
@property(nonatomic,strong) NSString *title;

@end
