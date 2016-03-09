//
//  AppDelegate.m
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "Qcm.h"
#import "UserSQLiteAdapter.h"
#import "GroupSQLiteAdapter.h"
#import "CategoryQcmSQLiteAdapter.h"
#import "QcmSQLiteAdapter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSDate* date = [NSDate new];
    
    
//    User* u = [User new];
//    u.username = @"test";
//    u.password = @"test";
//    u.name = @"Lepage";
//    u.firstname = @"Alexis";
//    u.email = @"lepage@hotmail.fr";
//    u.created_at = date;
//    u.updated_at = date;
//    
//    User* u1 = [User new];
//    u1.username = @"maxy";
//    u1.password = @"passw0rd";
//    u1.name = @"Geoffroy";
//    u1.firstname = @"Maxime";
//    u1.email = @"geoffroy@hotmail.fr";
//    u1.created_at = date;
//    u1.updated_at = date;
//    
//    Group* g = [Group new];
//    
//    g.name = @"CDSM";
//    g.created_at = date;
//    g.updated_at = date;
//    
//    u.group = g;
//    u1.group = g;
//    
//    UserSQLiteAdapter* useradapter = [UserSQLiteAdapter new];
//    [useradapter insert:u];
//    [useradapter insert:u1];
//    
//    //User* user = [useradapter getByUsername:@"maxy"];
//    
//    GroupSQLiteAdapter* groupadapter = [GroupSQLiteAdapter new];
//    
//    NSManagedObject* group = [groupadapter getByName:u.group];
//    
//    NSManagedObject* dbGroupUsers = [group valueForKey:@"users"];
//    
//    for(NSManagedObject* user in dbGroupUsers){
//        NSLog(@"User: %@", [user valueForKey:@"name"]);
//    }
    
    //NSLog(@"User name: %@",user.name);
    
    
    CategoryQcm* cat = [CategoryQcm new];
    cat.name = @"Developpement";
    cat.created_at = date;
    cat.updated_at = date;
    
    CategoryQcm* cat1 = [CategoryQcm new];
    cat1.name = @"Communication";
    cat1.created_at = date;
    cat1.updated_at = date;
    
//    CategoryQcm* cat2 = [CategoryQcm new];
//    cat2.name = @"Expression";
//    cat2.created_at = date;
//    cat2.updated_at = date;
    
      CategoryQcmSQLiteAdapter* catAdapter = [CategoryQcmSQLiteAdapter new];
//    [catAdapter insert:cat];
//    [catAdapter insert:cat1];
//    [catAdapter insert:cat2];
    
//    NSArray* cats = [catAdapter getAll];
//    
//    for (NSManagedObject* cat in cats) {
//        NSLog(@"Categorie: %@", [cat valueForKey:@"name"]);
//    }
    
    Qcm* qcm = [Qcm new];
    qcm.name = @"Qcm 1";
    qcm.start_at = date;
    qcm.end_at = date;
    qcm.duration = 60;
    qcm.created_at = date;
    qcm.updated_at = date;
    
    Qcm* qcm1 = [Qcm new];
    qcm1.name = @"Qcm 2";
    qcm1.start_at = date;
    qcm1.end_at = date;
    qcm1.duration = 30;
    qcm1.created_at = date;
    qcm1.updated_at = date;
    
    Qcm* qcm2 = [Qcm new];
    qcm2.name = @"Qcm 3";
    qcm2.start_at = date;
    qcm2.end_at = date;
    qcm2.duration = 80;
    qcm2.created_at = date;
    qcm2.updated_at = date;
    
    qcm.categoryQcm = cat;
    qcm1.categoryQcm = cat1;
    qcm2.categoryQcm = cat;
    
    QcmSQLiteAdapter* qcmAdapter = [QcmSQLiteAdapter new];
    [qcmAdapter insert:qcm];
    [qcmAdapter insert:qcm1];
    [qcmAdapter insert:qcm2];
    
    NSManagedObject* category = [catAdapter getByName:qcm.categoryQcm];
    
    NSManagedObject* dbCatUsers = [category valueForKey:@"qcms"];
    
    for(NSManagedObject* qcm in dbCatUsers){
        NSLog(@"Qcm: %@", [qcm valueForKey:@"name"]);
    }
    
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
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.iia.myqcm" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"myqcm" withExtension:@"momd"];
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
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"myqcm.sqlite"];
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
