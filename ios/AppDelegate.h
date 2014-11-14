//
//  AppDelegate.h
//  1129vday
//
//  Created by lololol on 26/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//@property (strong, nonatomic) NSString *nssUserName;
@property (strong, nonatomic) NSString *nssDeviceToken;
//@property (strong, nonatomic) NSString *nssGesturePassword;
//@property (strong, nonatomic) NSString *nssPassword;
//@property (strong, nonatomic) NSString *nssPhone;
@property (strong, nonatomic) NSString *nssRSSContent;
@property (strong, nonatomic) NSString *nssRSSURL;
@property (strong, nonatomic) NSString *nssPlistDst;
//@property (strong, nonatomic) NSString *nssTsaiWuLin;
//@property (strong, nonatomic) NSString *nssAddress;

//@property (strong, nonatomic) CLLocationManager *cllMLocation;
@property (assign, nonatomic) CLLocationDegrees clldLatitude;
@property (assign, nonatomic) CLLocationDegrees clldLongitude;

@property (strong, nonatomic) UINavigationController *navigationControllerMS;
@property (strong, nonatomic) UINavigationController *navigationControllerBlog;
@property (strong, nonatomic) UINavigationController *navigationControllerSUP;
@property (strong, nonatomic) UINavigationController *navigationControllerKG;
@property (strong, nonatomic) UINavigationController *navigationControllerATT;
//@property (strong, nonatomic) UINavigationController *navigationController;

//- (void)cllocationInit;
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;

//[[forBLOG
@property (strong, nonatomic) NSString *nssBLOGLink;
//]]forBLOG

//[[forKG
@property (strong, nonatomic) NSString *nssKGLink;
//]]forKG

//[[forSUP
@property (assign, nonatomic) BOOL bShouldAlartSUPOFGPS;
//]]forSUP

//[[forATT
//]]forATT

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

