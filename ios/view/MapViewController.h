//
//  MapViewController.h
//
//  Created by Superbil on 2014/10/14.
//  Copyright (c) 2014年 Superbil. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, assign) CLLocationCoordinate2D location;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *address;

@end
