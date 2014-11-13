//
//  VParseManager.m
//  ios
//
//  Created by water su on 2014/11/13.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import "VParseManager.h"
#import "Parse/Parse.h"
#import "Utils.h"
#import "VShopData.h"

#define LAST_GET_VSHOP @"lastTimeGetVShop"

@implementation VParseManager
SYNTHESIZE_SINGLETON_FOR_CLASS(VParseManager)

-(id)init {
    if (self = [super init])  {
        self.bLoading = NO;
    }
    return self;
}

-(VShopData*)getVShopDataWithId:(NSString*)vid{
    NSError* error;
    NSPredicate* cmd = [NSPredicate predicateWithFormat:@"vid = %@",vid];
    NSArray* result = [VShopData fetchWithPredicate:cmd error:&error];
    return [result firstObject];
}
-(void)loadVShopFromServer{
    if(self.bLoading){
        NSLog(@"already loading");
        return;
    }
    self.bLoading = YES;
        
    PFQuery *query = [PFQuery queryWithClassName:@"vshop"];
    NSDate* lastGet = [Utils getPreferenceForKey:LAST_GET_VSHOP];
    if(lastGet == nil){
        lastGet = [NSDate dateWithTimeIntervalSince1970:0];
    }
    [query whereKey:@"updatedAt" greaterThan:lastGet];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.retriveTime = [NSDate date];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for(PFObject* obj in objects){
                NSString* vid = obj.objectId;
                VShopData* shop = [self getVShopDataWithId:vid];
                if(shop == nil){
                    shop = [VShopData newEntity];
                    shop.vid = vid;
                }
                
                shop.title = [obj objectForKey:@"title"];
                shop.address = [obj objectForKey:@"address"];
                shop.phone = [obj objectForKey:@"phone"];
                shop.time = [obj objectForKey:@"time"];
                shop.lon = [obj objectForKey:@"lon"];
                shop.lat = [obj objectForKey:@"lat"];
                shop.vzone = [obj objectForKey:@"zone"];
                shop.website = [obj objectForKey:@"website"];
            }
            [VShopData commit];
            [Utils writePreference:self.retriveTime forKey:LAST_GET_VSHOP]; // keep current time
            if(self.delegate)
                [self.delegate didFinishLoading];
        }else{
            NSLog(@"retrive vshop data error!");
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.bLoading = NO;
    }];
}
@end
