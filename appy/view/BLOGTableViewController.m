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
#import "PLISTHeader.h"
#import "UIImageView+WebCache.h"

#import "BLOGViewController.h"

@interface BlogItem : NSObject
@property (nonatomic, strong) NSString *strImageUrl;
@property (nonatomic, strong) NSString *strSpan;
@property (nonatomic, strong) NSString *strTime;
@property (nonatomic, strong) NSString *strLink;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, unsafe_unretained) CGFloat cellHeight;
@end

@implementation BlogItem
@end

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
    
    NSString *nssRefrashResultTitle;
    NSString *nssRefrashResultContent;
    
    BOOL bIconAssociated;
    BOOL bAnimation;
    BOOL bTitleAdded;
}

@property (nonatomic, strong) NSMutableArray *blogItemsArr;
@end

@implementation BLOGTableViewController

- (NSMutableArray*)blogItemsArr
{
    if (_blogItemsArr)
        return _blogItemsArr;
    
    self.blogItemsArr = [NSMutableArray array];
    return _blogItemsArr;
}

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
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f, keyboardOffset: %f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height, cgfKeyboardOffset);
}

- (void)prepareTable
{
    MYParseDelegate *parser = [[MYParseDelegate alloc] init];
    [parser getStart:0];
    
    self.nsmaOutputTable = [NSMutableArray new];

    for (NSInteger i = 0; i < [parser.nsmaOutput count]; i++) {
        BlogItem *item = [[BlogItem alloc] init];
        item.strImageUrl = [[parser.nsmaOutput objectAtIndex:i]valueForKey:@"img"];
        item.strLink = [[parser.nsmaOutput objectAtIndex:i]valueForKey:@"link"];
        item.strSpan = [[parser.nsmaOutput objectAtIndex:i]valueForKey:@"span"];
        item.strTime = [[parser.nsmaOutput objectAtIndex:i]valueForKey:@"pubDate"];
        [self.blogItemsArr addObject:item];
    }
}

- (void)prepareAllImage
{
    [self.blogItemsArr enumerateObjectsUsingBlock:^(BlogItem *item, NSUInteger idx, BOOL *stop) {
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:[NSURL URLWithString:item.strImageUrl]
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 // progression tracking code
                                 NSLog(@"%ld / %ld", (long)receivedSize, (long)expectedSize);
                             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                 if (image && finished)
                                 {
                                     // do something with image
                                     item.image = image;
                                     item.cellHeight = cgfScreenWidth * image.size.height / image.size.width;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [self.tableView reloadData];
                                     });
                                 }
                                 
                             }];
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    BlogItem *item = [self.blogItemsArr objectAtIndex:indexPath.row];
    delegate.nssBLOGLink = [NSString stringWithString:item.strLink];
    NSLog(@"%@", delegate.nssBLOGLink);
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self makeKeyboardOffsetBack];
    [self.navigationController pushViewController:[BLOGViewController new] animated:YES];
}

- (void) makeKeyboardOffset {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y - cgfKeyboardOffset);
    [UIView commitAnimations];
}

- (void) makeKeyboardOffsetBack {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.0];
    self.view.center = CGPointMake(self.view.center.x, self.view.center.y);
    [UIView commitAnimations];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    [self setMyScreenSize];
    [self makeKeyboardOffset];
    [self prepareTable];
    [self prepareAllImage];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.blogItemsArr count];
}

#define TagImage    55
#define TagBlack    66
#define TagSpan     77
#define TagDate     88
#define nssGeneralCell  @"GeneralCell"


