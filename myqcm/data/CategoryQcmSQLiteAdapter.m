//
//  CategoryQcmSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategoryQcmSQLiteAdapter.h"
#import "CategoryQcm.h"
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
+ (NSString*) DB_CATEGORY_QCM_DATECREATED{return @"created_at";}
+ (NSString*) DB_CATEGORY_QCM_DATEUPDATED{return @"updated_at";}

- (void)insert:(CategoryQcm *)categoryQcm{
    //GET TABLE
    NSManagedObject* managedObject = [NSEntityDescription insertNewObjectForEntityForName:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_TABLENAME inManagedObjectContext:context];
    
    //INSERT IN TABLE
    [managedObject setValue:categoryQcm.name forKey:CategoryQcmSQLiteAdapter.DB_CATEGORYQCM_NAME];
    [managedObject setValue:categoryQcm.created_at forKey:CategoryQcmSQLiteAdapter.DB_CATEGORY_QCM_DATECREATED];
    [managedObject setValue:categoryQcm.updated_at forKey:CategoryQcmSQLiteAdapter.DB_CATEGORY_QCM_DATEUPDATED];
    
    [appDelegate saveContext];
}

- (NSArray*)getAll{
    NSArray* categoriesQcm = [NSArray new];
    
    //REQUEST GET DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table for request
    fetchRequest.entity = [NSEntityDescription entityForName:@"CategoryQcm" inManagedObjectContext:context];
    
    //get all city db object
    categoriesQcm = [context executeFetchRequest:fetchRequest error:nil];
    
    return categoriesQcm;
}

@end
