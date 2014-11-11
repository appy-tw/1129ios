//
//  SUPTableViewController.m
//  ios
//
//  Created by lololol on 6/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import "SUPTableViewController.h"
#import "AppDelegate.h"
#import "VGeoManager.h"

#import "MKMapView+ZoomLevel.h"
#import "Utils.h"

#define GEORGIA_TECH_LATITUDE 33.777328
#define GEORGIA_TECH_LONGITUDE -84.397348

#define ZOOM_LEVEL 14

//Code omitted
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//Code omitted

#define __MAP_HEIGHT__      280     // dir : 縮短 mapview 高度，避免 4s 下根本看不到下面的資訊

#define CELL_OFFSET 3 //water: offset of first cell in shop array

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
    
    NSString *nssPlistDst;
    NSMutableArray *nsmaPlistArray;
}

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation SUPTableViewController

- (MKMapView*)mapView
{
    if (_mapView)
        return _mapView;
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0, 0.0, cgfScreenWidth, 280.0 * cgfScreenWidth / 320.0)];
    self.mapView.delegate = self;
    
    MKPointAnnotation *mkpaPoint;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(25.042594, 121.614642) zoomLevel:10 animated:YES];
    for(VShop* aShop in self.mShopArray){
        mkpaPoint = [[MKPointAnnotation alloc] init];
        mkpaPoint.coordinate = aShop.mGeoPoint.coordinate;
        mkpaPoint.title = aShop.mTitle;
        mkpaPoint.subtitle = aShop.mAddress;
        [_mapView addAnnotation:mkpaPoint];
        aShop.mAnnotation = mkpaPoint;
    }
    return _mapView;
}

- (void)setMyScreen
{
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = self.navigationController.navigationBar.frame.size.height + 20;// + [UIApplication sharedApplication].statusBarFrame.size.height;
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height);
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSLog(@"call out tapped");
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"anno tapped %@", view.annotation.title);
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:MKPointAnnotation.class]){
        MKAnnotationView *newAnnotation=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation1"];
        newAnnotation.image = [UIImage imageNamed:@"sup"];
        newAnnotation.canShowCallout=YES;
        return newAnnotation;
    }else // user pin
        return nil;
}

- (void)setImage {
    uiiSUP1 = [UIImage imageNamed:@"sup1"];
    uiiSUP2 = [UIImage imageNamed:@"sup2"];
    uiiSUP3 = [UIImage imageNamed:@"sup3"];
}

