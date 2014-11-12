//
//  VShop.m
//  ios
//
//  Created by water su on 2014/11/10.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import "VShop.h"
#import "Utils.h"
#import "VShopData.h"

#define DUMP_MODE 0
#define LOAD_SHOP_FROM_JSON 0

@implementation VShop


- (id)initWithDictionary:(NSDictionary*)data{
    if (self = [super init]) {
        [self setData:data];
    }
    return self;
}
- (id)initWithShopData:(VShopData*)data{
    if (self = [super init]) {
        [self setDataWithShopData:data];
    }
    return self;
}
/*
 {
 "zone": "淡水",
 "title": "樹男咖啡館",
 "address": "新北市淡水區民生路52巷8號",
 "time": "9：00~21：30(周三公休)",
 "phone": "02-28087080",
 "website": "https：//www.facebook.com/TreemanCoffee?fref=ts"
 },
 */
-(void)setData:(NSDictionary*)dict{
    self.mTitle = [dict objectForKey:@"title"];
    self.mAddress = [dict objectForKey:@"address"];
    self.mZone = [dict objectForKey:@"zone"];
    self.mTime = [dict objectForKey:@"time"];
    self.mPhone = [dict objectForKey:@"phone"];
    self.mWebSite = [dict objectForKey:@"website"];
    
    self.mTitle = [self.mTitle stringByReplacingOccurrencesOfString:@"至" withString:@""];
    self.mAddress = [self.mAddress stringByReplacingOccurrencesOfString:@"至" withString:@""];
    self.mWebSite = [self.mWebSite stringByReplacingOccurrencesOfString:@"至" withString:@""];
#if DUMP_MODE
    self.mGeoPoint = [[CLLocation alloc]initWithCoordinate:[Utils geoCodeUsingAddress:[self stripAddress: self.mAddress]] altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:nil];
#else
    self.mGeoPoint = [[CLLocation alloc]initWithLatitude:[[dict valueForKey:@"lat"]floatValue]
                                                longitude:[[dict valueForKey:@"lon"]floatValue]];
#endif
}
-(void)setDataWithShopData:(VShopData*)data{
    self.mTitle = data.title;
    self.mAddress = data.address;
    self.mZone = data.vzone;
    self.mTime = data.time;
    self.mPhone = data.phone;
    self.mWebSite = data.website;
    
    self.mGeoPoint = [[CLLocation alloc]initWithLatitude:[data.lat floatValue]
                                               longitude:[data.lon floatValue]];
}
-(NSString*)stripAddress:(NSString*)address{
    NSRange range = [address rangeOfString:@"(" options:NSBackwardsSearch];
    if(range.length>0){
        NSString* modifiedString = [address substringToIndex:range.location];
        NSLog(@"%@ to %@",address,modifiedString);
        return modifiedString;
    }else{
        return address;
    }
}
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
- (NSMutableDictionary *)toNSDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.mTitle forKey:@"title"];
    [dictionary setValue:self.mAddress forKey:@"address"];
    [dictionary setValue:self.mZone forKey:@"zone"];
    [dictionary setValue:self.mTime forKey:@"time"];
    [dictionary setValue:self.mPhone forKey:@"phone"];
    [dictionary setValue:self.mWebSite forKey:@"website"];
    
    NSString* lat = [[NSString alloc] initWithFormat:@"%g°", self.mGeoPoint.coordinate.latitude];
    [dictionary setValue:lat forKey:@"lat"];
    NSString* lon = [[NSString alloc] initWithFormat:@"%g°", self.mGeoPoint.coordinate.longitude];
    [dictionary setValue:lon forKey:@"lon"];
    
    return dictionary;
}

+(void)dumpVShop:(NSArray*)shops{
    NSMutableArray* shopDic = [NSMutableArray array];
    for(VShop* shop in shops){
        [shopDic addObject:[shop toNSDictionary]];
    }
    NSError *error = nil;
    NSString* filepath = [NSString stringWithFormat:@"%@/dump.json",[Utils getDocumentFolderPath]];
    NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:filepath append:NO];
    [outputStream open];
    
    [NSJSONSerialization writeJSONObject:shopDic
                                toStream:outputStream
                                 options:0
                                   error:&error];
    [outputStream close];

}
+(NSMutableArray*)loadVShop{
#if LOAD_SHOP_FROM_JSON
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"vshop" ofType:@"json"];
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:nil];
    NSArray *json= [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray* shops = [NSMutableArray array];
    for(NSDictionary* obj in json){
        VShop* shop = [[VShop alloc]initWithDictionary:obj];
        [shops addObject:shop];
#if DUMP_MODE
        sleep(1);
#endif
    }
#if DUMP_MODE
    [VShop dumpVShop:shops];
#endif
    return shops;
#else
    // to load shop from coredata
    NSMutableArray* shops= [NSMutableArray array];
    NSArray* result = [VShopData fetchAll];
    for(VShopData* data in result){
        VShop* aShop = [[VShop alloc]initWithShopData:data];
        [shops addObject:aShop];
    }
    return shops;
#endif
}
@end
