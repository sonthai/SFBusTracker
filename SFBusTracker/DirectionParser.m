//
//  DirectionParser.m
//  SFBusTracker
//
//  Created by Son Thai on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DirectionParser.h"
#import "Stop.h"


@implementation DirectionParser
@synthesize directions;
@synthesize outbound;
@synthesize inbound;


- (id) init 
{
    routeTag = TRUE;
    self = [super init];
    return self;
}


- (id) loadXMLByURL:(NSString *)urlString
{
    directions      = [[NSMutableArray alloc] init];
    stopDictionary  = [[NSMutableDictionary alloc] init];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData *data    = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"elementName %@",elementname);
    if ([elementname isEqualToString:@"route"])
    {
        routeTag = TRUE;
    }
    
    if (routeTag)
    {
        if ([elementname isEqualToString:@"stop"])
        {
            currentStop = [[Stop alloc] init];
            currentStop.tag = [attributeDict objectForKey:@"tag"];
            currentStop.title = [attributeDict objectForKey:@"title"];
            currentStop.lat = [attributeDict objectForKey:@"lat"];
            currentStop.lon = [attributeDict objectForKey:@"lon"];
            currentStop.stopID = [attributeDict objectForKey:@"stopId"];
            
            [stopDictionary setObject:currentStop forKey:currentStop.tag];
        }
    }
 
    if ([elementname isEqualToString:@"direction"])
    {
        routeTag = FALSE;
       
        if([[attributeDict objectForKey:@"name"] isEqualToString: @"Outbound"])
        {
            self.outbound = [attributeDict objectForKey:@"title"];
            [directions addObject:self.outbound];
        }
        else
        {
            self.inbound = [attributeDict objectForKey:@"title"];
            [directions addObject:self.inbound];
        }
    }
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString*) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSMutableDictionary*) getBusStopList
{
    return stopDictionary;
}


@end
