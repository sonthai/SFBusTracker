//
//  RouteParser.h
//  SFBusTracker
//
//  Created by Son Thai on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Route.h"

@interface RouteParser : NSObject<NSXMLParserDelegate>
{
    
    NSMutableString *currentNodeContent;
    NSMutableArray  *routes;
    NSXMLParser     *parser;
    Route           *currentRoute;
    
}

@property (readonly, retain) NSMutableArray *routes;

-(id) loadXMLByURL:(NSString *)urlString;

@end
