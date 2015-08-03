//
//  TimeScheduleParser.m
//  SFBusTracker
//
//  Created by Son Thai on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeScheduleParser.h"
#import "BusInfo.h"

@implementation TimeScheduleParser
@synthesize timeSchedule;

- (id) loadXMLByURL:(NSString *)urlString
{
    timeSchedule      = [[NSMutableArray alloc] init];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData *data    = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementname isEqualToString:@"prediction"])
    {
        BusInfo *bus = [[BusInfo alloc] init];
        bus.time = [attributeDict objectForKey:@"minutes"];
        bus.vehicle = [attributeDict objectForKey:@"vehicle"];
        
        [timeSchedule addObject:bus];
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString*) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



@end
