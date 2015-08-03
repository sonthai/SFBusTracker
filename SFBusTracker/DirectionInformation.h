//
//  DirectionInformation.h
//  SFBusTracker
//
//  Created by Son Thai on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectionInformation : NSObject
{
    NSMutableString *duration;
    NSMutableString *distance;
    NSMutableString *instructions;

}

@property(nonatomic,strong) NSMutableString *duration;
@property(nonatomic,strong) NSMutableString *distance;
@property(nonatomic,strong) NSMutableString *instructions;

@end
