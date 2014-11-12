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
#define CELL_CONTENT_Y_OFFSET 5

@interface SUPTableViewController ()
{
    CGFloat cgfW;
    
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    CGFloat cgfKeyboardOffset;
    
    CGFloat cgfHigh0;
    CGFloat cgfHigh1;
    CGFloat cgfHigh2;
    CGFloat cgfHigh3;
    
    UIImage *uiiSUP1;
    UIImage *uiiSUP2;
    UIImage *uiiSUP3;
    
    AppDelegate *delegate;

}

@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, readonly) int mCellHeight;
@property (nonatomic, readonly) int mMapHeight;
@property (nonatomic, readonly) int mSeparatorHeight;
@property (nonatomic, readonly) int mHeaderHeight;
@property (nonatomic, readonly) int mCellContentHeight;

@end

@implementation SUPTableViewController
-(int)mHeaderHeight{
    return 45;//cgfScreenHeightBase + self.tableView.frame.size.width * 90 / 640 + 20.0;
}
-(int)mMapHeight{
    return __MAP_HEIGHT__;
}
-(int)mSeparatorHeight{
    return 18;//self.tableView.frame.size.width * 36 / 640;
}
-(int)mCellHeight{
    return 50;//self.tableView.frame.size.width * 98 / 640;
}
-(int)mCellContentHeight{
    return 39;
}
- (MKMapView*)mapView
{
    if (_mapView)
        return _mapView;
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0, 0.0, cgfScreenWidth, self.mMapHeight)];
    self.mapView.delegate = self;
    
    MKPointAnnotation *mkpaPoint;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(25.042594, 121.614642) zoomLevel:10 animated:YES];
    for(VShop* aShop in self.mShopArray){
        mkpaPoint = [[MKPointAnnotation alloc] init];
        mkpaPoint.coordinate = aShop.mGeoPoint.coordinate;
        mkpaPoint.title = aShop.mTitle;
        mkpaPoint.subtitle = aShop.mAddress;
        [_mapView addAnnotation:mkpaPoint];
        [self.mAnnotationDictionary setObject:mkpaPoint forKey:aShop.key];
    }
    return _mapView;
}

- (void)setMyScreenSize
{
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([UIApplication sharedApplication].statusBarFrame.size.height == 20.0) {
        //without Hotspot: 64
        cgfKeyboardOffset =  cgfScreenHeightBase;
    } else {
        //with Hotspot: 104
        cgfKeyboardOffset = cgfScreenHeightBase + [UIApplication sharedApplication].statusBarFrame.size.height / 2.0;
    }
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f, keyboardOffset: %f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height, cgfKeyboardOffset);
}

- (void) makeKeyboardOffset {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - cgfKeyboardOffset);
    [UIView commitAnimations];
}

- (void) makeKeyboardOffsetBack {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y);
    [UIView commitAnimations];
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
    self.mAnnotationDictionary = [NSMutableDictionary dictionary];
    
    [self setMyScreenSize];
    [self makeKeyboardOffset];
    [self readAllFromMyPlist];
    [self setImage];

    [self setMyAnotherMap];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidAppear:(BOOL)animated
{
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [delegate.cllMLocation stopUpdatingLocation];
    [[VGeoManager sharedInstance]setup];
    [VGeoManager sharedInstance].delegate = self;
    [super viewDidDisappear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[VGeoManager sharedInstance]stop];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.mShopArray count] + CELL_OFFSET;
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
    
    if (indexPath.row == 0) { // head: "補給據點"
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP1];
        } else {
            for (UIView *subView in cell.contentView.subviews)
            {
                [subView removeFromSuperview];
            }
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.mHeaderHeight)];
        uiimv.image = uiiSUP1;
        [cell.contentView addSubview:uiimv];
    } else if (indexPath.row == 1) { // map view
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
    } else if (indexPath.row == 2) { //separator
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP3];
        }
        UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 4.0, self.tableView.frame.size.width,8)];
        uiimv.image = uiiSUP2;
        [cell.contentView addSubview:uiimv];
    } else { // VShop cells
        cell = [tableView dequeueReusableCellWithIdentifier:nssIDSUP4];
        if(cell!=nil){
            for (UIView *subView in cell.contentView.subviews)
            {
                [subView removeFromSuperview];
            }
        }
        //create cell subview
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssIDSUP4];
            UIImageView *uiimv = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, CELL_CONTENT_Y_OFFSET, self.tableView.frame.size.width, self.mCellContentHeight)];
            uiimv.image = uiiSUP3;
            [cell.contentView addSubview:uiimv];
            UILabel *uilTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.18, self.tableView.frame.size.width * 0.002+CELL_CONTENT_Y_OFFSET, self.tableView.frame.size.width * 0.45, 18.0)];
            UILabel *uilAddress = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.18, self.tableView.frame.size.width * 0.06+CELL_CONTENT_Y_OFFSET, self.tableView.frame.size.width * 0.45, 18.0)];
            UILabel *uilDistance = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.82, self.tableView.frame.size.width * 0.027+CELL_CONTENT_Y_OFFSET, self.tableView.frame.size.width * 0.2, 18.0)];
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
    if(indexPath.row < CELL_OFFSET){
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return self.mHeaderHeight+20;
    } else if (indexPath.row == 1) {
        return self.mMapHeight;
//        return __MAP_HEIGHT__ * cgfScreenWidth / 320.0;
//        return self.tableView.frame.size.width * 1.2;
    } else if (indexPath.row == 2) {
        return self.mSeparatorHeight;
    } else {
        return self.mCellHeight;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self locateUserLocation];
    }else if(indexPath.row > 2){ // click on VShop
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        VShop* aShop = [self.mShopArray objectAtIndex:cell.tag];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        [self performSelector:@selector(toggleShop:) withObject:aShop afterDelay:0];
    }
}
-(MKPointAnnotation*)getUserLocationPin{
    MKPointAnnotation* result = nil;
    for(MKPointAnnotation* anno in self.mapView.annotations){
        if ([anno isKindOfClass:[MKUserLocation class]]){
            result = anno;
            break;
        }
    }
    return result;
}
-(void)toggleShop:(VShop*)aShop{
    
    MKPointAnnotation* me = [self getUserLocationPin];
    MKPointAnnotation* annotation = [self.mAnnotationDictionary objectForKey:aShop.key];
    if(me != nil){
        NSArray* pins = [NSArray arrayWithObjects:annotation,me, nil];
        [self.mapView showAnnotations:pins animated:YES];
    }else{
        [self locateLocation:aShop.mGeoPoint];
    }
    [_mapView selectAnnotation:annotation animated:YES];
}

- (void)readAllFromMyPlist {
    self.mShopArray = [VShop loadVShop];
    [self sortShops];
}
-(void)sortShops{
    self.mShopArray = [NSMutableArray arrayWithArray:[self.mShopArray sortedArrayUsingSelector:@selector(compare:)]];
    [self.tableView reloadData];
}

-(void)didRequireGeoPermission:(BOOL)bSucceed{
    [self sortShops];
}
//]]Plist

@end