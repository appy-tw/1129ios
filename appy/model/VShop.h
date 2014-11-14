//
//  VShop.h
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import MapKit;

@interface VShop : NSObject

@property (nonatomic, strong) NSString* mTitle;
@property (nonatomic, strong) NSString* mAddress;
@property (nonatomic, strong) NSString* mZone;
@property (nonatomic, strong) NSString* mTime;
@property (nonatomic, strong) NSString* mPhone;
@property (nonatomic, strong) NSString* mWebSite;
@property (nonatomic, strong) NSString* mType;

@property (nonatomic, strong) CLLocation* mGeoPoint;
@property (nonatomic, readonly) NSInteger mDistance;
@property (nonatomic, readonly) NSString* key;

+(NSMutableArray*)loadVShop;

@end
