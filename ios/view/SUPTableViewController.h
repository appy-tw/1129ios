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

#import "VGeoManager.h"
#import "VShop.h"

@interface SUPTableViewController : UITableViewController <MKMapViewDelegate,GeoManagerDelegate>

@property (nonatomic, strong) NSMutableArray* mShopArray;
@property (nonatomic, strong) NSMutableDictionary* mAnnotationDictionary;

@end
