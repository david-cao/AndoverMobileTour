//
//  PAMapDelegate.m
//  MobileTourModel
//
//  Created by Shaun Hubbard(central admin) on 8/24/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAMapDelegate.h"
#import "PATourPoint.h"
#import "PATourViewController.h"
#import "PADetailButton.h"
#import "PAFetchHelper.h"
#import "PATourContext.h"

#define DELTA_LAT_SPAN_MAX 0.01

#define topLeftLongitude 42.65206
#define topLeftLatitude -71.142129
#define bottomRightLongitude 42.63862
#define bottomRightLatitude -71.122699

#define CENTER_LONGITUDE 42.646377
#define CENTER_LATITUDE -71.130993
#define DELTA_LONG_SPAN 0.008391
#define DELTA_LAT_SPAN 0.006661

@interface PAMapDelegate ()

- (void)addPathOverlay;

- (void)addRouteStepsForOverlayPathFrom:(MKDirectionsResponse *)aResponse;

- (void)returnedHome;

@property (strong, nonatomic) NSMutableArray *routePolyLines;
@property BOOL needsToSetRegion;
@property CLLocationCoordinate2D topLeft;
@property CLLocationCoordinate2D bottomRight;

@end

@implementation PAMapDelegate
@synthesize mapView, manager, routePolyLines;

- (id)initForMap:(MKMapView *)map andController:(UIViewController *)controller{
    if ((self = [super init])) {
        
        [self setMapView:map];
        [[self mapView] setMapType:MKMapTypeHybrid];
        [self setController:controller];
        
        [map setDelegate:self];
        [map setShowsUserLocation:YES];
        
        [self setManager:[[CLLocationManager alloc] init]];
        [[self manager] setDelegate:self];
        [[self manager] startUpdatingHeading];
        [[self manager] startUpdatingLocation];
    
        [self setRoutePolyLines:[NSMutableArray array]];
        
        [self setNeedsToSetRegion:YES];
        
        [self setTopLeft:CLLocationCoordinate2DMake(topLeftLatitude, topLeftLongitude)];
        [self setBottomRight:CLLocationCoordinate2DMake(bottomRightLatitude, bottomRightLongitude)];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(returnedHome)
                                                     name:returnHomeNotificationName
                                                   object:nil];
        
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    if ([self needsToSetRegion]) {
        MKCoordinateRegion regionView = MKCoordinateRegionMake(CLLocationCoordinate2DMake(CENTER_LONGITUDE, CENTER_LATITUDE), MKCoordinateSpanMake(DELTA_LONG_SPAN, DELTA_LAT_SPAN));
        [[self mapView] setRegion:regionView animated:YES];
        [self setNeedsToSetRegion:NO];
        
        
        CLLocation *currentLocation = [locations lastObject];
        
        CLLocation *campusLocation = [[CLLocation alloc] initWithLatitude:CENTER_LATITUDE longitude:CENTER_LONGITUDE];
        
        NSLog(@"Distance from campus: %f", [currentLocation distanceFromLocation:campusLocation]);
        
        if ([currentLocation distanceFromLocation:campusLocation] > 16000) { //about 10 miles
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        CLLocationCoordinate2D destinationCoordinate = CLLocationCoordinate2DMake(42.649119, -71.131885);
        
        //create MKMapItem out of coordinates
        MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:destinationCoordinate addressDictionary:nil];
        MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
        if([destination respondsToSelector:@selector(openInMapsWithLaunchOptions:)])
        {
            //using iOS6 native maps app
            [MKMapItem openMapsWithItems:@[destination] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving}];
            
        }
    }
}

- (void)zoomToCampus {
    
    MKCoordinateSpan span = MKCoordinateSpanMake(DELTA_LAT_SPAN_MAX, DELTA_LAT_SPAN_MAX);
    CLLocationCoordinate2D coordinate = {CENTER_LONGITUDE, CENTER_LATITUDE};
    MKCoordinateRegion region = {coordinate, span};
    MKCoordinateRegion regionThatFits = [self.mapView regionThatFits:region];
    [self.mapView setRegion:regionThatFits animated:YES];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    NSLog(@"Deltas: %f, %f", [[self mapView] region].span.latitudeDelta, [[self mapView] region].span.longitudeDelta);
    NSLog(@"Center point: %f, %f", [[self mapView] region].center.longitude, [[self mapView] region].center.latitude);
    
    if (![self needsToSetRegion]) {
        //check zoom
        if ([[self mapView] region].span.latitudeDelta > DELTA_LAT_SPAN_MAX || [[self mapView] region].span.longitudeDelta > DELTA_LAT_SPAN_MAX) {
            CLLocationCoordinate2D center = [[self mapView] centerCoordinate];
            MKCoordinateSpan span = MKCoordinateSpanMake(DELTA_LAT_SPAN_MAX, DELTA_LAT_SPAN_MAX);
            [[self mapView] setRegion:MKCoordinateRegionMake(center, span) animated:YES];
            return;
        }
        
        //check bounds from stackoverflow
        //not really working...
        MKCoordinateRegion currentRegion = [[self mapView] region];
        bool changeRegionLong = YES;
        bool changeRegionLat = YES;
        
        // LONGITUDE
        if((currentRegion.center.longitude - (currentRegion.span.longitudeDelta/2)) < [self topLeft].longitude) {
            
            currentRegion.center.longitude = ([self topLeft].longitude + (currentRegion.span.longitudeDelta/2));
            
        } else if((currentRegion.center.longitude + (currentRegion.span.longitudeDelta/2)) > [self bottomRight].longitude) {
            
            currentRegion.center.longitude = ([self bottomRight].longitude - (currentRegion.span.longitudeDelta/2));
            
        } else {
            
            changeRegionLong = NO;
            
        }
        
        // LATITUDE
        if((currentRegion.center.latitude + (currentRegion.span.latitudeDelta/2)) > [self topLeft].latitude) {
            
            currentRegion.center.latitude = ([self topLeft].latitude - (currentRegion.span.latitudeDelta/2));
            
        } else if((currentRegion.center.latitude - (currentRegion.span.latitudeDelta/2)) < [self bottomRight].latitude) {
            
            currentRegion.center.latitude = ([self bottomRight].latitude + (currentRegion.span.latitudeDelta/2));
            
        } else {
            
            changeRegionLat = NO;
            
        }
        
        if(changeRegionLong || changeRegionLat) {
            //[[self mapView] setRegion:currentRegion animated:YES];
            NSLog(@"out of bounds");
        }
    }
}

