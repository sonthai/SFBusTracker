//
//  DisplayRoute.m
//  SFBusTracker
//
//  Created by Son Thai on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DisplayRoute.h"
#import "MyAnnotation.h"


@implementation DisplayRoute
@synthesize map;
@synthesize start = _start;
@synthesize end = _end;
@synthesize travelMode = _travelMode;
@synthesize routeLine;
@synthesize routeLineView;



- (void) viewDidLoad
{
    [super viewDidLoad];
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map.mapType = MKMapTypeStandard;
    self.map.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
   
    [self.view addSubview:self.map];
    self.map.delegate = self;
    
    NSString *st = [self.start stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSString *d = [self.end stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *s = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/xml?origin=%@&destination=%@&mode=%@&sensor=false&waypoints=optimize:true",st,d,[self.travelMode lowercaseString]];
    
    xmlParser = [[GoogleXMLParser alloc] loadXMLByURL:s];

   
    newArray = [[NSMutableArray alloc] init];

    newArray =  [self decodePolylineOfGoogleMaps:[xmlParser polylines]];

    [self addPinPoints];
    [self loadRoute];
    
    if (self.routeLine != nil)
    {
        [self.map addOverlay:self.routeLine];
    }
    
    [self zoomInOnRoute];
    
    if(self.travelMode == nil)
        self.travelMode = @"Driving";
    self.title = [self.travelMode stringByAppendingString:@" Direction"];
    
    if ([xmlParser warning] != nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" 
                                                        message:[xmlParser warning]
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
     
}

-(void) addPinPoints
{

    if ([[xmlParser pointArr] count] > 0)
    {
        VehicleLocation *startLoc = [[xmlParser pointArr] objectAtIndex:0];
        CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake([startLoc.lat doubleValue],[startLoc.lon doubleValue]);
        MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:loc1 title:@"You are here" subTitle:self.start];
    
    
        annotation.pinColor = MKPinAnnotationColorPurple;
        [self.map addAnnotation:annotation];
    
  
        VehicleLocation *endLoc = [[xmlParser pointArr] objectAtIndex:[[xmlParser pointArr] count] - 1];
        CLLocationCoordinate2D loc2 = CLLocationCoordinate2DMake([endLoc.lat doubleValue],[endLoc.lon doubleValue]);
        annotation = [[MyAnnotation alloc] initWithCoordinates:loc2 title:@"Destination" subTitle:self.end];
    
        annotation.pinColor = MKPinAnnotationColorGreen;
        [self.map addAnnotation:annotation];
    }
}

- (void) zoomInOnRoute
{
    [self.map setVisibleMapRect:routeRect];
}

- (void) loadRoute
{
    MKMapPoint northEastPoint;
    MKMapPoint southwestPoint;
    
    int size = [newArray count]; 
    MKMapPoint *pointArr = malloc(sizeof(CLLocationCoordinate2D)*size);
    int j=0;
    for (int idx = 0; idx < size ; idx = idx +2, j++)
    {
        CLLocationDegrees latitude = [[newArray objectAtIndex:idx] doubleValue];
        CLLocationDegrees longitude = [[newArray objectAtIndex:idx+1] doubleValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude,longitude); 
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        if (j == 0)
        {
            northEastPoint = point;
            southwestPoint = point;
        }
        else
        {
            if (point.x > northEastPoint.x)
                northEastPoint.x = point.x;
            if (point.y > northEastPoint.y)
                northEastPoint.y = point.y;
            if (point.x < southwestPoint.x)
                southwestPoint.x = point.x;
            if (point.y < southwestPoint.y)
                southwestPoint.y = point.y;
        }
        pointArr[j] = point;
        
    }
    
    self.routeLine = [MKPolyline polylineWithPoints:pointArr count:size/2];
    routeRect = MKMapRectMake(southwestPoint.x,southwestPoint.y, northEastPoint.x - southwestPoint.x, northEastPoint.y - southwestPoint.y);
    
    free(pointArr);
    
}

- (MKOverlayView*) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    MKOverlayView* overlayView = nil;
    if (overlay == self.routeLine)
    {
        if (nil == self.routeLineView)
        {
            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 3;
        }
        
        overlayView = self.routeLineView;
    }
    
    return overlayView;
}

- (MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *result = nil;
    
    if ([annotation isKindOfClass:[MyAnnotation class]] == NO)
    {
        return result;
    }
    
    if ([mapView isEqual:self.map] == NO)
    {
        return result;
    }
    
    MyAnnotation* senderAnnotation = (MyAnnotation*) annotation;
    
    NSString *pinResuabledentifier = [MyAnnotation reusableIdetifierforPinColor:senderAnnotation.pinColor];
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*) [map dequeueReusableAnnotationViewWithIdentifier:pinResuabledentifier];
    
    if (annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinResuabledentifier];
        
        [annotationView setCanShowCallout:YES];
    }
    
    annotationView.pinColor = senderAnnotation.pinColor;
    result = annotationView;
    return result;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/**
 * Decode polyline of google maps.
 *
 * @param encodedPolyline: Polyline encoded of google maps.
 * @return An array that contain all coordinates.
 */
