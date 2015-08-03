//
//  StopController.h
//  SFBusTracker
//
//  Created by Son Thai on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface StopController : UITableViewController<NSXMLParserDelegate>
{
    NSMutableString *currentNodeContent;
    NSMutableArray  *stopArr;
    NSMutableArray *stopList;
    NSXMLParser     *parser;
    BOOL stopTag;
}

@property(nonatomic,strong) NSMutableDictionary *stopDictionary;
@property(nonatomic,strong) NSString *direction; 
@property(nonatomic,strong) NSString *tag;
@property(nonatomic,strong) NSMutableArray *stopArr;

-(void) loadXMLByURL:(NSString *)urlString;
-(void) matchBusStop;

@end
