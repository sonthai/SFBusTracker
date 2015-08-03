//
//  RouteParser.m
//  SFBusTracker
//
//  Created by Son Thai on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RouteParser.h"

@implementation RouteParser
@synthesize routes;

- (id) loadXMLByURL:(NSString *)urlString
{
    routes          = [[NSMutableArray alloc] init];
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData *data    = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{

    if ([elementname isEqualToString:@"route"])
    {
        currentRoute = [[Route alloc] init];
        currentRoute.tag = [attributeDict objectForKey:@"tag"];
        currentRoute.title = [attributeDict objectForKey:@"title"];
        [routes addObject:currentRoute];
    }
}


- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString*) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
