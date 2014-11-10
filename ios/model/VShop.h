//
//  VShop.h
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface VShop : NSObject

@property (nonatomic, strong) NSString* mTitle;
@property (nonatomic, strong) NSString* mAddress;
@property (nonatomic, strong) CLLocation* mGeoPoint;
@property (nonatomic, readonly) NSInteger mDistance;

@end
