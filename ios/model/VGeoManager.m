//
//  VGeoManager.m
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import "VGeoManager.h"

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
}
-(void)start{
    if(self.cllmLocation != nil)
        [self.cllmLocation startUpdatingLocation];
    else{
        [self setup];
        [self.cllmLocation startUpdatingLocation];
    }
}
-(void)stop{
    if(self.cllmLocation != nil)
        [self.cllmLocation stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    NSLog(@"got location info");
}
@end
