//
//  Utils.m
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(CLLocation*)getUserLocation{
    CLLocation *cllNow = [[CLLocation alloc]initWithLatitude:25.042594 longitude:121.614642];
    return cllNow;
}

@end
