//
//  DirectionParser.h
//  SFBusTracker
//
//  Created by Son Thai on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stop.h"


@interface DirectionParser : NSObject<NSXMLParserDelegate>
{    
    NSMutableString *currentNodeContent;
    NSMutableArray  *directions;
    NSMutableDictionary *stopDictionary;
    NSXMLParser     *parser;
    Stop *currentStop;
    
    BOOL routeTag;
}

@property (nonatomic,strong) NSMutableArray *directions;
@property (nonatomic,strong) NSString *inbound;
@property (nonatomic,strong) NSString *outbound;
-(id) loadXMLByURL:(NSString *)urlString;
-(NSMutableDictionary*) getBusStopList;

@end
