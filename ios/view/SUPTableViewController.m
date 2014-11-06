//
//  SUPTableViewController.m
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "SUPTableViewController.h"
#import "AppDelegate.h"

//Code omitted
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//Code omitted

@interface SUPTableViewController ()
{
    CGFloat cgfW;
    
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    
    CGFloat cgfHigh0;
    CGFloat cgfHigh1;
    CGFloat cgfHigh2;
    CGFloat cgfHigh3;
    
    UIImage *uiiSUP1;
    UIImage *uiiSUP2;
    UIImage *uiiSUP3;
    
    AppDelegate *delegate;
}

@end

@implementation SUPTableViewController

- (void)setMyScreen
{
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
}

- (void)setImage {
    uiiSUP1 = [UIImage imageNamed:@"sup1"];
    uiiSUP2 = [UIImage imageNamed:@"sup2"];
    uiiSUP3 = [UIImage imageNamed:@"sup3"];
}

- (void)setMap {
    if (delegate.cllMLocation == nil) {
        NSLog(@"cllocationInit start");
//        [delegate.cllMLocation requestAlwaysAuthorization];
        delegate.cllMLocation = [[CLLocationManager alloc]init];
//        [delegate.cllMLocation requestAlwaysAuthorization];
        delegate.cllMLocation.delegate = self;
        delegate.cllMLocation.desiredAccuracy = kCLLocationAccuracyBest;
//        delegate.cllMLocation.distanceFilter = 3;
        // New property for iOS6
//        if ([delegate.cllMLocation respondsToSelector:@selector(activityType)]) {
//            delegate.cllMLocation.activityType = CLActivityTypeFitness;
//        }
        // New method for iOS8
//        if ([delegate.cllMLocation respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//            [delegate.cllMLocation requestAlwaysAuthorization];
//        }

        [delegate.cllMLocation startUpdatingLocation];
        NSLog(@"cllocationInit end");

        NSLog(@"latitude: %f, longitude: %f", delegate.clldLatitude, delegate.clldLongitude);
        NSLog(@"test");
    }
//    NSString *routeString = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&view=map&output=html",[myData.myLat doubleValue],[myData.myLng doubleValue],[view.annotation coordinate].latitude,[view.annotation coordinate].longitude];
}

- (void)setMyAnotherMap {
    self.cllmLocation = [[CLLocationManager alloc] init];
    self.cllmLocation.delegate = self;
    
    if(IS_OS_8_OR_LATER) {
        //[self.locationManager requestWhenInUseAuthorization];
        [self.cllmLocation requestAlwaysAuthorization];
        [self.cllmLocation startUpdatingLocation];
    }
    [self.mkmvMapView setShowsUserLocation:YES];
    [self.mkmvMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = self.cllmLocation.location.coordinate.latitude;
    region.center.longitude = self.cllmLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0.0187f;
    region.span.longitudeDelta = 0.0137f;
    [self.mkmvMapView setRegion:region animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setImage];
    [self setMyScreen];
//    [self setMap];
    [self setMyAnotherMap];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidAppear:(BOOL)animated
{
    [delegate.cllMLocation stopUpdatingLocation];
    [super viewDidDisappear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 41;
}

- (void)uibClickedTsai {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/pages/內湖南港割闌尾-正元手術房/320272928135607"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/320272928135607"]];
}

- (void)uibClickedWu {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/AppendectomyWEGO?fref=ts"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/804848699526673"]];
}

- (void)uibClickedLin {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/AppendectomyDeWhip?fref=ts"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/602996456475061"]];
}

- (void)uibClickedDragon {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/TotalRecall2014"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/620780968013532"]];
}

- (void)uibClickedHuang {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/apkh.tw"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/337299219755438"]];
}

- (void)uibClickedCountry {
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.facebook.com/apkh.tw"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"fb://profile/337299219755438"]];
}

