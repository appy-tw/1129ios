//
//  Utils.m
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import "Utils.h"
#import "VGeoManager.h"

@import UIKit;

@implementation Utils

+(CLLocation*)getUserLocation{
    return [VGeoManager sharedInstance].cllmLocation.location;
}
+ (void)openSettings
{
    BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
