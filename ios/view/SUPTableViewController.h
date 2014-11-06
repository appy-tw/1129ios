//
//  SUPTableViewController.h
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface SUPTableViewController : UITableViewController <CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mkmvMapView;
@property (strong, nonatomic) CLLocationManager *cllmLocation;

@end