- (void)setButton:(UITableViewCell *)cell offset:(CGFloat)cgfBaseHeight {
    UIButton *uibTsai = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibTsai.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibTsai.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.14 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibTsai addTarget:self action:@selector(uibClickedTsai) forControlEvents:UIControlEventTouchUpInside];
    uibTsai.tintColor = [UIColor blackColor];
    [uibTsai setTitle:@"蔡正元選區：正元手術房" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibTsai];
    
    UIButton *uibWu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibWu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibWu.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.21 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibWu addTarget:self action:@selector(uibClickedWu) forControlEvents:UIControlEventTouchUpInside];
    uibWu.tintColor = [UIColor blackColor];
    [uibWu setTitle:@"吳育昇選區：海口夯社" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibWu];
    
    UIButton *uibLin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibLin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibLin.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.28 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibLin addTarget:self action:@selector(uibClickedLin) forControlEvents:UIControlEventTouchUpInside];
    uibLin.tintColor = [UIColor blackColor];
    [uibLin setTitle:@"林鴻池選區：板橋手術中" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibLin];
    
    UIButton *uibDragon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibDragon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibDragon.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.46 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibDragon addTarget:self action:@selector(uibClickedDragon) forControlEvents:UIControlEventTouchUpInside];
    uibDragon.tintColor = [UIColor blackColor];
    [uibDragon setTitle:@"蔡錦龍選區" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibDragon];
    
    UIButton *uibHuang = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibHuang.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibHuang.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.90 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibHuang addTarget:self action:@selector(uibClickedHuang) forControlEvents:UIControlEventTouchUpInside];
    uibHuang.tintColor = [UIColor blackColor];
    [uibHuang setTitle:@"黃昭順選區" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibHuang];
    
    UIButton *uibCountry = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uibCountry.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    uibCountry.frame = CGRectMake(self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.97 + cgfBaseHeight, self.tableView.frame.size.width * 0.78, self.tableView.frame.size.width * 0.88 * 154.0 / 1315.0);
    [uibCountry addTarget:self action:@selector(uibClickedCountry) forControlEvents:UIControlEventTouchUpInside];
    uibCountry.tintColor = [UIColor blackColor];
    [uibCountry setTitle:@"林國正選區" forState:UIControlStateNormal];
    [cell.contentView addSubview:uibCountry];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nssIDSUP1 = @"SUP1";
    static NSString *nssIDSUP2 = @"SUP2";
    static NSString *nssIDSUP3 = @"SUP3";
    static NSString *nssIDSUP4 = @"SUP4";
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP1];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, cgfScreenHeightBase, self.tableView.frame.size.width, self.tableView.frame.size.width * 90 / 640)];
        uiimv.image = uiiSUP1;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP2];
        }
//        UIWebView *uiwvMap;
//        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP2];
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP2];
//        }
//        UIImage *uiim = [UIImage imageNamed:@"sup2"];
//        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 398 / 640)];
//        uiimv.image = uiiSUP2;
//        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP3];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 16 / 640)];
        uiimv.image = uiiSUP2;
        [cell.contentView addSubview:uiimv];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP4];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 78 / 640)];
        uiimv.image = uiiSUP3;
        [cell.contentView addSubview:uiimv];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cgfScreenHeightBase + self.tableView.frame.size.width * 90 / 640 + 20.0;
    } else if (indexPath.row == 1) {
        return self.tableView.frame.size.width * 380 / 640;
    } else if (indexPath.row == 2) {
        return self.tableView.frame.size.width * 36 / 640;
    } else {
        return self.tableView.frame.size.width * 98 / 640;
    }
}

//[[CLLocationInit
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    NSLog(@"locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations start");
//    CLLocation *c = [locations objectAtIndex:0];
//    delegate.clldLongitude = c.coordinate.longitude;
//    delegate.clldLatitude = c.coordinate.latitude;
//    NSLog(@"latitude: %f, longitude: %f, altitude: %f", delegate.clldLatitude, delegate.clldLongitude, c.altitude);
//    NSLog(@"locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations end");
//}
//
//
//- (void) startMonitoring:(LocationChangeCallback)callback {
//    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager significantLocationChangeMonitoringAvailable]) {
//        // Register an observer for if/when this app goes into background & comes back to foreground
//        // NOTE: THIS CODE IS iOS4.0+ ONLY.
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToLowEnergyMode) name:UIApplicationDidEnterBackgroundNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToAccurateMode) name:UIApplicationDidFinishLaunchingNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToAccurateMode) name:UIApplicationWillEnterForegroundNotification object:nil];
//        
//        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
//        
//        self.locationUpdateCallback = callback;
//        
//        if (state == UIApplicationStateActive) {
//            [self switchToAccurateMode];
//        } else {
//            [self switchToLowEnergyMode];
//        }
//    }
//}
//
//- (void) switchToAccurateMode {
//    NSLog(@"Accurate");
//    [self.locationManager stopMonitoringSignificantLocationChanges];
//    
//    // Find the current location
//    [self.locationManager startUpdatingLocation];
//}
//
//- (void) switchToLowEnergyMode {
//    NSLog(@"Low Energy");
//    [self.locationManager stopUpdatingLocation];
//    
//    // Find the current location
//    [self.locationManager startMonitoringSignificantLocationChanges];
//}
//
//
//#pragma mark - CLLocationDelegate Methods
//
//- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    // locations contains an array of recent locations, but this app only cares about the most recent
//    // which is also "manager.location"
//    if (self.locationUpdateCallback != nil) {
//        self.locationUpdateCallback(manager.location);
//    }
//}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *crnLoc = [locations lastObject];
//    NSLog(@"%@", [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.latitude]);
//    NSLog(@"%@", [NSString stringWithFormat:@"%.8f",crnLoc.coordinate.longitude]);
//    NSLog(@"%@", [NSString stringWithFormat:@"%.0f m",crnLoc.altitude]);
//    NSLog(@"%@", [NSString stringWithFormat:@"%.1f m/s", crnLoc.speed]);
//}
//]]CLLocationinit


@end