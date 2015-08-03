//
//  MyAnnotation.h
//  SFBusTracker
//
//  Created by Son Thai on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#define REUSABLE_PIN_RED @"Red"
#define REUSABLE_PIN_GREEN @"Green"
#define REUSABLE_PIN_PURPLE @"Purple"
@interface MyAnnotation : NSObject<MKAnnotation>
@property(nonatomic,unsafe_unretained,readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;

@property(nonatomic,unsafe_unretained) MKPinAnnotationColor pinColor;

- (id) initWithCoordinates: (CLLocationCoordinate2D) paramCoordinates
                     title: (NSString*) paramTitile
                  subTitle:(NSString*) paramSubTitle;

+ (NSString*) reusableIdetifierforPinColor: (MKPinAnnotationColor) paramColor;
                    

@end
