//
//  FindBusStop.h
//  SFBusTracker
//
//  Created by Son Thai on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindLocation.h"
#import "GoogleXMLParser.h"

@interface GetInformation : UIViewController <UITableViewDelegate, FindLocationDelegate,UITextFieldDelegate> 
{
	FindLocation *CLController;
	IBOutlet UITextField *locText;
    IBOutlet UITextField *destText;
    NSString *travelMode;
    GoogleXMLParser *xmlParser;

}

@property (nonatomic, retain) FindLocation *CLController;
@property (nonatomic,strong) CLGeocoder *myGeocoder;
- (IBAction)buttonPressed:(UIButton*)sender;
- (IBAction)pickMode: (UISegmentedControl*) sender;

@end




