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

#define LOADING_CELL_TAG 1000

#import "PLISTHeader.h"

@interface BLOGTableViewController ()
{
    CGFloat cgfAvailableWidth;
    CGFloat cgfAvailableHeight;
    CGFloat cgfAvailableHeightStart;
    CGFloat cgfAvailableHeightEnd;
    
    CGFloat cgfStatusBarHeight;
    CGFloat cgfNavigationBarHeight;
    CGFloat cgfTabBarHeight;
    
    AppDelegate *delegate;
    NSInteger nsiCurrentMaximum;
    
    BOOL bHasMoreCell;
    
    NSString *nssNowTag;
    
    NSMutableArray *nsmaImageURL;
    NSMutableArray *nsmaSpan;
    NSMutableArray *nsmaTime;
    NSMutableArray *nsmaLink;
}

@end

@implementation BLOGTableViewController

- (void)setMyScreenSize
{
    cgfStatusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    cgfNavigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    cgfTabBarHeight = [[[self tabBarController]tabBar]bounds].size.height;
    
    cgfAvailableHeight = [[UIScreen mainScreen] bounds].size.height - cgfStatusBarHeight - cgfTabBarHeight - cgfNavigationBarHeight;
    cgfAvailableWidth = [[UIScreen mainScreen] bounds].size.width;
    
    cgfAvailableHeightStart = cgfStatusBarHeight + cgfNavigationBarHeight;
    cgfAvailableHeightEnd = cgfAvailableHeight - cgfTabBarHeight;
    
    NSLog(@"AvailableScreen:%fx%f",cgfAvailableWidth,cgfAvailableHeight);
    NSLog(@"Available High:%f-%f",cgfAvailableHeightStart,cgfAvailableHeightEnd);
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
    for (NSInteger i = 0; i < [_myParseDelegate.nsmaOutput count]; i++) {
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

- (void)prepareTheInitImage {
    for (int i = nsiCurrentMaximum; i < nsiCurrentMaximum + 3; i++) {
        UIImage *uiiJumbotron = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://31.media.tumblr.com/e1e0a5e307a70a3aa38d8bfa3d054782/tumblr_inline_neiefugqPj1t34avp.png"]]];
        [_nsmaCellImage addObject:uiiJumbotron];
        [_nsmaCellSize addObject:[NSNumber numberWithFloat:cgfAvailableWidth * uiiJumbotron.size.height / uiiJumbotron.size.width]];
        NSLog(@"cgfAvailableWidth: %f , uiiJumbotron.size.height: %f, uiiJumbotron.size.width: %f", cgfAvailableWidth, uiiJumbotron.size.height, uiiJumbotron.size.width);
        NSLog(@"cgfAvailableWidth * uiiJumbotron.size.height / uiiJumbotron.size.width: %f", cgfAvailableWidth * uiiJumbotron.size.height / uiiJumbotron.size.width);
    }
    for (int i = nsiCurrentMaximum; i < nsiCurrentMaximum + 3; i++) {
        NSLog(@"%f", [[_nsmaCellSize objectAtIndex:i] floatValue]);
    }
    nsiCurrentMaximum += 3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyScreenSize];
    [self prepareTable];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    bHasMoreCell = YES;
    nsiCurrentMaximum = 0;
    _nsmaCellImage = [NSMutableArray array];
    _nsmaCellSize = [NSMutableArray array];
    [self prepareTheInitImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
//    return [_myParseDelegate.nsmaOutput count];
    return nsiCurrentMaximum;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nssTitleCell = @"TitleCell";
    static NSString *nssGeneralCell = @"GeneralCell";
    static NSString *nssMoreCell = @"MoreCell";
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nssTitleCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssTitleCell];
        }
        UIImage *uiimage = [UIImage imageNamed:@"blog1-1"];
        UIImageView *uiivJumbotron = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, cgfAvailableHeightStart, cgfAvailableWidth, self.tableView.frame.size.width * 45 / 320)];
        uiivJumbotron.image = uiimage;
        [cell.contentView addSubview:uiivJumbotron];
        return cell;
    }
    if (indexPath.row < nsiCurrentMaximum) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nssGeneralCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nssGeneralCell];
        }
        UIImageView *uiivJumbotron = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, 0.0, cgfAvailableWidth, [[_nsmaCellSize objectAtIndex:indexPath.row] floatValue] - 3.0)];
        uiivJumbotron.image = [_nsmaCellImage objectAtIndex:indexPath.row];
        [cell.contentView addSubview:uiivJumbotron];
        return cell;
    } else {
//        return [self loadingCell];
        return nil;
    }
    
    // Configure the cell...
