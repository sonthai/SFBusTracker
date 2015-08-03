//
//  FindBusStop.m
//  SFBusTracker
//
//  Created by Son Thai on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetInformation.h"
#import "DirectionInstructions.h"
#import "DisplayRoute.h"


@implementation GetInformation
@synthesize CLController;
@synthesize myGeocoder;

- (void)viewDidLoad {
    [super viewDidLoad];	
	self.CLController = [[FindLocation alloc] init];
	self.CLController.delegate = self;
    locText.delegate = self;
    destText.delegate = self;
    locText.clearButtonMode = UITextFieldViewModeWhileEditing;
    destText.clearButtonMode =  UITextFieldViewModeWhileEditing;
	[self.CLController.locMgr startUpdatingLocation];
}

- (void) viewWillAppear:(BOOL)animated
{
    if ([[locText text] isEqualToString:@""])
        [self.CLController.locMgr startUpdatingLocation];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)locationUpdate:(CLLocation *)location {
    self.myGeocoder =[[CLGeocoder alloc] init];
    [self.myGeocoder reverseGeocodeLocation:location completionHandler: 
     ^(NSArray *placemarks, NSError *error) {
         if (error == nil && [placemarks count] > 0) 
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *s; 
             s = [[placemark.name stringByAppendingString:@", "] stringByAppendingString:placemark.locality];
             locText.text = s;
         }
         else if (error == nil && [placemarks count] == 0) 
         {
             locText.text = @"No results were returned";
         }
         else if (error != nil) {
             locText.text = @"An error occrured";
         }
     }];
    
    [self.CLController.locMgr stopUpdatingLocation];
}

- (void)locationError:(NSError *)error {
	locText.text = [error description];
}

- (IBAction)buttonPressed:(UIButton*)sender 
{
    if (sender.tag == 1) {
        DirectionInstructions *info = [[DirectionInstructions alloc] init];
        info.start = locText.text; 
        info.end   = destText.text; 
        info.travelMode = travelMode;
        [self.navigationController pushViewController:info animated:YES];
    }
    else 
    {
        DisplayRoute *info = [[DisplayRoute alloc] init];
        info.start = locText.text; 
        info.end   = destText.text; 
        info.travelMode = travelMode;
        [self.navigationController pushViewController:info animated:YES];
    }
}

- (IBAction) pickMode: (UISegmentedControl*) sender
{
    UISegmentedControl *mode = (UISegmentedControl*) sender;
    travelMode = [mode titleForSegmentAtIndex:[mode selectedSegmentIndex]];
}





@end