- (NSArray *)decodePolylineOfGoogleMaps:(NSString *)encodedPolyline {
    
    NSUInteger length = [encodedPolyline length];
    NSInteger index = 0;
    NSMutableArray *points = [NSMutableArray array];
    CGFloat lat = 0.0f;
    CGFloat lng = 0.0f;
    
    while (index < length) {
        
        // Temorary variable to hold each ASCII byte.
        int b = 0;
        
        // The encoded polyline consists of a latitude value followed by a
        // longitude value. They should always come in pair. Read the
        // latitude value first.
        int shift = 0;
        int result = 0;
        
        do {
            
            // If index exceded lenght of encoding, finish 'chunk'
            if (index >= length) {
                
                b = 0;
                
            } else {
                
                // The '[encodedPolyline characterAtIndex:index++]' statement resturns the ASCII
                // code for the characted at index. Subtract 63 to get the original
                // value. (63 was added to ensure proper ASCII characters are displayed
                // in the encoded plyline string, wich id 'human' readable)
                b = [encodedPolyline characterAtIndex:index++] - 63;
                
            }
            
            // AND the bits of the byte with 0x1f to get the original 5-bit 'chunk'.
            // Then left shift the bits by the required amount, wich increases
            // by 5 bits each time.
            // OR the value into results, wich sums up the individual 5-bit chunks
            // into the original value. Since the 5-bit chunks were reserved in 
            // order during encoding, reading them in this way ensures proper
            // summation.
            result |= (b & 0x1f) << shift;
            shift += 5;
            
        } while (b >= 0x20); // Continue while the read byte is >= 0x20 since the last 'chunk'
        // was nor OR'd with 0x20 during the conversion process. (Signals the end).
        
        // check if negative, and convert. (All negative values have the last bit set)
        CGFloat dlat = (result & 1) ? ~(result >> 1) : (result >> 1);
        
        //Compute actual latitude since value is offset from previous value.
        lat += dlat;
        
        // The next value will correspond to the longitude for this point.
        shift = 0;
        result = 0;
        
        do {
            
            // If index exceded lenght of encoding, finish 'chunk'
            if (index >= length) {
                
                b = 0;
                
            } else {
                
                b = [encodedPolyline characterAtIndex:index++] - 63;
                
            }
            result |= (b & 0x1f) << shift;
            shift += 5;
            
        } while (b >= 0x20);
        
        CGFloat dlng = (result & 1) ? ~(result >> 1) : (result >> 1);
        lng += dlng;
        
        // The actual latitude and longitude values were multiplied by 
        // 1e5 before encoding so that they could be converted to a 32-bit
        //integer representation. (With a decimal accuracy of 5 places)
        // Convert back to original value.
        [points addObject:[NSString stringWithFormat:@"%f", (lat * 1e-5)]];
        [points addObject:[NSString stringWithFormat:@"%f", (lng * 1e-5)]];
        
    }
    
    return points;
    
}
@end
