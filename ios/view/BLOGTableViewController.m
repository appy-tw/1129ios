//
//  BlogTableViewController.m
//  1129vday
//
//  Created by lololol on 26/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "BLOGTableViewController.h"
#import "BLOGTableViewCell.h"
//#import "MYParseDelegate.h"

#import "PLISTHeader.h"

@interface BLOGTableViewController ()
{
//    MYParseDelegate *myParseDelegate;
}

@end

@implementation BLOGTableViewController

- (void)prepareTable
{
    _myParseDelegate = [[MYParseDelegate alloc]init];
    [_myParseDelegate getStart:0];
    
    self.nsmaOutputTable = [NSMutableArray new];
    for (int i = 0; i < [_myParseDelegate.nsmaOutput count]; i++) {
        [self.nsmaOutputTable addObject:[_myParseDelegate.nsmaOutput objectAtIndex:i]];
        //        NSLog(@"i: %d", i);
        for (NSString* wkey in [_myParseDelegate.nsmaOutput objectAtIndex:i]) {
            //            NSLog(@"%@", key);
        }
    }
    
    
    //    for (id idDictionary in myParse.nsmaOutput) {
    //        [self.nsmaOutputTable addObject:idDictionary];
    //        keys=[idDictionary allKeys];
    //        NSLog(@"%@", keys);
    ////        for (NSString* key in keys) {
    ////            NSLog(@"%@", key);
    ////        }
    //    }
    //    for (int i = 0; i < [[myParse nsmaOutput] count]; i++) {
    //        if ([[[myParse nsmaOutput][i] objectForKey:@"Time"] compare:nssMyTime options:(NSNumericSearch)] == 1) {
    //            [self.nsmaTrainTable addObject:[myParse nsmaOutputTable][i]];
    //        }
    //    }
    //    [self sortTable];
    //    [myParse releaseAll];
//    _myParseDelegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self prepareTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_myParseDelegate.nsmaOutput count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = @"Cell";
    BLOGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[BLOGTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    // Configure the cell...
//    [cell.uilNewsTypeTip setText:@"魔王狀況"];
//    [cell.uilTitle setText:@"【蔡正元Ａ錢，罪證明確】－罷免Ａ錢蔡，全國都喊讚"];
    [cell.uitvContent setText:@"資深司法記者黃越宏按鈴控告【蔡正元Ａ錢，罪證明確】，憲法133實踐聯盟發起人馮光遠、割闌尾計畫聯手到場聲援，號召全民罷免爛立委。蔡正元利用擔任中影董事長期間，犯下「業務侵占」罪，並經士林地方法院判刑一年在案，卻由中影與檢方聯手吃案，"];
    //        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@""]]];
    [cell.uiivNewsTypeLogo setImage:[UIImage imageNamed:@"blogp_NewsTypeLogo"]];
    [cell.uiivNewsTypeBackground setImage:[UIImage imageNamed:@"blogp_NewsTypeBackground"]];
    
    [cell.uilTitle setText:[[_myParseDelegate.nsmaOutput objectAtIndex:indexPath.row]valueForKey:TAG_TITLE]];
//    [cell.uitvContent setText:[[_myParseDelegate.nsmaOutput objectAtIndex:indexPath.row]valueForKey:TAG_DESCRIPTION]];


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSString *theText=[[_loadedNames objectAtIndex: indexPath.row] name];
    //    CGSize labelSize = [theText sizeWithFont:[UIFont fontWithName: @"FontA" size: 15.0f] constrainedToSize:kLabelFrameMaxSize];
    return 200;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