- (UITableViewCell *)createEmptyCell
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssGeneralCell];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectZero];
    UITextView *spanTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    UITextView *dateTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    imgView.tag = TagImage;
    blackView.tag = TagBlack;
    spanTextView.tag = TagSpan;
    dateTextView.tag = TagDate;
    [cell.contentView addSubview:imgView];
    [cell.contentView addSubview:blackView];
    [cell.contentView addSubview:spanTextView];
    [cell.contentView addSubview:dateTextView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nssTitleCell = @"TitleCell";
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nssTitleCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssTitleCell];
        }
        UIImage *uiimage = [UIImage imageNamed:@"blog1-1"];
        UIImageView *uiivJumbotron = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, cgfScreenWidth, self.tableView.frame.size.width * 45 / 320)];
        uiivJumbotron.image = uiimage;
        [cell.contentView addSubview:uiivJumbotron];
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nssGeneralCell];
    if (cell == nil) {
        cell = [self createEmptyCell];
    }
    
    BlogItem *item = [self.blogItemsArr objectAtIndex:indexPath.row];
    
    UIImage *uiiTmp = item.image;
    if (!uiiTmp)
        return [self createEmptyCell];
    
    
    UIImageView *uiivJumbotron = (UIImageView*)[cell.contentView viewWithTag:TagImage];
    uiivJumbotron.frame = CGRectMake(0.0, 0.0, cgfScreenWidth, cgfScreenWidth * uiiTmp.size.height / uiiTmp.size.width);
    uiivJumbotron.image = uiiTmp;
    
    UIView *uivBlackView = [cell.contentView viewWithTag:TagBlack];
    uivBlackView.frame = CGRectMake(0.0, (item.cellHeight - 49) * cgfScreenWidth / 320.0, cgfScreenWidth, 50.0);
    [uivBlackView setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]];
    
    UITextView *uitvSpan = (UITextView*)[cell.contentView viewWithTag:TagSpan];
    uitvSpan.frame =CGRectMake(cgfScreenWidth * 0.04, (item.cellHeight - 55) * cgfScreenWidth / 320.0, cgfScreenWidth * 0.92, 55.0 * cgfScreenWidth / 320.0);
    uitvSpan.editable = NO;
    [uitvSpan setFont:[UIFont systemFontOfSize:12]];
    [uitvSpan setBackgroundColor:[UIColor clearColor]];
    [uitvSpan setText:[NSString stringWithFormat:@"%@...", [item.strSpan substringToIndex:45]]];
    [uitvSpan setTextColor:[UIColor whiteColor]];
    
    UITextView *uitvPubDate = (UITextView*)[cell.contentView viewWithTag:TagDate];
    uitvPubDate.frame = CGRectMake(cgfScreenWidth * 0.04, (item.cellHeight - 25) * cgfScreenWidth / 320.0, cgfScreenWidth * 0.90, 35.0 * cgfScreenWidth / 320.0);
    uitvPubDate.editable = NO;
    [uitvPubDate setFont:[UIFont systemFontOfSize:12]];
    [uitvPubDate setBackgroundColor:[UIColor clearColor]];
    [uitvPubDate setTextAlignment:NSTextAlignmentRight];
    [uitvPubDate setText:[item.strTime substringToIndex:22]];
    [uitvPubDate setTextColor:[UIColor whiteColor]];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        return cgfScreenHeightBase + self.tableView.frame.size.width * 45 / 320 + cgfScreenHeight * 0.04;
        return self.tableView.frame.size.width * 90 / 640 + cgfScreenWidth * 25.0 / 640.0;
    } else {
        BlogItem *item = [self.blogItemsArr objectAtIndex:indexPath.row];
        if (item.image){
            if (indexPath.row == [self.blogItemsArr count] - 1) {
                return item.cellHeight + cgfScreenWidth * 15.0 / 640.0 + cgfScreenWidth * 15.0 / 640.0;
            } else {
                return item.cellHeight + cgfScreenWidth * 15.0 / 640.0;
            }
        }
        else
            return 0;       // image has not downloaded yet.
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect cgfRefreshBounds = self.refreshControl.bounds;
    CGFloat cgfPulledDistance = MAX(0.0, -self.refreshControl.frame.origin.y);
    
    CGFloat cgfMiddleX = self.tableView.frame.size.width / 2.0;
    
    CGFloat cgfRefreshHeight = self.uiivReloadBack.bounds.size.height;
    CGFloat cgfRefreshHeightHalf = cgfRefreshHeight * 0.8 / 3.0;
    
    CGFloat cgfRefreshWidth = self.uiivReloadBack.bounds.size.width;
    CGFloat cgfRefreshWidthHalf = cgfRefreshWidth / 2.0;
    
    CGFloat cgfFrontGraphHeight = self.uiivReloadFront.bounds.size.height;
    CGFloat cgfFrontGraphHeightHalf = cgfFrontGraphHeight * 0.8 / 3.0;
    
    CGFloat cgfFrontGraphWidth = self.uiivReloadFront.bounds.size.width;
    CGFloat cgfFrontGraphWidthHalf = cgfFrontGraphWidth / 2.0;
    
    CGFloat cgfPulledRatio = MIN( MAX(cgfPulledDistance, 0.0), 100.0) / 100.0;
    
    CGFloat BackgroundGraphY = cgfPulledDistance * 0.8 / 3.0 - cgfRefreshHeightHalf;
    CGFloat FrontGraphY = cgfPulledDistance * 0.8 / 3.0 - cgfFrontGraphHeightHalf;
    
    CGFloat BackgroundGraphX = (cgfMiddleX + cgfRefreshWidthHalf) - (cgfRefreshWidth * cgfPulledRatio);
    CGFloat FrontGraphX = (cgfMiddleX - cgfFrontGraphWidth - cgfFrontGraphWidthHalf) + (cgfFrontGraphWidth * cgfPulledRatio);
    
    if (fabsf(BackgroundGraphX - FrontGraphX) < 1.0) {
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉後卡開，進行更新"];
        bIconAssociated = YES;
    }
    
    if (bIconAssociated || self.refreshControl.isRefreshing) {
        BackgroundGraphX = cgfMiddleX - cgfRefreshWidthHalf;
        FrontGraphX = cgfMiddleX - cgfFrontGraphWidthHalf;
    }
    
    CGRect BackgroundGraphFrame = self.uiivReloadBack.frame;
    BackgroundGraphFrame.origin.x = BackgroundGraphX;
    BackgroundGraphFrame.origin.y = BackgroundGraphY;
    
    CGRect FrontGraphFrame = self.uiivReloadFront.frame;
    FrontGraphFrame.origin.x = FrontGraphX;
    FrontGraphFrame.origin.y = FrontGraphY;
    
    self.uiivReloadBack.frame = BackgroundGraphFrame;
    self.uiivReloadFront.frame = FrontGraphFrame;
    
    cgfRefreshBounds.size.height = cgfPulledDistance;
    
    self.uivReloadCellBackground.frame = cgfRefreshBounds;
    self.uivReloadCellGraph.frame = cgfRefreshBounds;
    
    if (self.refreshControl.isRefreshing && !bAnimation) {
        [self makeAnimation];
    }
}

