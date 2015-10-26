//
//  AppDelegate.m
//  Unit-2-Journal
//
//  Created by Jamaal Sedayao on 10/9/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginButton.h>
#import <Parse/Parse.h>
#import "iTunesSearchResult.h"
#import "JournalPost.h"

//for custom tab bar:
#import "YALTabBarItem.h" //model
#import "YALFoldingTabBarController.h" //controller
#import "YALAnimatingTabBarConstants.h" //helpers

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];;
    
    [Parse setApplicationId:@"huGlqbY2KVINDuFfqju1fN0eB2QVANcqqHP0NVpY"
                  clientKey:@"aohlSqEhCwaXtZbji5us0j97GNzemWqq3m3EJqwG"];
    
    //registering subclases to parse
    [iTunesSearchResult registerSubclass];
    [JournalPost registerSubclass];
    
    [self setupYALTabBarController]; // setup tab bar controller
    
    return YES;
}

#pragma mark - setup custom tab bar

- (void)setupYALTabBarController {
    YALFoldingTabBarController *tabBarController = (YALFoldingTabBarController *) self.window.rootViewController;
    
    //prepare leftBarItems
    YALTabBarItem *item1 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"idea"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    
    YALTabBarItem *item2 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"add"] // we can add hidden left/right buttons here
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    tabBarController.leftBarItems = @[item1, item2];
    
    //prepare rightBarItems
    YALTabBarItem *item3 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"star"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    
    YALTabBarItem *item4 = [[YALTabBarItem alloc] initWithItemImage:[UIImage imageNamed:@"settings"]
                                                      leftItemImage:nil
                                                     rightItemImage:nil];
    
    tabBarController.rightBarItems = @[item3, item4];
    
    tabBarController.centerButtonImage = [UIImage imageNamed:@"plus"];
    
    tabBarController.selectedIndex = 2;
    
    //customize tabBarView
    tabBarController.tabBarView.extraTabBarItemHeight = YALExtraTabBarItemsDefaultHeight;
    tabBarController.tabBarView.offsetForExtraTabBarItems = YALForExtraTabBarItemsDefaultOffset;
    tabBarController.tabBarView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
    tabBarController.tabBarView.tabBarColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    tabBarController.tabBarViewHeight = YALTabBarViewDefaultHeight;
    tabBarController.tabBarView.tabBarViewEdgeInsets = YALTabBarViewHDefaultEdgeInsets;
    tabBarController.tabBarView.tabBarItemsEdgeInsets = YALTabBarViewItemsDefaultEdgeInsets;
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

    [FBSDKAppEvents activateApp];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
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
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.jamaalsedayao.Unit_2_Journal" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Unit_2_Journal" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Unit_2_Journal.sqlite"];
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
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
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

@end
