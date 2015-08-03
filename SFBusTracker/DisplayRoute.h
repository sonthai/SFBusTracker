//
//  DisplayRoute.h
//  SFBusTracker
//
//  Created by Son Thai on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GetInformation.h"

@interface DisplayRoute : UIViewController<MKMapViewDelegate,NSXMLParserDelegate>
{
    GoogleXMLParser *xmlParser;
    NSArray *newArray;
    MKPolyline* _routeLine;
    MKPolylineView* _routeLineView;
    MKMapRect routeRect;
    
}

@property(nonatomic,strong) MKMapView *map;
@property(nonatomic,strong) MKPolyline* routeLine;
@property (nonatomic,strong) NSString *start;
@property (nonatomic,strong) NSString *end;
@property (nonatomic,strong) NSString *travelMode;
@property(nonatomic,strong) MKPolylineView* routeLineView;

- (void) loadRoute;
- (void) addPinPoints;
- (void) zoomInOnRoute;
- (NSArray *)decodePolylineOfGoogleMaps:(NSString *)encodedPolyline;

@end
