//
//  UserSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "UserSQLiteAdapter.h"
#import "User.h"
#import "AppDelegate.h"

@implementation UserSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

+ (NSString *)DB_USER_TABLENAME{return @"User";}
+ (NSString *)DB_USER_USERNAME{return @"username";}
+ (NSString *)DB_USER_PASSWORD{return @"password";}
+ (NSString *)DB_USER_NAME{return @"name";}
+ (NSString *)DB_USER_FIRSTNAME{return @"firstname";}
+ (NSString *)DB_USER_EMAIL{return @"email";}
+ (NSString *)DB_USER_DATECREATED{return @"created_at";}
+ (NSString *)DB_USER_DATEUPDATED{return @"updated_at";}

- (void)insert:(User*)user{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:UserSQLiteAdapter.DB_USER_TABLENAME inManagedObjectContext:context];
    
    //INSERT IN TABLE
    [managedObject setValue:user.username forKey:UserSQLiteAdapter.DB_USER_USERNAME];
    [managedObject setValue:user.password forKey:UserSQLiteAdapter.DB_USER_PASSWORD];
    [managedObject setValue:user.name forKey:UserSQLiteAdapter.DB_USER_NAME];
    [managedObject setValue:user.firstname forKey:UserSQLiteAdapter.DB_USER_FIRSTNAME];
    [managedObject setValue:user.email forKey:UserSQLiteAdapter.DB_USER_EMAIL];
    [managedObject setValue:user.created_at forKey:UserSQLiteAdapter.DB_USER_DATECREATED];
    [managedObject setValue:user.updated_at forKey:UserSQLiteAdapter.DB_USER_DATEUPDATED];
    
    [appDelegate saveContext];
}
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

- (User *)managedObjectToUser:(NSManagedObject *)managedObject{
    User* user = nil;
    
    if(managedObject != nil){
        user = [User new];
        user.username = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_USERNAME];
        user.password = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_PASSWORD];
        user.name = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_NAME];
        user.firstname = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_FIRSTNAME];
        user.email = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_EMAIL];
        user.created_at = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_DATECREATED];
        user.updated_at = [managedObject valueForKey:UserSQLiteAdapter.DB_USER_DATEUPDATED];
    }
    return user;
}

@end
