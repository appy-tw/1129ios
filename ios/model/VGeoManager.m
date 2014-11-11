//
//  VGeoManager.m
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import "VGeoManager.h"
#import "Utils.h"
@import UIKit;

@implementation VGeoManager
SYNTHESIZE_SINGLETON_FOR_CLASS(VGeoManager)

-(CLLocationManager*)cllmLocation{
    if(_cllmLocation == nil){
        [self setup];
    }
    return _cllmLocation;
}
-(void)setup{
    if (_cllmLocation == nil) {
        self.cllmLocation = [[CLLocationManager alloc]init];
        self.cllmLocation.delegate = self;
        self.cllmLocation.desiredAccuracy = kCLLocationAccuracyBest;
    }
    [self start];
}
-(void)start{
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        if ([self.cllmLocation respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.cllmLocation requestWhenInUseAuthorization];
        }
    }else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        [self permoteRequirePermission];
    }else{
        if(self.cllmLocation != nil)
            [self.cllmLocation startUpdatingLocation];
        else{
            [self setup];
            [self.cllmLocation startUpdatingLocation];
        }
    }
}
-(void)stop{
    if(self.cllmLocation != nil)
        [self.cllmLocation stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    NSLog(@"got location info");
}
-(void)permoteRequirePermission{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TK_ALERT_TITLE_NOTICE",nil)
                                                    message:NSLocalizedString(@"TK_RE_REQUIRE_GEO_PERMISSION",nil)
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"TK_ALERT_BTN_LATER",nil)
                                          otherButtonTitles:NSLocalizedString(@"TK_ALERT_BTN_GO_SETTING",nil),nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 1:
            [Utils openSettings];
            break;
            
        default:
            break;
    }
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"permission changed");
    if(status == kCLAuthorizationStatusNotDetermined){
        if ([self.cllmLocation respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.cllmLocation requestWhenInUseAuthorization];
            [self.delegate didRequireGeoPermission:NO];
        }
    }else if (status == kCLAuthorizationStatusDenied){
        [self permoteRequirePermission];
        [self.delegate didRequireGeoPermission:NO];
    }else{
        [self.delegate didRequireGeoPermission:YES];
    }
}
@end
