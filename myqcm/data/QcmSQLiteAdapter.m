//
//  QcmSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 09/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmSQLiteAdapter.h"
#import "AppDelegate.h"
#import "CategoryQcmSQLiteAdapter.h"

@implementation QcmSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

/* Constructor of QcmSQLiteAdapter */
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
+ (NSString *)DB_QCM_TABLENAME{return @"Qcm";}
+ (NSString *)DB_QCM_NAME{return @"name";}
+ (NSString *)DB_QCM_STARTAT{return @"start_at";}
+ (NSString *)DB_QCM_ENDAT{return @"end_at";}
+ (NSString *)DB_QCM_DURATION{return @"duration";}
+ (NSString *)DB_QCM_IDSERVER{return @"idServer";}
+ (NSString *)DB_QCM_CREATEDAT{return @"created_at";}
+ (NSString *)DB_QCM_UPDATEDAT{return @"updated_at";}
+ (NSString *)DB_QCM_CATEGORYQCM{return @"categoryqcm";}

/* Insert qcm in database */
- (void)insert:(Qcm*)qcm{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QcmSQLiteAdapter.DB_QCM_TABLENAME inManagedObjectContext:context];
    
    
    //INSERT IN TABLE
    [managedObject setValue:qcm.name forKey:QcmSQLiteAdapter.DB_QCM_NAME];
    [managedObject setValue:qcm.start_at forKey:QcmSQLiteAdapter.DB_QCM_STARTAT];
    [managedObject setValue:qcm.end_at forKey:QcmSQLiteAdapter.DB_QCM_ENDAT];
    [managedObject setValue:[NSNumber numberWithInt:(qcm.duration)] forKey:QcmSQLiteAdapter.DB_QCM_DURATION];
    [managedObject setValue:[NSNumber numberWithInt:(qcm.idServer)] forKey:QcmSQLiteAdapter.DB_QCM_IDSERVER];
    [managedObject setValue:qcm.created_at forKey:QcmSQLiteAdapter.DB_QCM_CREATEDAT];
    [managedObject setValue:qcm.updated_at forKey:QcmSQLiteAdapter.DB_QCM_UPDATEDAT];
    
    if(qcm.categoryQcm!= nil){
        CategoryQcmSQLiteAdapter* categoryQcmAdapter =[CategoryQcmSQLiteAdapter new];
        NSManagedObject* categoryManagedObject = [categoryQcmAdapter getByName:qcm.categoryQcm];
        if(categoryManagedObject == nil){
            categoryManagedObject = [categoryQcmAdapter insert:qcm.categoryQcm];
        }
        [managedObject setValue:categoryManagedObject forKey:QcmSQLiteAdapter.DB_QCM_CATEGORYQCM];
    }
    
    [appDelegate saveContext];
}

/* Get all qcm in database */
- (NSArray*)getAll{
    NSArray* qcms = [NSArray new];
    
    //REQUEST GET DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table for request
    fetchRequest.entity = [NSEntityDescription entityForName:QcmSQLiteAdapter.DB_QCM_TABLENAME inManagedObjectContext:context];
    
    //get all city db object
    qcms = [context executeFetchRequest:fetchRequest error:nil];
    
    return qcms;
}

/* Get qcm by idServer in database */
- (Qcm *)getByIdServer:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QcmSQLiteAdapter.DB_QCM_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray* results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    Qcm* qcm = [self managedObjectToQcm:managedObject];
    
    return qcm;
}

/* Get qcm (managedObject) by idServer in database */
- (NSManagedObject *)getByIdServerManagedObject:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QcmSQLiteAdapter.DB_QCM_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray* results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    return managedObject;
}

/* Convert managedObject to Qcm */
- (Qcm *)managedObjectToQcm:(NSManagedObject *)managedObject{
    Qcm* qcm = nil;
    
    if(managedObject != nil){
        qcm = [Qcm new];
        qcm.name = [managedObject valueForKey:QcmSQLiteAdapter.DB_QCM_NAME];
        qcm.start_at = [managedObject valueForKey:QcmSQLiteAdapter.DB_QCM_STARTAT];
        qcm.end_at = [managedObject valueForKey:QcmSQLiteAdapter.DB_QCM_ENDAT];
        //qcm.duration = [managedObject valueForKey:QcmSQLiteAdapter.DB_QCM_DURATION];
        //qcm.idServer = [managedObject valueForKey:QcmSQLiteAdapter.DB_QCM_IDSERVER];
        qcm.created_at = [managedObject valueForKey:QcmSQLiteAdapter.DB_QCM_CREATEDAT];
        qcm.updated_at = [managedObject valueForKey:QcmSQLiteAdapter.DB_QCM_UPDATEDAT];
    }
    
    return qcm;
}

@end