- (void)setRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.uivReloadCellGraph = [[UIView alloc] initWithFrame:self.refreshControl.bounds];
    self.uivReloadCellGraph.backgroundColor = [UIColor clearColor];
    
    self.uivReloadCellBackground = [[UIView alloc] initWithFrame:self.refreshControl.bounds];
    self.uivReloadCellBackground.backgroundColor = [UIColor clearColor];
    self.uivReloadCellBackground.alpha = 0.15;
    
    self.uiivReloadBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reload-back"]];
    [self.uivReloadCellGraph addSubview:self.uiivReloadBack];
    [self.refreshControl addSubview:self.uivReloadCellBackground];
    
    self.uiivReloadFront = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reload-front"]];
    [self.uivReloadCellGraph addSubview:self.uiivReloadFront];
    
    // Let the graphics be separated
    self.uivReloadCellGraph.clipsToBounds = YES;
    
    self.refreshControl.tintColor = [UIColor clearColor];
    [self.refreshControl addSubview:self.uivReloadCellGraph];
    
    bIconAssociated = NO;
    bAnimation = NO;
    [self.refreshControl addTarget:self action:@selector(refrashClicked) forControlEvents:UIControlEventValueChanged];
}

- (void)refrashClicked {
    [self prepareTable];
    [self prepareAllImage];
    // Reload table data
    [self.tableView reloadData];
    [self delayUntilReloadFinished];
}

- (void)delayUntilReloadFinished {
    double dReloadSecond = 0.0;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(dReloadSecond * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Finished");
        if (nssRefrashResultTitle != nil && [nssRefrashResultTitle isEqualToString:@""] == NO) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nssRefrashResultTitle
                                                            message:nssRefrashResultContent
                                                           delegate:nil
                                                  cancelButtonTitle:@"確認"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        [self.refreshControl endRefreshing];
    });
}

- (void)makeAnimation
{
    NSArray *nsaCellBackgroundColor = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
    static int siColorIndex = 0;
    
    bAnimation = YES;
    
    if (self.refreshControl) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"上次更新時間: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
    }
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.uiivReloadFront setTransform:CGAffineTransformRotate(self.uiivReloadFront.transform, M_PI_2)];
                         [self.uiivReloadBack setTransform:CGAffineTransformRotate(self.uiivReloadBack.transform, M_PI_2)];
                         
                         self.uivReloadCellBackground.backgroundColor = [nsaCellBackgroundColor objectAtIndex:siColorIndex];
                         siColorIndex = (siColorIndex + 1) % nsaCellBackgroundColor.count;
                     }
                     completion:^(BOOL bFinished) {
                         if (self.refreshControl.isRefreshing) {
                             [self makeAnimation];
                         }else{
                             bAnimation = NO;
                             bIconAssociated = NO;
                             self.uivReloadCellBackground.backgroundColor = [UIColor clearColor];
                         }
                     }];
}

@end
