//
//  QcmUserSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 16/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmUserSQLiteAdapter.h"
#import "AppDelegate.h"
#import "UserSQLiteAdapter.h"
#import "QcmSQLiteAdapter.h"


@implementation QcmUserSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

/* Constructor of QcmUserSQLiteAdapter */
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
+ (NSString*) DB_QCMUSER_TABLENAME{return @"QcmUser";}
+ (NSString*) DB_QCMUSER_USER{return @"user";}
+ (NSString*) DB_QCMUSER_QCM{return @"qcm";}
+ (NSString*) DB_QCMUSER_NOTE{return @"note";}
+ (NSString*) DB_QCMUSER_ISDONE{return @"is_done";}
+ (NSString *)DB_QCMUSER_IDSERVER{return @"idServer";}

/* Insert QcmUser in database */
- (NSManagedObject*)insert:(QcmUser*)qcmuser{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QcmUserSQLiteAdapter.DB_QCMUSER_TABLENAME inManagedObjectContext:context];
    
    
    //INSERT IN TABLE
    if(qcmuser.user != nil){
        UserSQLiteAdapter* userAdapter = [UserSQLiteAdapter new];
        NSManagedObject* userManagedObject = [userAdapter getByIdServerManagedObject:qcmuser.user.idServer];
        if(userManagedObject != nil){
            [managedObject setValue:userManagedObject forKey:QcmUserSQLiteAdapter.DB_QCMUSER_USER];
        }
    }
    if(qcmuser.qcm != nil){
        QcmSQLiteAdapter* qcmAdapter = [QcmSQLiteAdapter new];
        NSManagedObject* qcmManagedObject = [qcmAdapter getByIdServerManagedObject:qcmuser.qcm.idServer];
        if(qcmManagedObject != nil){
            [managedObject setValue:qcmManagedObject forKey:QcmUserSQLiteAdapter.DB_QCMUSER_QCM];
        }
    }
    [managedObject setValue:[NSNumber numberWithInt:(qcmuser.note)] forKey:QcmUserSQLiteAdapter.DB_QCMUSER_NOTE];
    //[managedObject setValue:qcmuser.is_done forKey:QcmUserSQLiteAdapter.DB_QCMUSER_ISDONE];
    [managedObject setValue:[NSNumber numberWithInt:(qcmuser.idServer)] forKey:QcmUserSQLiteAdapter.DB_QCMUSER_IDSERVER];
    
    [appDelegate saveContext];
    
    return managedObject;
}

/* Get all QcmUser in database */
- (NSArray*)getAll{
    NSArray* qcmuser = [NSArray new];
    
    //REQUEST GET DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table for request
    fetchRequest.entity = [NSEntityDescription entityForName:QcmUserSQLiteAdapter.DB_QCMUSER_TABLENAME inManagedObjectContext:context];
    
    //get all city db object
    qcmuser = [context executeFetchRequest:fetchRequest error:nil];
    
    return qcmuser;
}

/* Get QcmUser by idServer in database */
- (QcmUser *)getByIdServer:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QcmUserSQLiteAdapter.DB_QCMUSER_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray* results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    QcmUser* qcmuser;
    //= [self managedObjectToQcmUser:managedObject];
    
    return qcmuser;
}


@end
