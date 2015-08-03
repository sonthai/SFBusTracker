//
//  MyAnnotation.m
//  SFBusTracker
//
//  Created by Son Thai on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
@synthesize coordinate ;
@synthesize subtitle = _subtitle;
@synthesize title = _title;
@synthesize pinColor = _pinColor;

+ (NSString*) reusableIdetifierforPinColor: (MKPinAnnotationColor) paramColor
{
    NSString* result = nil;
    switch (paramColor)
    {
        case MKPinAnnotationColorRed:
        {
            result = REUSABLE_PIN_RED;
            break;
        }
        case MKPinAnnotationColorGreen:
        {
            result = REUSABLE_PIN_GREEN;
            break;
        }
        case MKPinAnnotationColorPurple:
        {
            result = REUSABLE_PIN_PURPLE;
            break;
        }
    }
    return result;
}

- (id) initWithCoordinates: (CLLocationCoordinate2D) paramCoordinates
                     title: (NSString*) paramTitile
                  subTitle:(NSString*) paramSubTitle
{
    self = [super init];
    if (self != nil)
    {
        coordinate = paramCoordinates;
        self.title = paramTitile;
        self.subtitle = paramSubTitle;
        self.pinColor = MKPinAnnotationColorGreen;
    }
    return self;
        
    
}
@end