- (void)setPoints:(NSArray *)points{
    _points = points;
    
    
    //[self addPathOverlay];
}



-(void)overviewOfRoute{
    
    [[self mapView] removeOverlays:[[self mapView] overlays]];

    
    //[self addPathOverlay];
}

- (void)addPathOverlay{
   
    
    for (NSInteger i = 0; i < [_points count]; i++) {
        PATourPoint *fromPoint = [_points objectAtIndex:i];
        PATourPoint *toPoint = nil;
        
        if (i+1 < [_points count]) {
            toPoint = [_points objectAtIndex:i + 1] ;
        } else {
            toPoint = [_points firstObject];
        }
        
        
        MKMapItem *fromItem = [self directionalMapItem:[fromPoint cooridinate]
                                                  name:[fromPoint locationName]];
        MKMapItem *toItem = [self directionalMapItem:[toPoint cooridinate]
                                                name:[toPoint locationName]];
        
        
        MKDirectionsRequest *req = [[MKDirectionsRequest alloc] init];
        [req setSource:fromItem];
        [req setDestination:toItem];
        [req setTransportType:MKDirectionsTransportTypeWalking];
        
        MKDirections *dirs = [[MKDirections alloc] initWithRequest:req];
        
        [dirs calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            if (error) {
                NSLog(@"method %s error %@", __PRETTY_FUNCTION__, error);
                return;
            }
            
            [self addRouteStepsForOverlayPathFrom:response];
        }];
    }
}


- (void)addRouteStepsForOverlayPathFrom:(MKDirectionsResponse *)aResponse{
    
    
    MKRoute *route = [[aResponse routes] firstObject];
    
    [[self mapView] addOverlay:[route polyline]
                         level:MKOverlayLevelAboveRoads];

    [[self routePolyLines] addObject:[route polyline]];

    NSLog(@"PolyLine %@", [route polyline]);
}



- (void)directionToPoint:(NSInteger)pointIndex{
    MKMapItem *current  = [MKMapItem mapItemForCurrentLocation];
    
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:[[_points objectAtIndex:pointIndex] cooridinate]
                                                                                        addressDictionary:nil]];
    
    MKDirectionsRequest *dirReq = [[MKDirectionsRequest alloc] init];
    [dirReq setSource:current];
    [dirReq setDestination:destination];
    [dirReq setTransportType:MKDirectionsTransportTypeWalking];
    
    
    
    
    
    [[self mapView] removeOverlays:[[self mapView] overlays]];
    
    
    
    MKDirections* dirs = [[MKDirections alloc] initWithRequest:dirReq];
    
    
    
    [dirs calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"method %s error %@", __PRETTY_FUNCTION__, error);
            return;
        }
        
        [self addRouteStepsForOverlayPathFrom:response];
    }];
    

}

- (MKMapItem *)directionalMapItem:(CLLocationCoordinate2D )coord name:(NSString *)name{
    MKPlacemark *placeMark = [[MKPlacemark alloc] initWithCoordinate:coord
                                                   addressDictionary:nil];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placeMark];
    [mapItem setName:name];
    
    return mapItem;
    
}



- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *plr = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    
    
    
    [plr setStrokeColor:[UIColor blackColor]];
    [plr setLineWidth:(CGFloat)3.0];
    
    
    if ([routePolyLines containsObject:overlay]) {
        [plr setStrokeColor:[UIColor blueColor]];
        [plr setLineWidth:(CGFloat)2.0];
    }
    
    return plr;
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    PATourPoint *selectedPoint = [[PAFetchHelper pointsForName:[annotation title] inContext:[PATourContext sharedContext]] objectAtIndex:0];

    NSString *pinIdentifier = [selectedPoint locationName];
    
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[[self mapView] dequeueReusableAnnotationViewWithIdentifier:pinIdentifier];
    
    //to make blue, find picture and add subview
    
    if (!pinView && [self isCampusTour]) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pinIdentifier];
        [pinView setAnimatesDrop:YES];
        [pinView setCanShowCallout:YES];
        PADetailButton *rightButton = [PADetailButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        [rightButton setPoint:selectedPoint];
        [rightButton addTarget:[self controller] action:@selector(pushDetailScreen:) forControlEvents:UIControlEventTouchUpInside];
        
        [pinView setRightCalloutAccessoryView:rightButton];
    } else {
        [pinView setAnnotation:annotation];
    }
    
    return pinView;
}

- (void)returnedHome {
    NSLog(@"Map delegate returned home");
    //[self setNeedsToSetRegion:YES];
}


@end
