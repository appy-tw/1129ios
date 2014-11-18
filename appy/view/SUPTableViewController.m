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
#import "VParseManager.h"

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
    
//    AppDelegate *delegate;
    
    NSString *nssRefrashResultTitle;
    NSString *nssRefrashResultContent;
    
    BOOL bIconAssociated;
    BOOL bAnimation;
    BOOL bTitleAdded;
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
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(25.042594, 121.614642) zoomLevel:10 animated:YES];
    return _mapView;
}
-(void)setPins{
    [self.mapView removeAnnotations:self.mapView.annotations]; //clear up
    
    MKPointAnnotation *mkpaPoint;
    for(VShop* aShop in self.mShopArray){
        mkpaPoint = [[MKPointAnnotation alloc] init];
        mkpaPoint.coordinate = aShop.mGeoPoint.coordinate;
        mkpaPoint.title = aShop.mTitle;
        mkpaPoint.subtitle = aShop.mAddress;
        [_mapView addAnnotation:mkpaPoint];
        [self.mAnnotationDictionary setObject:mkpaPoint forKey:aShop.key];
    }
}
-(VShop*)getShopOfAnnotation:(MKPointAnnotation*)annotation{
    NSArray* keys = [self.mAnnotationDictionary allKeysForObject:annotation];
    if(keys != nil){
        NSString* key = [keys firstObject];
        if(key != nil){
            for(VShop* shop in self.mShopArray){
                if([key isEqualToString:shop.key]){
                    return shop;
                }
            }
        }
    }
    return nil;
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
//    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f, keyboardOffset: %f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, delegate.navigationController.navigationBar.frame.size.height, cgfKeyboardOffset);
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
        NSString* type = [self getShopOfAnnotation:annotation].mType;
        if([type isEqualToString:@"cinema"]){
            newAnnotation.image = [UIImage imageNamed:@"cinema"];
        }else if([type isEqualToString:@"cafe"]){
            newAnnotation.image = [UIImage imageNamed:@"cafe"];
        }else if([type isEqualToString:@"camp"]){
            newAnnotation.image = [UIImage imageNamed:@"camp"];
        }else{
            newAnnotation.image = [UIImage imageNamed:@"pin"];
        }
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
    [self loadShops];
    [self setImage];
    [self setMyAnotherMap];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
-(void)loadVShopFromParse{
    [[VParseManager sharedInstance]loadVShopFromServer];
    [VParseManager sharedInstance].delegate = self;
}
-(void)didFinishLoading{
    [self loadShops];
}

- (void)viewDidAppear:(BOOL)animated
{
//    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [delegate.cllMLocation stopUpdatingLocation];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[VGeoManager sharedInstance]setup];
    [VGeoManager sharedInstance].delegate = self;
    [self loadVShopFromParse];
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
            UILabel *uilDistance = [[UILabel alloc]initWithFrame:CGRectMake(self.tableView.frame.size.width * 0.795, self.tableView.frame.size.width * 0.027+CELL_CONTENT_Y_OFFSET, self.tableView.frame.size.width * 0.2, 18.0)];
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
        [distanceLabel setText:[NSString stringWithFormat:@"%.1f公里", dist / 1000]];
        [distanceLabel setTextAlignment:NSTextAlignmentCenter];
        if (dist >= 100000000){
            [distanceLabel setFont:[UIFont systemFontOfSize:7]];
        } else if (dist >= 100000){
            [distanceLabel setFont:[UIFont systemFontOfSize:11]];
        } else {
            [distanceLabel setFont:[UIFont systemFontOfSize:14]];
        }
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
        return self.mHeaderHeight + cgfScreenWidth * 25.0 / 640.0;
    } else if (indexPath.row == 1) {
        return self.mMapHeight;
    } else if (indexPath.row == 2) {
        return self.mSeparatorHeight;
    } else {
        if (indexPath.row == [self.mShopArray count] + CELL_OFFSET - 1) {
            return self.mCellHeight + cgfScreenWidth * 15.0 / 640.0;
        }
        else {
            return self.mCellHeight;
        }
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

- (void) loadShops {
    self.mShopArray = [VShop loadVShop];
    [self setPins];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect cgfRefreshBounds = self.refreshControl.bounds;
    CGFloat cgfPulledDistance = MAX(0.0, -self.refreshControl.frame.origin.y);
    
    CGFloat cgfMiddleX = self.tableView.frame.size.width / 2.0;
    
    CGFloat cgfRefreshHeight = self.uiivReloadBack.bounds.size.height;
    CGFloat cgfRefreshHeightHalf = cgfRefreshHeight * 0.8 / 3.0;
    
    CGFloat cgfRefreshWidth = self.uiivReloadBack.bounds.size.width;
    CGFloat cgfRefreshWidthHalf = cgfRefreshWidth / 2.0;
    
    CGFloat cgfFrontGraphHeight = self.uiivReloadFront.bounds.size.height;
    CGFloat cgfFrontGraphHeightHalf = cgfFrontGraphHeight * 0.8 / 3.0;
    
    CGFloat cgfFrontGraphWidth = self.uiivReloadFront.bounds.size.width;
    CGFloat cgfFrontGraphWidthHalf = cgfFrontGraphWidth / 2.0;
    
    CGFloat cgfPulledRatio = MIN( MAX(cgfPulledDistance, 0.0), 100.0) / 100.0;
    
    CGFloat BackgroundGraphY = cgfPulledDistance * 0.8 / 3.0 - cgfRefreshHeightHalf;
    CGFloat FrontGraphY = cgfPulledDistance * 0.8 / 3.0 - cgfFrontGraphHeightHalf;
    
    CGFloat BackgroundGraphX = (cgfMiddleX + cgfRefreshWidthHalf) - (cgfRefreshWidth * cgfPulledRatio);
    CGFloat FrontGraphX = (cgfMiddleX - cgfFrontGraphWidth - cgfFrontGraphWidthHalf) + (cgfFrontGraphWidth * cgfPulledRatio);
    
    if (fabsf(BackgroundGraphX - FrontGraphX) < 1.0) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉後卡開，進行更新"];
        bIconAssociated = YES;
    }
    
    if (bIconAssociated || self.refreshControl.isRefreshing) {
        BackgroundGraphX = cgfMiddleX - cgfRefreshWidthHalf;
        FrontGraphX = cgfMiddleX - cgfFrontGraphWidthHalf;
    }
    
    CGRect BackgroundGraphFrame = self.uiivReloadBack.frame;
    BackgroundGraphFrame.origin.x = BackgroundGraphX;
    BackgroundGraphFrame.origin.y = BackgroundGraphY;
    
    CGRect FrontGraphFrame = self.uiivReloadFront.frame;
    FrontGraphFrame.origin.x = FrontGraphX;
    FrontGraphFrame.origin.y = FrontGraphY;
    
    self.uiivReloadBack.frame = BackgroundGraphFrame;
    self.uiivReloadFront.frame = FrontGraphFrame;
    
    cgfRefreshBounds.size.height = cgfPulledDistance;
    
    self.uivReloadCellBackground.frame = cgfRefreshBounds;
    self.uivReloadCellGraph.frame = cgfRefreshBounds;
    
    if (self.refreshControl.isRefreshing && !bAnimation) {
        [self makeAnimation];
    }
}

- (void)setRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.uivReloadCellGraph = [[UIView alloc] initWithFrame:self.refreshControl.bounds];
    self.uivReloadCellGraph.backgroundColor = [UIColor clearColor];
    
    self.uivReloadCellBackground = [[UIView alloc] initWithFrame:self.refreshControl.bounds];
    self.uivReloadCellBackground.backgroundColor = [UIColor clearColor];
    self.uivReloadCellBackground.alpha = 0.15;
    
    self.uiivReloadBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reload-back"]];
    [self.uivReloadCellGraph addSubview:self.uiivReloadBack];
    [self.refreshControl addSubview:self.uivReloadCellBackground];
    
    self.uiivReloadFront = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reload-front"]];
    [self.uivReloadCellGraph addSubview:self.uiivReloadFront];
    
    // Let the graphics be separated
    self.uivReloadCellGraph.clipsToBounds = YES;
    
    self.refreshControl.tintColor = [UIColor clearColor];
    [self.refreshControl addSubview:self.uivReloadCellGraph];
    
    bIconAssociated = NO;
    bAnimation = NO;
    [self.refreshControl addTarget:self action:@selector(refrashClicked) forControlEvents:UIControlEventValueChanged];
}

