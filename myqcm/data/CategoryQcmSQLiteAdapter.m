//
//  CategoryQcmSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategoryQcmSQLiteAdapter.h"
#import "CategoryQcm.h"
#import "Qcm.h"
#import "AppDelegate.h"

@implementation CategoryQcmSQLiteAdapter
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

+ (NSString *)DB_CATEGORYQCM_TABLENAME{return @"CategoryQcm";}
+ (NSString *)DB_CATEGORYQCM_NAME{return @"name";}
+ (NSString *)DB_CATEGORYQCM_IDSERVER{return @"idServer";}
+ (NSString *)DB_CATEGORYQCM_DATECREATED{return @"created_at";}
+ (NSString *)DB_CATEGORYQCM_DATEUPDATED{return @"updated_at";}

- (NSManagedObject*)insert:(CategoryQcm *)categoryQcm{
    //GET TABLE
    NSManagedObject* managedObject = [NSEntityDescription insertNewObjectForEntityForName:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_TABLENAME inManagedObjectContext:context];
    
    //INSERT IN TABLE
    [managedObject setValue:categoryQcm.name forKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_NAME];
    [managedObject setValue:[NSNumber numberWithInt:(categoryQcm.idServer)] forKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_IDSERVER];
    [managedObject setValue:categoryQcm.created_at forKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_DATECREATED];
    [managedObject setValue:categoryQcm.updated_at forKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_DATEUPDATED];
    
    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    NSArray* categoriesQcm = [NSArray new];
    
    //REQUEST GET DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table for request
    fetchRequest.entity = [NSEntityDescription entityForName:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_TABLENAME inManagedObjectContext:context];
    
    //get all city db object
    categoriesQcm = [context executeFetchRequest:fetchRequest error:nil];
    
    return categoriesQcm;
}

- (NSManagedObject *)getByName:(CategoryQcm *)categoryQcm{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name LIKE %@", categoryQcm.name];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    //execute the query
    return managedObject;
}

- (CategoryQcm *)getByIdServer:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    CategoryQcm* categoryQcm = [self managedObjectToCategoryQcm:managedObject];
    
    return categoryQcm;
}

- (CategoryQcm *)managedObjectToCategoryQcm:(NSManagedObject *)managedObject{
    CategoryQcm* categoryQcm = nil;
    
    if(managedObject != nil){
        categoryQcm = [CategoryQcm new];
        categoryQcm.name = [managedObject valueForKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_NAME];
        //categoryQcm.idServer = [managedObject valueForKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_IDSERVER];
        categoryQcm.created_at = [managedObject valueForKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_DATECREATED];
        categoryQcm.updated_at = [managedObject valueForKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_DATEUPDATED];
    }

    return categoryQcm;
}

@end
