//
//  MapViewController.m
//
//  Created by Superbil on 2014/10/14.
//  Copyright (c) 2014年 Superbil. All rights reserved.
//

#import "MapViewController.h"

#define METERS_PER_MILE 1609.344

@interface MapAnnotation : NSObject <MKAnnotation>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation MapAnnotation

@end

@interface MapViewController () <MKMapViewDelegate>

@end

@implementation MapViewController

- (void)dealloc {
    self.mapView = nil;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapView.showsUserLocation = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self updateMapViewRangeWithCenter:self.location];
    [self updateAttracionToMapViewWithLocation:self.location];
}

- (IBAction)doneAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifierPin = @"EGAttractionPin";

    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifierPin];
    if (!pinAnnotationView) {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierPin];
        pinAnnotationView.pinColor = MKPinAnnotationColorPurple;
        pinAnnotationView.animatesDrop = YES;
        pinAnnotationView.canShowCallout = YES;
    } else {
        pinAnnotationView.annotation = annotation;
    }

    pinAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return pinAnnotationView;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
}

- (void)updateMapViewRangeWithCenter:(CLLocationCoordinate2D)centerLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerLocation, 2 * METERS_PER_MILE, 2 * METERS_PER_MILE);
    [self.mapView setRegion:region];
}

- (void)updateAttracionToMapViewWithLocation:(CLLocationCoordinate2D)location {
    // Check location is valid
    if (CLLocationCoordinate2DIsValid(location) == NO) return;

    [self.mapView addAnnotation:({
        MapAnnotation *mapAnnotation = [[MapAnnotation alloc] init];
        mapAnnotation.coordinate = location;

        [self updateMapViewRangeWithCenter:location];

        mapAnnotation;
    })];
}

//- (void)openLocationOutSide {
//    UIActionSheet *actionSheet = [UIActionSheet bk_actionSheetWithTitle:@"Chose open location way"];
//
//    [actionSheet bk_addButtonWithTitle:@"Open in Google Maps" handler:^{
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps-x-callback://"]]) {
//
//            EGAttraction *attribute = self.attraction;
//
//            CGFloat latitude = attribute.latitude;
//            CGFloat longitude = attribute.longitude;
//
//            // We must work on right locaiton
//            if (attribute.locationIsValid == NO) {
//                NSLog(@"Cancel on open Google Map");
//                return;
//            }
//
//            NSMutableString *mapString = [NSMutableString stringWithString:@"comgooglemaps-x-callback://?"];
//
//            [mapString appendFormat:@"q=%f,%f&", latitude, longitude];
//            [mapString appendFormat:@"center=%f,%f&", latitude, longitude];
//            [mapString appendString:@"zoom=15&"];
//
//            NSString *appLocalizedString = NSLocalizedString(@"1129 割藍尾", @"show on google maple callback");
//            [mapString appendFormat:@"x-success=com.eatgo.feelinglucky://?resume=true&x-source=%@", appLocalizedString];
//
//            NSLog(@"map:%@", mapString);
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[mapString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//        } else {
//            NSLog(@"Can't use comgooglemaps://");
//        }
//    }];
//
//    [actionSheet bk_setCancelButtonWithTitle:nil handler:nil];
//    
//    [actionSheet showInView:self.view];
//}

@end