- (void)setMyAnotherMap {
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}
-(void)locateUserLocation{
    VGeoManager* geoManager = [VGeoManager sharedInstance];
    [self locateLocation:geoManager.cllmLocation.location];
}
-(void)locateLocation:(CLLocation*)location{
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = location.coordinate.latitude;
    region.center.longitude = location.coordinate.longitude;
    region.span.latitudeDelta = 0.0187f;
    region.span.longitudeDelta = 0.0137f;
    [self.mapView setRegion:region animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mShopArray = [NSMutableArray array];
    [[VGeoManager sharedInstance]setup];
    
    [self setMyScreen];
    [self readAllFromMyPlist];
//    [self setPinMap];
    [self setImage];

//    [self setMap];
    [self setMyAnotherMap];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidAppear:(BOOL)animated
{
    [delegate.cllMLocation stopUpdatingLocation];
    [self initMyPlist];
    [[VGeoManager sharedInstance]start];
    [super viewDidDisappear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[VGeoManager sharedInstance]stop];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [nsmaPlistArray count] + CELL_OFFSET;
}

#define __Title_Tag__       55
#define __Address_Tag__     66
#define __Distance_Tag__    77

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
        } else {
            for (UIView *subView in cell.contentView.subviews)
            {
                [subView removeFromSuperview];
            }
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
        [cell.contentView addSubview:self.mapView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.frame.size.width * 78 / 640)];
            uiimv.image = uiiSUP3;
            [cell.contentView addSubview:uiimv];
            UILabel *uilTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.18, self.tableView.frame.size.width * 0.002, self.tableView.frame.size.width * 0.45, 18.0)];
            UILabel *uilAddress = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.18, self.tableView.frame.size.width * 0.06, self.tableView.frame.size.width * 0.45, 18.0)];
            UILabel *uilDistance = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.82, self.tableView.frame.size.width * 0.027, self.tableView.frame.size.width * 0.2, 18.0)];
            uilTitle.tag = __Title_Tag__;
            uilAddress.tag = __Address_Tag__;
            uilDistance.tag = __Distance_Tag__;
            [cell.contentView addSubview:uilTitle];
            [cell.contentView addSubview:uilAddress];
            [cell.contentView addSubview:uilDistance];
            [uilTitle setBackgroundColor:[UIColor whiteColor]];
            [uilTitle setFont:[UIFont systemFontOfSize:12]];
            [uilAddress setBackgroundColor:[UIColor whiteColor]];
            [uilAddress setFont:[UIFont systemFontOfSize:12]];
            [uilDistance setBackgroundColor:[UIColor whiteColor]];
            [uilDistance setFont:[UIFont systemFontOfSize:16]];
        }
        
        UILabel *titleLabel = (UILabel*)[cell viewWithTag:__Title_Tag__];
        UILabel *addressLabel = (UILabel*)[cell viewWithTag:__Address_Tag__];
        UILabel *distanceLabel = (UILabel*)[cell viewWithTag:__Distance_Tag__];
        
        VShop* aShop = [self.mShopArray objectAtIndex:indexPath.row-CELL_OFFSET];
        
        [titleLabel setText:aShop.mTitle];
        [addressLabel setText:aShop.mAddress];
        CLLocationDistance dist = aShop.mDistance;
        [distanceLabel setText:[NSString stringWithFormat:@"%.1fKM", dist / 1000]];
        cell.tag = [self.mShopArray indexOfObject: aShop];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return cgfScreenHeightBase + self.tableView.frame.size.width * 90 / 640 + 20.0;
    } else if (indexPath.row == 1) {
        return __MAP_HEIGHT__ * cgfScreenWidth / 320.0;
//        return self.tableView.frame.size.width * 1.2;
    } else if (indexPath.row == 2) {
        return self.tableView.frame.size.width * 36 / 640;
    } else {
        return self.tableView.frame.size.width * 98 / 640;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self locateUserLocation];
    }else if(indexPath.row > 1){ // click on VShop
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        VShop* aShop = [self.mShopArray objectAtIndex:cell.tag];
        [self toggleShop:aShop];
    }
}
-(void)toggleShop:(VShop*)aShop{
    [self locateLocation:aShop.mGeoPoint];
    [_mapView selectAnnotation:aShop.mAnnotation animated:YES];
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

//[[Plist

- (void)initMyPlist
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistSrc = [[NSBundle mainBundle] pathForResource:@"sup" ofType:@"plist"];
    nssPlistDst = [NSString stringWithFormat:@"%@/Documents/sup", NSHomeDirectory()];
    if (! [nsfmPlistFileManager fileExistsAtPath:nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:nssPlistSrc toPath:nssPlistDst error:nil];
    }
}

- (void)readAllFromMyPlist {
    if (nssPlistDst == nil) {
        [self initMyPlist];
    }
    nsmaPlistArray = [NSMutableArray arrayWithContentsOfFile:nssPlistDst];
    NSLog(@"%lu", (unsigned long)[nsmaPlistArray count]);
    for(NSDictionary* obj in nsmaPlistArray){
        VShop* aShop = [[VShop alloc]init];
        aShop.mTitle = [obj valueForKey:@"title"];
        aShop.mAddress = [obj valueForKey:@"address"];
        aShop.mGeoPoint = [[CLLocation alloc]initWithLatitude:[[obj valueForKey:@"lat"]floatValue]
                                                    longitude:[[obj valueForKey:@"lon"]floatValue]];
        [self.mShopArray addObject:aShop];
    }
    self.mShopArray = [NSMutableArray arrayWithArray:[self.mShopArray sortedArrayUsingSelector:@selector(compare:)]];
}

//]]Plist

@end