//
//  AppDelegate.m
//  1129vday
//
//  Created by lololol on 26/Oct/14.
//  Copyright (c) 2014 appy.tw. All rights reserved.
//

#import "AppDelegate.h"

#import "TabBarController.h"
#import "MSTableViewController.h"
#import "BLOGTableViewController.h"
#import "KGTableViewController.h"
#import "SUPTableViewController.h"
#import "ATTTableViewController.h"

#import "PointerViewController.h"

#import "PLISTHeader.h"

#import <FacebookSDK/FacebookSDK.h>

#import <Parse/Parse.h>

#import "KeyHeader.h"

@interface AppDelegate ()
{
    TabBarController *tabBarController;
    MSTableViewController *msTableViewController;
    //簡介，uiview
    BLOGTableViewController *blogTableViewController;
    //戰況，魔王，uitableview
    KGTableViewController *kgTableViewController;
    //魔王的各領地資料
    SUPTableViewController *supTableViewController;
    //代收據點
    ATTTableViewController *attTableViewController;
    //討伐令，含行前事項
    PointerViewController *pointerViewController;
//    UINavigationController *navigationController;
    UIImage *uiiTabBarBackground;
}

@end

@implementation AppDelegate

- (void)setMyTabBarItem
{
    //set the tab bar title appearance for normal state
//    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f], NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1]} forState:UIControlStateSelected];
//    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f], NSForegroundColorAttributeName : [UIColor colorWithRed:0.68 green:0.68 blue:0.68 alpha:1]} forState:UIControlStateNormal];
//    [[UITabBar appearance] setTintColor:[UIColor redColor]];
//    [UITabBar appearance].tintColor = [UIColor whiteColor];
//    [tabBarController.tabBar setBackgroundColor:[UIColor colorWithRed:0.79 green:0.0 blue:0.18 alpha:1.0]];
    
//    uiiTabBarBackground = [UIImage imageNamed:@"tabbar"];
//    [[UITabBar appearance] setBackgroundImage:uiiTabBarBackground];
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
//    [tabBarController.tabBar setBackgroundImage:uiiTabBarBackground];
}

- (void)setMyViewController {
    msTableViewController = [[MSTableViewController alloc]init];
    _navigationControllerMS = [[UINavigationController alloc]initWithRootViewController:msTableViewController];
    _navigationControllerMS.title = NSLocalizedString(@"割闌尾計劃", nil);
    _navigationControllerMS.tabBarItem.image = [UIImage imageNamed:@"ms"];
    _navigationControllerMS.navigationBarHidden = YES;
    
    blogTableViewController = [[BLOGTableViewController alloc]init];
    _navigationControllerBlog = [[UINavigationController alloc]initWithRootViewController:blogTableViewController];
    _navigationControllerBlog.title = NSLocalizedString(@"即時戰況", nil);
    _navigationControllerBlog.tabBarItem.image = [UIImage imageNamed:@"blog"];
    _navigationControllerBlog.navigationBarHidden = YES;
    
    kgTableViewController = [[KGTableViewController alloc]init];
//    pointerViewController = [[PointerViewController alloc]initWithViewController:kgTableViewController];
//    _navigationController = [[UINavigationController alloc]initWithRootViewController:pointerViewController];
    _navigationControllerKG = [[UINavigationController alloc]initWithRootViewController:kgTableViewController];
    _navigationControllerKG.title = NSLocalizedString(@"魔王狀態", nil);
    _navigationControllerKG.tabBarItem.image = [UIImage imageNamed:@"kg"];
    _navigationControllerKG.navigationBarHidden = YES;
    //魔王的各領地資料
    supTableViewController = [[SUPTableViewController alloc]init];
    _navigationControllerSUP = [[UINavigationController alloc]initWithRootViewController:supTableViewController];
    _navigationControllerSUP.title = NSLocalizedString(@"補給據點", nil);
    _navigationControllerSUP.tabBarItem.image = [UIImage imageNamed:@"sup"];
    _navigationControllerSUP.navigationBarHidden = YES;
    //代收據點
    attTableViewController = [[ATTTableViewController alloc]init];
    _navigationControllerATT = [[UINavigationController alloc]initWithRootViewController:attTableViewController];
    _navigationControllerATT.title = NSLocalizedString(@"討伐令", nil);
    _navigationControllerATT.tabBarItem.image = [UIImage imageNamed:@"att"];
    _navigationControllerATT.navigationBarHidden = YES;
    //行前通知

    NSArray *nsaViewControllers = [[NSArray alloc]initWithObjects:_navigationControllerMS, _navigationControllerBlog, _navigationControllerKG, _navigationControllerSUP, _navigationControllerATT, nil];
    tabBarController = [[TabBarController alloc]init];
    [tabBarController setViewControllers:nsaViewControllers];    
    [self.window addSubview:tabBarController.view];
}

