//
//  VGeoManager.h
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import <CoreLocation/CoreLocation.h>

@protocol GeoManagerDelegate <NSObject>

-(void)didRequireGeoPermission:(BOOL)bSucceed;

@end

@interface VGeoManager : NSObject<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *cllmLocation;
@property (nonatomic, weak) id<GeoManagerDelegate>delegate;


-(void)setup;
-(void)start;
-(void)stop;
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VGeoManager)

@end
