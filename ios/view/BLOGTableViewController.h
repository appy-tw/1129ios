//
//  BlogTableViewController.h
//  1129vday
//
//  Created by lololol on 26/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYParseDelegate.h"

@interface BLOGTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *nsmaOutputTable;
@property (nonatomic, strong) MYParseDelegate *myParseDelegate;

@end
