//
//  BusLocationParser.m
//  SFBusTracker
//
//  Created by Son Thai on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusLocationParser.h"
#import "VehicleLocation.h"

@implementation BusLocationParser
@synthesize  busLocation;
- (id) loadXMLByURL:(NSString *)urlString
{
    busLocation      = [[NSMutableDictionary alloc] init];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData *data    = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementname isEqualToString:@"vehicle"])
    {
            VehicleLocation *vehicle = [[VehicleLocation alloc] init];
            vehicle.lat = [attributeDict objectForKey:@"lat"];
            vehicle.lon = [attributeDict objectForKey:@"lon"];
            [busLocation setObject:vehicle forKey:[attributeDict objectForKey:@"id"]];
    }
            
    
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString*) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
