//
//  VShopDataEntity.h
//  ios
//
//  Created by water su on 2014/11/13.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RHManagedObject+legacy.h"


@interface VShopDataEntity : RHManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * lat;
@property (nonatomic, retain) NSString * lon;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * vid;
@property (nonatomic, retain) NSString * vzone;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * type;

@end
