//
//  UserSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <CoreData/CoreData.h>

@interface UserSQLiteAdapter : NSObject

+ (NSString*) DB_USER_TABLENAME;
+ (NSString*) DB_USER_USERNAME;
+ (NSString*) DB_USER_PASSWORD;
+ (NSString*) DB_USER_NAME;
+ (NSString*) DB_USER_FIRSTNAME;
+ (NSString*) DB_USER_EMAIL;
+ (NSString*) DB_USER_DATECREATED;
+ (NSString*) DB_USER_DATEUPDATED;
+ (NSString*) DB_USER_GROUP;

- (void)insert:(User*)user;
- (User *)getByUsername:(NSString *)username;
- (User *)managedObjectToUser:(NSManagedObject *)managedObject;

@end
