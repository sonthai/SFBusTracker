//
//  TimeScheduleParser.h
//  SFBusTracker
//
//  Created by Son Thai on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeScheduleParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentNodeContent;
    NSMutableArray  *timeSchedule;
    NSXMLParser     *parser;
}

@property(nonatomic,strong) NSMutableArray *timeSchedule;

-(id) loadXMLByURL:(NSString *)urlString;


@end
