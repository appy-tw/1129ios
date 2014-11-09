//
//  BlogTableViewController.m
//  1129vday
//
//  Created by lololol on 26/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "BLOGTableViewController.h"
#import "BLOGTableViewCell.h"
#import "MYParseDelegate.h"
#import "AppDelegate.h"

#import "SVPullToRefresh.h"

#define LOADING_CELL_TAG 1000

#import "PLISTHeader.h"

@interface BLOGTableViewController ()
{
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    CGFloat cgfKeyboardOffset;
    
    CGFloat cgfStatusBarHeight;
    CGFloat cgfNavigationBarHeight;
    CGFloat cgfTabBarHeight;
    
    AppDelegate *delegate;
    
    NSMutableArray *nsmaImageURL;
    NSMutableArray *nsmaSpan;
    NSMutableArray *nsmaTime;
    NSMutableArray *nsmaLink;
    NSInteger nsiGlobalMaximum;

    NSMutableArray *nsmaUImage;
    NSMutableArray *nsmaCellHeight;
    NSInteger nsiCurrentCellMaximum;
    BOOL bHasMoreCell;
    NSString *nssNowTag;
}

@end

@implementation BLOGTableViewController

- (void)setMyScreenSize
{
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([UIApplication sharedApplication].statusBarFrame.size.height == 20.0) {
        //without Hotspot: 64
        cgfKeyboardOffset =  cgfScreenHeightBase;
    } else {
        //with Hotspot: 104
        cgfKeyboardOffset = cgfScreenHeightBase + [UIApplication sharedApplication].statusBarFrame.size.height / 2.0;
    }
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f, keyboardOffset: %f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, delegate.navigationController.navigationBar.frame.size.height, cgfKeyboardOffset);
}

- (void)prepareTable
{
    _myParseDelegate = [[MYParseDelegate alloc]init];
    [_myParseDelegate getStart:0];
    
    nsmaImageURL = [NSMutableArray new];
    nsmaLink = [NSMutableArray new];
    nsmaSpan = [NSMutableArray new];
    nsmaTime = [NSMutableArray new];
    
    self.nsmaOutputTable = [NSMutableArray new];
    nsiGlobalMaximum = [_myParseDelegate.nsmaOutput count];
    for (NSInteger i = 0; i < nsiGlobalMaximum; i++) {
        [nsmaTime addObject:[[_myParseDelegate.nsmaOutput objectAtIndex:i]valueForKey:@"pubDate"]];
        [nsmaSpan addObject:[[_myParseDelegate.nsmaOutput objectAtIndex:i]valueForKey:@"span"]];
        [nsmaImageURL addObject:[[_myParseDelegate.nsmaOutput objectAtIndex:i]valueForKey:@"img"]];
        [nsmaLink addObject:[[_myParseDelegate.nsmaOutput objectAtIndex:i]valueForKey:@"link"]];
    }
    
//    for (NSInteger i = 0; i < [nsmaLink count]; i++) {
//        NSLog(@"nsmaTime: %@", [nsmaTime objectAtIndex:i]);
//        NSLog(@"nsmaSpan: %@", [nsmaSpan objectAtIndex:i]);
//        NSLog(@"nsmaImageURL: %@", [nsmaImageURL objectAtIndex:i]);
//        NSLog(@"nsmaLink: %@", [nsmaLink objectAtIndex:i]);
//    }
    _myParseDelegate = nil;
}

- (void)prepareImage:(NSInteger)nsiIndexOfFirstToAdd
           lastToAdd:(NSInteger)nsiIndexOfLastToAdd{
//    NSInteger nsiIndexOfFirstToAdd = 0;
//    NSInteger nsiIndexOfLastToAdd = 1;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"nsiIndexOfFirstToAdd: %ld, nsiIndexOfLastToAdd: %ld", (long)nsiIndexOfFirstToAdd, (long)nsiIndexOfLastToAdd);
        for (NSInteger i = nsiIndexOfFirstToAdd; i <= nsiIndexOfLastToAdd && i <= nsiGlobalMaximum; i ++) {
            NSLog(@"%ld: %@", (long)i,[NSURL URLWithString:[nsmaImageURL objectAtIndex:i]]);
            UIImage *uiiTmp = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[nsmaImageURL objectAtIndex:i]]]];
            [nsmaUImage addObject:uiiTmp];
            [nsmaCellHeight addObject:[NSString stringWithFormat: @"%.f", cgfScreenWidth * uiiTmp.size.height / uiiTmp.size.width]];
            NSLog(@"cgfAvailableWidth * uiiTmp.size.height / uiiTmp.size.width: %@", [NSString stringWithFormat: @"%.f", cgfScreenWidth * uiiTmp.size.height / uiiTmp.size.width]);
            nsiCurrentCellMaximum ++;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyScreenSize];
    [self prepareTable];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    bHasMoreCell = YES;
    nsiCurrentCellMaximum = 0;
    nsmaUImage = [NSMutableArray array];
    nsmaCellHeight = [NSMutableArray array];
    [self prepareImage:0 lastToAdd:2];
    [self.tableView addPullToRefreshWithActionHandler:^{
        [self prepareImage:nsiCurrentCellMaximum + 1 lastToAdd:nsiCurrentCellMaximum + 5];
        [self.tableView.infiniteScrollingView stopAnimating];
    } position:SVPullToRefreshPositionBottom];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
