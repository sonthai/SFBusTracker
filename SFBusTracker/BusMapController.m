//
//  BusMapController.m
//  SFBusTracker
//
//  Created by Son Thai on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BusMapController.h"
#import "Stop.h"
#import "VehicleLocation.h"
#import "MyAnnotation.h"

@implementation BusMapController
@synthesize map = _map;
@synthesize route = route;
@synthesize stopList = _stopList;
@synthesize routeLine = _routeLine;
@synthesize routeLineView = _routeLineView;
@synthesize vehicle_id = _vehicle_id;
@synthesize direction;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    self.map.mapType = MKMapTypeStandard;
    
    self.map.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.map];
    
    self.map.delegate = self;
    self.title = @"Bus Map";
    [self loadRoute];
    
    if (self.routeLine != nil)
    {
        [self.map addOverlay:self.routeLine];
    }

    [self locateBusPosition];
    
    
}

-(void) locateBusPosition
{
    NSString *s = [NSString stringWithFormat:@"http://webservices.nextbus.com/service/publicXMLFeed?command=vehicleLocations&a=sf-muni&r=%@&t=%0",self.route];
    
    xmlParser = [[BusLocationParser alloc] loadXMLByURL:s];
    VehicleLocation *vehicle = [[VehicleLocation alloc] init];
    vehicle = [[xmlParser busLocation] objectForKey:self.vehicle_id];
    CLLocationDegrees longitude = [vehicle.lon doubleValue];
    CLLocationDegrees latitude = [vehicle.lat doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,longitude);
    MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:coordinate title:self.route subTitle:[NSString stringWithFormat:@"%@",self.direction]];
    annotation.pinColor = MKPinAnnotationColorGreen;
    [self.map removeAnnotation:annotation];
    [self.map addAnnotation:annotation];
    [self zoomInOnRoute];
    

}

- (void) loadRoute
{
    MKMapPoint northEastPoint;
    MKMapPoint southestPoint;
    
    int size = self.stopList.count;
    MKMapPoint *pointArr = malloc(sizeof(CLLocationCoordinate2D)*size);
    Stop *stop = [[Stop alloc] init];
   
    for (int idx = 0; idx < size; idx++)
    {
        stop = [self.stopList objectAtIndex:idx];
        CLLocationDegrees latitude = [stop.lat  doubleValue];
        CLLocationDegrees longitude = [stop.lon doubleValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,longitude); 
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        if (idx == 0)
        {
            northEastPoint = point;
            southestPoint  = point;
        }
        else
        {
            if (point.x > northEastPoint.x)
                northEastPoint.x = point.x;
            if (point.y > northEastPoint.y)
                northEastPoint.y = point.y;
            if (point.x < southestPoint.x)
                southestPoint.x = point.x;
            if (point.y < southestPoint.y)
                southestPoint.y = point.y;
        }
        pointArr[idx] = point;
    }
    
    self.routeLine = [MKPolyline polylineWithPoints:pointArr count:size];
    _routeRect = MKMapRectMake(southestPoint.x,southestPoint.y, northEastPoint.x - southestPoint.x, northEastPoint.y -southestPoint.y);
    free(pointArr);
    
}

-(void) zoomInOnRoute
{
	[self.map setVisibleMapRect:_routeRect];
}

#pragma mark MKMapViewDelegate
- (MKOverlayView*) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKOverlayView *overlayView = nil;
    
    if (overlay == self.routeLine)
    {
        if (self.routeLineView == nil)
        {
            self.routeLineView = [[MKPolylineView alloc] initWithOverlay:self.routeLine];
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 3;
        }
        
        overlayView = self.routeLineView;
    }
    
    return overlayView;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