- (void)downloadFile{
    NSURL *url;
    if (_nssRSSURL == nil || [_nssRSSURL isEqual:@""] == YES) {
        url = [NSURL URLWithString:@"http://appytw.tumblr.com/rss"];
        NSLog(@"Got from url");
    } else {
        url = [NSURL URLWithString:_nssRSSURL];
        NSLog(@"Read from plist");
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([data length] > 0 && connectionError == nil) {
            _nssRSSContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [self writeToMyPlist];
//            NSLog(@"Content: %@", _nssRSSContent);
        } else {
            NSLog(@"Download url error: %@", connectionError);
        }
    }];
}

- (void)setParse {
    [Parse setApplicationId:PARSE_APPLICATION_ID
                  clientKey:PARSE_CLIENT_KEY];
//    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FBProfilePictureView class];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self readAllFromMyPlist];
    [self downloadFile];
    [self setParse];
    [self setMyViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self setNotification:application];
    _bShouldAlartSUPOFGPS = YES;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "tw.1129vday._129vday" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"_129vday" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"_129vday.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)setNotification:(UIApplication *)application
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    self.nssDeviceToken = [[[deviceToken description]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"receive deviceToken: %@", self.nssDeviceToken);
    if (self.nssDeviceToken == nil || [self.nssDeviceToken isEqualToString:@" "] == YES || [self.nssDeviceToken isEqualToString:@""] == YES) {
        self.nssDeviceToken = @"abcde";
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Remote notification error:%@", [error localizedDescription]);
}

//[[Plist

- (void)initMyPlist
{
    NSFileManager *nsfmPlistFileManager = [[NSFileManager alloc]init];
    NSString *nssPlistSrc = [[NSBundle mainBundle] pathForResource:@"UserData" ofType:@"plist"];
    _nssPlistDst = [NSString stringWithFormat:@"%@/Documents/UserData.plist", NSHomeDirectory()];
    if (! [nsfmPlistFileManager fileExistsAtPath:_nssPlistDst]) {
        [nsfmPlistFileManager copyItemAtPath:nssPlistSrc toPath:_nssPlistDst error:nil];
    }
}

- (void)writeToMyPlist
{
    if (_nssPlistDst == nil) {
        [self initMyPlist];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:_nssPlistDst];
    [nsmdPlistDictionary setValue:_nssDeviceToken forKey:PLIST_USER_DEVICE_TOKEN];
    [nsmdPlistDictionary setValue:_nssRSSURL forKey:PLIST_RSS_URL];
    [nsmdPlistDictionary writeToFile:_nssPlistDst atomically:YES];
}

- (void)readAllFromMyPlist {
    if (_nssPlistDst == nil) {
        [self initMyPlist];
    }
    NSMutableDictionary *nsmdPlistDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:_nssPlistDst];
    if (nsmdPlistDictionary != nil) {
        _nssDeviceToken = [nsmdPlistDictionary objectForKey:PLIST_USER_DEVICE_TOKEN];
        _nssRSSContent = [nsmdPlistDictionary objectForKey:PLIST_RSS_CONTENT];
        _nssRSSURL = [nsmdPlistDictionary objectForKey:PLIST_RSS_URL];
    }
}

//]]Plist

//[[Facebook

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

//]]Facebook
@end
