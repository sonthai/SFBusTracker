//
//  BusLocationParser.h
//  SFBusTracker
//
//  Created by Son Thai on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusLocationParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentNodeContent;
    NSMutableDictionary  *busLocation;
    NSXMLParser     *parser;
}

@property(nonatomic,strong) NSMutableDictionary *busLocation;


-(id) loadXMLByURL:(NSString *)urlString;

@end