//    [cell.uilNewsTypeTip setText:@"魔王狀況"];
//    [cell.uilTitle setText:@"【蔡正元Ａ錢，罪證明確】－罷免Ａ錢蔡，全國都喊讚"];
//    NSString *myHTML = @"<p><img src=\"https://31.media.tumblr.com/5d16fb1841c0eecda0ac9bebc4604972/tumblr_inline_negd139wf01t34avp.jpg\"/></p> <p><br/><span>昨天我們在濟南路怒吼一整晚，即使我們幹聲震天，但對於依然充耳不聞的政府，我們知道只有怒吼是不夠的，只有所有的你，在罵幹的時候走出家門，踏進每一個連署攤位，才能用聚集而成的力量撼動這些麻木不仁的既得利益者，讓台灣成為人民的台灣。</span><br/><!-- more --><br/><span>昨晚的晚會順利結束，割闌尾團隊要感謝共同主辦的翻轉選舉及島國前進，協辦的公投護台灣聯盟，以及所有的友好團體：經濟民主連合、臺左維新、伴侶盟、激進(radicalization)、公民攝影守護民主陣線、巢運、公民監督國會聯盟、公民組合</span><span class=\"text_exposed_show\">青年志工團、公民1985行動聯盟、民主鬥陣及全面罷免；共同響應的團體有台北蜂鳥、民主黑潮學生聯盟、陳文成基金會、台灣青年反共救國團 、台灣維吾爾之友會、獨臺新社、綠色公民行動聯盟、臺灣守護民主平台。同時非常感謝表演嘉賓：拷秋勤 Kou Chou Ching、DJ Andy Lau （青錡）、陳明章老師、農村武裝青年、滅火器 Fire EX.及GreenEyes；也謝謝所有講者的辛勞：賴中強 (經濟民主連合召集人)、黃國昌 (島國前進發起人，中研院法研所副研究員)、台北林先生 (割闌尾計畫發言人)、李川信 (公投護台灣聯盟副召集人)、陳為廷 (島國前進發起人)、張宏林 (公民監督國會聯盟執行長) 、馮光遠 (憲法133實踐聯盟發起人)、許韋婷 (公民組合青年志工團團長)、林飛帆 (島國前進發起人)，更感謝及感動於參加晚會的所有的你，謝謝大家，請和我們繼續向前，１１２９我們不罷不散。<br/><br/>【割闌尾計畫/板橋手術中】<br/>時間： 11/03 (一) 19:00-21:00<br/>地點： 江子翠3號雙十人行廣場<br/>●板橋割闌尾志工報名：<a href=\"http://l.facebook.com/l.php?u=http%3A%2F%2Fgoo.gl%2FGBVDd7&amp;h=iAQFVhR_4&amp;enc=AZOyRUEWcKRDCpSN_XT2paQ2WYl3SOuEKwsHhc1P4Ev7ku8-3ZlIwRGiiFYCRHsNCOJQURJiaq4EI2pk-EFSjOII6F8L588GdpIzCPYT9Gtt3d5yZQf_b0ch6_cHRcWUpoJPs-88Ikj0FZNhe1JTG1dJ&amp;s=1\" rel=\"nofollow nofollow\" target=\"_blank\">http://goo.gl/GBVDd7</a><br/><br/>&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;&#8212;-<br/>【現在加入。割闌尾V計劃 <a href=\"http://l.facebook.com/l.php?u=http%3A%2F%2F1129vday.tw%2F&amp;h=zAQHPLdg6&amp;enc=AZPBhNRzqTPXw-S8iTgQgwPvsfeVYgolhroPuXB9XkYuQiCflfrms4ww3JK-QrPNbv98oAPr3qt2k1YSb7ippDM416NE7NhsvPjv2B1Cs2CGuX3fv1f3kpQuV7f0_dYBt0S5uB64cw1kdxCz49v_g0gM&amp;s=1\" rel=\"nofollow nofollow\" target=\"_blank\">http://1129vday.tw/</a>】<br/><br/>■ 連署書代收店家列表一覽 &#8212;&gt;<br/><a href=\"http://l.facebook.com/l.php?u=http%3A%2F%2F1129vday.tw%2F%23%2Fpetition&amp;h=LAQHsyvSG&amp;enc=AZN5eP86yj2Y8CrjnxMd9zMfB3OkjHJgi6nrQ8osMoN6AHGG6dxgfgn2U6fMz4FzaFo6DIcCNktvhBTNuSvjUTqv6WOje8yld7TKferTeoXxDHSnpHqU8aFzlM8YIiaBhKCxnUodpYAtVwKRDSCW_Ma4&amp;s=1\" rel=\"nofollow nofollow\" target=\"_blank\">http://1129vday.tw/#/petition</a><br/><br/>■ 在地罷免團體 &#8212;&gt;<br/>割闌尾計畫/民主wego陣線 <a href=\"http://goo.gl/bc9z0b\" rel=\"nofollow nofollow\" target=\"_blank\">http://goo.gl/bc9z0b</a><br/>割闌尾計畫/板橋手術中 <a href=\"http://l.facebook.com/l.php?u=http%3A%2F%2Fgoo.gl%2F6kE5we&amp;h=UAQHQzex9&amp;enc=AZOYwon4zWxcuYrVnUu1XNs5vjn5p5vNDYEq7gNYEErkA6F-cyQBKoycPuqHeX1DSY1teiSPALegtlwbWR8jLcMFWxtAJjXExjX3oJr6rnaB-ob0TENk9NscT9gIXOUNjy-Q8Wa6rMIHtBAM7D4wMWmx&amp;s=1\" rel=\"nofollow nofollow\" target=\"_blank\">http://goo.gl/6kE5we</a><br/>割闌尾計畫/正元手術房 <a href=\"http://goo.gl/NVgiV2\" rel=\"nofollow nofollow\" target=\"_blank\">http://goo.gl/NVgiV2</a></span></p>";
//    [cell.uitvContent loadHTMLString:myHTML baseURL:nil];
//    [cell.uitvContent setText:@"資深司法記者黃越宏按鈴控告【蔡正元Ａ錢，罪證明確】，憲法133實踐聯盟發起人馮光遠、割闌尾計畫聯手到場聲援，號召全民罷免爛立委。蔡正元利用擔任中影董事長期間，犯下「業務侵占」罪，並經士林地方法院判刑一年在案，卻由中影與檢方聯手吃案，"];
    
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
    //    NSString *theText=[[_loadedNames objectAtIndex: indexPath.row] name];
    //    CGSize labelSize = [theText sizeWithFont:[UIFont fontWithName: @"FontA" size: 15.0f] constrainedToSize:kLabelFrameMaxSize];
//    return 340;
    if (indexPath.row == 0) {
        return cgfAvailableHeightStart + self.tableView.frame.size.width * 45 / 320 + cgfAvailableHeight * 0.04;
    } else {
        NSLog(@"[[_nsmaCellSize objectAtIndex:indexPath.row] floatValue]: %f", [[_nsmaCellSize objectAtIndex:indexPath.row] floatValue]);
        return [[_nsmaCellSize objectAtIndex:indexPath.row] floatValue];
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
