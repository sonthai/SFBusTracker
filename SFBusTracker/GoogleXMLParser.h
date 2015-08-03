//
//  GoogleXMLParser.h
//  SFBusTracker
//
//  Created by Son Thai on 3/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionInformation.h"
#import "VehicleLocation.h"


@interface GoogleXMLParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentNodeContent;
    NSMutableArray  *directions;
    NSXMLParser     *parser;
    NSMutableString *polylines;
    NSMutableString *warning;
    DirectionInformation *dirInfo;
    VehicleLocation *location;
    BOOL dstTag, durationTag, starTag, endTag, polyTag;
}

@property (nonatomic,strong) NSMutableArray *directions;
@property (nonatomic,strong) NSMutableArray *pointArr;
@property (nonatomic,strong) NSMutableString *polylines;
@property (nonatomic,strong) NSMutableString *warning;
-(id) loadXMLByURL:(NSString *)urlString;
- (NSString *)flattenHTML:(NSString *)html;

@end
