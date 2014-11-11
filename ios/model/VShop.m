//
//  VShop.m
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import "VShop.h"
#import "Utils.h"

@implementation VShop

-(NSInteger)mDistance{
    CLLocation *cllNow = [Utils getUserLocation];
    CLLocation *cllTarget = self.mGeoPoint;
    CLLocationDistance dist = [cllNow distanceFromLocation:cllTarget];
    return dist;
}
-(NSString*)key{
    return [NSString stringWithFormat:@"%@-%@",self.mTitle,self.mAddress];
}

- (NSComparisonResult)compare:(VShop *)otherObject {
    if(self.mDistance > otherObject.mDistance)
        return NSOrderedDescending;
    else if(self.mDistance < otherObject.mDistance)
        return NSOrderedAscending;
    else
        return [self.mAddress compare:otherObject.mAddress];
}

@end