- (void)refrashClicked {
    [self loadShops];
    [self setImage];
    [self setMyAnotherMap];
    // Reload table data
    [self.tableView reloadData];
    [self delayUntilReloadFinished];
}

- (void)delayUntilReloadFinished {
    double dReloadSecond = 2.0;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dReloadSecond * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Finished");
        if (nssRefrashResultTitle != nil && [nssRefrashResultTitle isEqualToString:@""] == NO) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nssRefrashResultTitle
                                                            message:nssRefrashResultContent
                                                           delegate:nil
                                                  cancelButtonTitle:@"確認"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        [self.refreshControl endRefreshing];
    });
}

- (void)makeAnimation
{
    NSArray *nsaCellBackgroundColor = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    static int siColorIndex = 0;
    
    bAnimation = YES;
    
    if (self.refreshControl) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"上次更新時間: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
    }
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.uiivReloadFront setTransform:CGAffineTransformRotate(self.uiivReloadFront.transform, M_PI_2)];
                         [self.uiivReloadBack setTransform:CGAffineTransformRotate(self.uiivReloadBack.transform, M_PI_2)];
                         
                         self.uivReloadCellBackground.backgroundColor = [nsaCellBackgroundColor objectAtIndex:siColorIndex];
                         siColorIndex = (siColorIndex + 1) % nsaCellBackgroundColor.count;
                     }
                     completion:^(BOOL bFinished) {
                         if (self.refreshControl.isRefreshing) {
                             [self makeAnimation];
                         }else{
                             bAnimation = NO;
                             bIconAssociated = NO;
                             self.uivReloadCellBackground.backgroundColor = [UIColor clearColor];
                         }
                     }];
}

@end