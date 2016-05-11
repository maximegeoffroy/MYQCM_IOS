//
//  GroupSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "GroupSQLiteAdapter.h"
#import "AppDelegate.h"

@implementation GroupSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

/* Constructor of GroupSQLiteAdapter */
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
+ (NSString *)DB_GROUP_TABLENAME{return @"Group";}
+ (NSString *)DB_GROUP_NAME{return @"name";}
+ (NSString *)DB_GROUP_IDSERVER{return @"idServer";}
+ (NSString *)DB_GROUP_CREATEDAT{return @"created_at";}
+ (NSString *)DB_GROUP_UPDATEDAT{return @"updated_at";}

/* Insert group in database */
- (NSManagedObject*)insert:(Group*)group{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:GroupSQLiteAdapter.DB_GROUP_TABLENAME inManagedObjectContext:context];
    
    
    //INSERT IN TABLE
    [managedObject setValue:group.name forKey:GroupSQLiteAdapter.DB_GROUP_NAME];
    [managedObject setValue:[NSNumber numberWithInt:(group.idServer)] forKey:GroupSQLiteAdapter.DB_GROUP_IDSERVER];
    [managedObject setValue:group.created_at forKey:GroupSQLiteAdapter.DB_GROUP_CREATEDAT];
    [managedObject setValue:group.updated_at forKey:GroupSQLiteAdapter.DB_GROUP_UPDATEDAT];
    
    [appDelegate saveContext];
    
    return managedObject;
}

/* Get group by name */
- (NSManagedObject *)getByName:(Group *)group{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name LIKE %@", group.name];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:GroupSQLiteAdapter.DB_GROUP_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    return managedObject;
}

/* Get group by idServer */
- (Group *)getByIdServer:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:GroupSQLiteAdapter.DB_GROUP_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    Group* group = [self managedObjectToGroup:managedObject];
    
    return group;
}

/* Convert managedObject to Group */
- (Group*)managedObjectToGroup:(NSManagedObject *)managedObject{
    Group* group = nil;
    
    if(managedObject != nil){
        group = [Group new];
        group.name = [managedObject valueForKey:GroupSQLiteAdapter.DB_GROUP_NAME];
        group.created_at = [managedObject valueForKey:GroupSQLiteAdapter.DB_GROUP_CREATEDAT];
        group.updated_at = [managedObject valueForKey:GroupSQLiteAdapter.DB_GROUP_UPDATEDAT];
    }
    return group;
}

@end
