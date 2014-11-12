//
//  VParseManager.h
//  ios
//
//  Created by water su on 2014/11/13.
//  Copyright (c) 2014年 Appendectomy Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@protocol VParseManagerDelegate <NSObject>

-(void)didFinishLoading;

@end
@interface VParseManager : NSObject

@property (nonatomic, weak) id<VParseManagerDelegate>delegate;
@property (nonatomic) BOOL bLoading;

-(void)loadVShopFromServer;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VParseManager)
@end
