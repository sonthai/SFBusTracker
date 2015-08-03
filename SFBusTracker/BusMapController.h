//
//  BusMapController.h
//  SFBusTracker
//
//  Created by Son Thai on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BusLocationParser.h"

@interface BusMapController : UIViewController<MKMapViewDelegate>
{
    MKPolyline* _routeLine;
    MKPolylineView* _routeLineView;
    MKMapRect _routeRect;
    BusLocationParser *xmlParser;;
}
@property(nonatomic,strong) MKMapView *map;
@property(nonatomic,strong) NSString *route;
@property(nonatomic,strong) NSMutableArray *stopList;
@property(nonatomic, retain) MKPolyline* routeLine;
@property(nonatomic, retain) MKPolylineView* routeLineView;
@property(nonatomic,strong) NSString *vehicle_id;
@property(nonatomic,strong) NSString *direction;

- (void) loadRoute;
- (void) zoomInOnRoute;
- (void) locateBusPosition;

@end
