//
//  MapViewController.m
//
//  Created by Superbil on 2014/10/14.
//  Copyright (c) 2014年 Superbil. All rights reserved.
//

#import "MapViewController.h"

@interface MapAnnotation : NSObject <MKAnnotation>
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end

@implementation MapAnnotation

@end

@interface MapViewController () <MKMapViewDelegate, UIActionSheetDelegate>

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

    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];

    UIBarButtonItem *shareItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                  target:self
                                                  action:@selector(openLocationOutSide)];

    self.navigationItem.rightBarButtonItem = shareItem;
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
    static NSString *identifierPin = @"AttractionPin";

    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifierPin];
    if (!pinAnnotationView) {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifierPin];
        pinAnnotationView.image = [UIImage imageNamed:@"pin"];
        pinAnnotationView.canShowCallout = YES;
    } else {
        pinAnnotationView.annotation = annotation;
    }
    return pinAnnotationView;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:(MKPolyline *)overlay];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 5;
    return routeLineRenderer;
}

- (void)updateMapViewRangeWithCenter:(CLLocationCoordinate2D)centerLocation {
    CGFloat meter = 0.5;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(centerLocation, meter, meter);
    [self.mapView setRegion:region];
}

- (void)updateAttracionToMapViewWithLocation:(CLLocationCoordinate2D)location {
    // Check location is valid
    if (CLLocationCoordinate2DIsValid(location) == NO) return;

    [self.mapView addAnnotation:({
        MKPointAnnotation *mapAnnotation = [[MKPointAnnotation alloc] init];
        mapAnnotation.coordinate = location;
        if (self.title) {
            mapAnnotation.title = self.title;
        }
        if (self.address) {
            mapAnnotation.subtitle = self.address;
        }

        [self updateMapViewRangeWithCenter:location];

        mapAnnotation;
    })];
}

- (void)openLocationOutSide {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"選擇要開啟的方式"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"使用 Google Maps 打開", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps-x-callback://"]]) {

        // We must work on right locaiton
        if (CLLocationCoordinate2DIsValid(self.location) == NO) {
            NSLog(@"Cancel on open Google Map");
            return;
        }

        NSMutableString *mapString = [NSMutableString stringWithString:@"comgooglemaps-x-callback://?"];

        [mapString appendFormat:@"q=%f,%f&", self.location.latitude, self.location.longitude];
        [mapString appendFormat:@"center=%f,%f&", self.location.latitude, self.location.longitude];
        [mapString appendString:@"zoom=15&"];

        NSString *appLocalizedString = NSLocalizedString(@"1129 割藍尾", @"show on google maple callback");
        [mapString appendFormat:@"x-success=com.eatgo.feelinglucky://?resume=true&x-source=%@", appLocalizedString];

        NSLog(@"map:%@", mapString);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[mapString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    } else {
        NSLog(@"Can't use comgooglemaps://");
    }
}

@end
