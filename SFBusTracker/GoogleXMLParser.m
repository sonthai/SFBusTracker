//
//  GoogleXMLParser.m
//  SFBusTracker
//
//  Created by Son Thai on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GoogleXMLParser.h"

@implementation GoogleXMLParser
@synthesize directions;
@synthesize pointArr;
@synthesize polylines;
@synthesize warning;

- (id) loadXMLByURL:(NSString *)urlString
{
    directions      = [[NSMutableArray alloc] init];
    pointArr        = [[NSMutableArray  alloc] init];
    starTag         = FALSE;
    endTag          = FALSE;
    dstTag          = FALSE;
    durationTag     = FALSE;
    polyTag         = FALSE;
    NSURL *url      = [NSURL URLWithString:urlString];
    NSData *data    = [[NSData alloc] initWithContentsOfURL:url];
    parser          = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    currentNodeContent = [elementname copy];
    if ([elementname isEqualToString:@"step"])
    {
        dirInfo = [[DirectionInformation alloc] init];
    }
    
    if ([elementname isEqualToString:@"start_location"]) 
    {
        location  =  [[VehicleLocation alloc] init];
        location.lat = [NSMutableString string];
        location.lon = [NSMutableString string];
        starTag = TRUE;
    }
    
    if ([elementname isEqualToString:@"end_location"])
    {
        location  =  [[VehicleLocation alloc] init];
        location.lat = [NSMutableString string];
        location.lon = [NSMutableString string];
        endTag = TRUE;
    }
    
            
    if ([elementname isEqualToString:@"overview_polyline"])
    {
        polylines = [NSMutableString string];
        polyTag = TRUE;
    }
    
    if ([elementname isEqualToString:@"html_instructions"])
    {
        dirInfo.instructions = [NSMutableString string];
    }
    
    if ([elementname isEqualToString:@"duration"])
    {
        durationTag = TRUE;
  
    }
    
    if ([elementname isEqualToString:@"duration"])
    {
        durationTag = TRUE;
        
    }
    if (durationTag)
    {
        if ([elementname isEqualToString:@"text"])
            dirInfo.duration =  [NSMutableString string];;
    }
    
    if ([elementname isEqualToString:@"distance"]) {
        dstTag = TRUE;
        
    }
    
    if (dstTag)
    {
        if ([elementname isEqualToString:@"text"])
            dirInfo.distance =  [NSMutableString string];;
    }
    
    if ([elementname isEqualToString:@"warning"])
    {
        warning = [NSMutableString string];
    }
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([currentNodeContent isEqualToString:@"html_instructions"])
    {
        dirInfo.instructions = (NSMutableString*) [self flattenHTML:dirInfo.instructions];
    }
    if (polyTag)
    {
        if ([currentNodeContent isEqualToString:@"points"])
        {
            polyTag = FALSE;
        }
    }
    
    if ([currentNodeContent isEqualToString:@"text"])
    {
        if (dstTag)
        {
            dstTag = FALSE;
            [directions addObject:dirInfo];
        }
        
        if (durationTag)
        {
            durationTag = FALSE;
            
        }
    }
    
    if (starTag)
    { 
        if ([currentNodeContent isEqualToString:@"lng"])
        {
      
            [pointArr addObject:location];
            starTag = FALSE;
        }
    }
    
    if (endTag)
    {
        if ([currentNodeContent isEqualToString:@"lng"])
        {
            [pointArr addObject:location];
            endTag = FALSE;
        }
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([currentNodeContent isEqualToString:@"html_instructions"])
    {
        [dirInfo.instructions appendString:string];
    }
   
    
    if ([currentNodeContent isEqualToString:@"text"])
    {
        if (dstTag)
        {
            [dirInfo.distance appendString:string];
        }
    
        if(durationTag)
        {
            [dirInfo.duration appendString:string];
        }
    }
    
    if (polyTag)
    {
        if ([currentNodeContent isEqualToString:@"points"])
            [polylines appendString:string];
    }
    
    if (starTag)
    {
        if  ([currentNodeContent isEqualToString: @"lat"])
        {
            [(NSMutableString*) location.lat appendString:string];
      
        }
    
        if ([currentNodeContent isEqualToString:@"lng"])
        {
            [(NSMutableString*) location.lon appendString:string];
        }
           
    }
    
    if (endTag)
    {
        if  ([currentNodeContent isEqualToString: @"lat"])
        {
            [(NSMutableString*) location.lat appendString:string];
            
        }
        
        if ([currentNodeContent isEqualToString:@"lng"])
        {
            [(NSMutableString*) location.lon appendString:string];
        }
        
    }
    
    if ([currentNodeContent isEqualToString:@"warning"])
    {
        [warning appendString:string];
    }
  
            
}

- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ; 
        
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } 
    return html;
}


@end
