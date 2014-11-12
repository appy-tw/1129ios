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
#import "VParseManager.h"

@interface SUPTableViewController : UITableViewController <MKMapViewDelegate,GeoManagerDelegate,VParseManagerDelegate>

@property (nonatomic, strong) NSMutableArray* mShopArray;
@property (nonatomic, strong) NSMutableDictionary* mAnnotationDictionary;

@end
