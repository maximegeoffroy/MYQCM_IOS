//
//  UserSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "UserSQLiteAdapter.h"
#import "User.h"
#import "GroupSQLiteAdapter.h"
#import "AppDelegate.h"

@implementation UserSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

/* Constructor of UserSQLiteAdapter */
-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

/* Constants */
+ (NSString *)DB_USER_TABLENAME{return @"User";}
+ (NSString *)DB_USER_USERNAME{return @"username";}
+ (NSString *)DB_USER_PASSWORD{return @"password";}
+ (NSString *)DB_USER_NAME{return @"name";}
+ (NSString *)DB_USER_FIRSTNAME{return @"firstname";}
+ (NSString *)DB_USER_EMAIL{return @"email";}
+ (NSString *)DB_USER_IDSERVER{return @"idServer";}
+ (NSString *)DB_USER_DATECREATED{return @"created_at";}
+ (NSString *)DB_USER_DATEUPDATED{return @"updated_at";}
+ (NSString *)DB_USER_GROUP{return @"group";}

/* Insert user in database */
- (void)insert:(User*)user{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:UserSQLiteAdapter.DB_USER_TABLENAME inManagedObjectContext:context];
    
    //INSERT IN TABLE
    [managedObject setValue:user.username forKey:UserSQLiteAdapter.DB_USER_USERNAME];
    [managedObject setValue:user.password forKey:UserSQLiteAdapter.DB_USER_PASSWORD];
    [managedObject setValue:user.name forKey:UserSQLiteAdapter.DB_USER_NAME];
    [managedObject setValue:user.firstname forKey:UserSQLiteAdapter.DB_USER_FIRSTNAME];
    [managedObject setValue:user.email forKey:UserSQLiteAdapter.DB_USER_EMAIL];
    [managedObject setValue:[NSNumber numberWithInt:(user.idServer)] forKey:UserSQLiteAdapter.DB_USER_IDSERVER];
    [managedObject setValue:user.created_at forKey:UserSQLiteAdapter.DB_USER_DATECREATED];
    [managedObject setValue:user.updated_at forKey:UserSQLiteAdapter.DB_USER_DATEUPDATED];
    
    if(user.group != nil){
        GroupSQLiteAdapter* groupAdapter = [GroupSQLiteAdapter new];
        NSManagedObject* groupManagedObject = [groupAdapter getByName:user.group];
        if(groupManagedObject == nil){
            groupManagedObject = [groupAdapter insert:user.group];
        }
        [managedObject setValue:groupManagedObject forKey:UserSQLiteAdapter.DB_USER_GROUP];
    }
    
    [appDelegate saveContext];
}

/* Get user by username in database */
- (User *)getByUsername:(NSString *)username{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"username LIKE %@", username];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:UserSQLiteAdapter.DB_USER_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    //execute the query
    NSManagedObject* managedObject = [[context executeFetchRequest:request error:nil]objectAtIndex:0];
    
    User* user = [self managedObjectToUser:managedObject];
    
    return user;
}

/* Get user by idServer in database */
- (User *)getByIdServer:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:UserSQLiteAdapter.DB_USER_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    User* user = [self managedObjectToUser:managedObject];
    
    return user;
}

/* Get user (managedObject) by username in database */
- (NSManagedObject *)getByIdServerManagedObject:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:UserSQLiteAdapter.DB_USER_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    return managedObject;
}

/* Convert managedObject to User */
- (User *)managedObjectToUser:(NSManagedObject *)managedObject{
    User* user = nil;
    
    if(managedObject != nil){
        user = [User new];
        user.username = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_USERNAME];
        user.password = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_PASSWORD];
        user.name = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_NAME];
        user.firstname = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_FIRSTNAME];
        user.email = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_EMAIL];
        //user.idServer = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_IDSERVER];
        user.created_at = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_DATECREATED];
        user.updated_at = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_DATEUPDATED];
    }
    return user;
}

@end