//    return [_myParseDelegate.nsmaOutput count];
    if (section == 0) {
        return 1;
    }
    NSLog(@"nsiCurrentCellMaximum: %d", nsiCurrentCellMaximum);
    return nsiCurrentCellMaximum;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nssTitleCell = @"TitleCell";
    static NSString *nssGeneralCell = @"GeneralCell";
    static NSString *nssMoreCell = @"MoreCell";
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nssTitleCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssTitleCell];
        }
        UIImage *uiimage = [UIImage imageNamed:@"blog1-1"];
        UIImageView *uiivJumbotron = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, cgfScreenHeightBase, cgfScreenWidth, self.tableView.frame.size.width * 45 / 320)];
        uiivJumbotron.image = uiimage;
        [cell.contentView addSubview:uiivJumbotron];
        return cell;
    }
    
    
    if (indexPath.row < nsiCurrentCellMaximum) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nssGeneralCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssGeneralCell];
        }
        UIImage *uiiTmp = [nsmaUImage objectAtIndex:indexPath.row];
        UIImageView *uiivJumbotron = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, cgfScreenWidth, cgfScreenWidth * uiiTmp.size.height / uiiTmp.size.width)];
        uiivJumbotron.image = [nsmaUImage objectAtIndex:indexPath.row];
        [cell.contentView addSubview:uiivJumbotron];
        UIView *uivBlackView = [[UIView alloc]initWithFrame:CGRectMake(0.0, [[nsmaCellHeight objectAtIndex:indexPath.row]floatValue] - 49, cgfScreenWidth, 50.0)];
        [uivBlackView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]];
        [cell.contentView addSubview:uivBlackView];
        UITextView *uitvSpan = [[UITextView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 0.04, [[nsmaCellHeight objectAtIndex:indexPath.row]floatValue] - 55, cgfScreenWidth * 0.92, 55.0)];
        uitvSpan.editable = NO;
        [uitvSpan setFont:[UIFont systemFontOfSize:12]];
        [uitvSpan setBackgroundColor:[UIColor clearColor]];
        [uitvSpan setText:[NSString stringWithFormat:@"%@...", [[nsmaSpan objectAtIndex:indexPath.row]substringToIndex:45]]];
        [uitvSpan setTextColor:[UIColor whiteColor]];
        [cell.contentView addSubview:uitvSpan];
        UITextView *uitvPubDate = [[UITextView alloc]initWithFrame:CGRectMake(cgfScreenWidth * 0.04, [[nsmaCellHeight objectAtIndex:indexPath.row]floatValue] - 25, cgfScreenWidth * 0.90, 35.0)];
        uitvPubDate.editable = NO;
        [uitvPubDate setFont:[UIFont systemFontOfSize:12]];
        [uitvPubDate setBackgroundColor:[UIColor clearColor]];
        [uitvPubDate setTextAlignment:NSTextAlignmentRight];
        [uitvPubDate setText:[[nsmaTime objectAtIndex:indexPath.row]substringToIndex:22]];
        [uitvPubDate setTextColor:[UIColor whiteColor]];
        [cell.contentView addSubview:uitvPubDate];
        return cell;
    } else {
//        return [self loadingCell];
        return nil;
    }
    
//    [cell.uilTitle setText:[[_myParseDelegate.nsmaOutput objectAtIndex:indexPath.row]valueForKey:TAG_TITLE]];
//    [cell.uitvContent setText:[[_myParseDelegate.nsmaOutput objectAtIndex:indexPath.row]valueForKey:TAG_DESCRIPTION]];

    
//    if (indexPath.row < self.dashboardPosts.count) {
//        return [self configureCell:indexPath];
//    } else {
//        return [self loadingCell];
//    }

    
}

#pragma mark - Table view delegate

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (cell.tag == LOADING_CELL_TAG) {
//        cell.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
//        if (bHasMoreCell == YES) {
//            [self requestDashboardPosts];
//        }
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return cgfScreenHeightBase + self.tableView.frame.size.width * 45 / 320 + cgfScreenHeight * 0.04;
    } else {
        return [[nsmaCellHeight objectAtIndex:indexPath.row]floatValue] + 10;
    }
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

- (UITableViewCell *)loadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleDefault
                             reuseIdentifier:nil];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]
                                                  initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = cell.center;
    [cell.contentView addSubview:activityIndicator];
    
    [activityIndicator startAnimating];
    
    cell.tag = LOADING_CELL_TAG;
    
    return cell;
}

@end
