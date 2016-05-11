//
//  AnswerSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 16/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "AnswerSQLiteAdapter.h"
#import "AppDelegate.h"

@implementation AnswerSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

/* Constructor of AnswerSQLiteAdapter */
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
+ (NSString*) DB_ANSWER_TABLENAME{return @"Answer";}
+ (NSString*) DB_ANSWER_CONTENT{return @"content";}
+ (NSString *)DB_ANSWER_IDSERVER{return @"idServer";}
+ (NSString*) DB_ANSWER_POINT{return @"point";}
+ (NSString*) DB_ANSWER_ISVALID{return @"is_valid";}
+ (NSString*) DB_ANSWER_CREATEDAT{return @"created_at";}
+ (NSString*) DB_ANSWER_UPDATEDAT{return @"updated_at";}

/* Insert answer in database */
- (NSManagedObject*)insert:(Answer*)answer{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:AnswerSQLiteAdapter.DB_ANSWER_TABLENAME inManagedObjectContext:context];
    
    
    //INSERT IN TABLE
    [managedObject setValue:answer.content forKey:AnswerSQLiteAdapter.DB_ANSWER_CONTENT];
    [managedObject setValue:[NSNumber numberWithInt:(answer.idServer)] forKey:AnswerSQLiteAdapter.DB_ANSWER_IDSERVER];
    [managedObject setValue:[NSNumber numberWithInt:(answer.point)] forKey:AnswerSQLiteAdapter.DB_ANSWER_POINT];
    //[managedObject setValue:answer.is_valid forKey:AnswerSQLiteAdapter.DB_ANSWER_ISVALID];
    [managedObject setValue:answer.created_at forKey:AnswerSQLiteAdapter.DB_ANSWER_CREATEDAT];
    [managedObject setValue:answer.updated_at forKey:AnswerSQLiteAdapter.DB_ANSWER_UPDATEDAT];
    
    [appDelegate saveContext];
    
    return managedObject;
}

/* Get answer by idServer in database */
- (Answer *)getByIdServer:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:AnswerSQLiteAdapter.DB_ANSWER_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray* results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    Answer* answer = [self managedObjectToAnswer:managedObject];
    
    return answer;
}

/* Convert managedObject to answer */
- (Answer *)managedObjectToAnswer:(NSManagedObject *)managedObject{
    Answer* answer = nil;
    
    if(managedObject != nil){
        answer = [Answer new];
        answer.content = [managedObject valueForKey:AnswerSQLiteAdapter.DB_ANSWER_CONTENT];
        //answer.idServer = [managedObject valueForKey:AnswerSQLiteAdapter.DB_ANSWER_IDSERVER];
        //answer.point = [managedObject valueForKey:AnswerSQLiteAdapter.DB_ANSWER_POINT];
        //answer.is_valid = [managedObject valueForKey:AnswerSQLiteAdapter.DB_ANSWER_ISVALID];
        answer.created_at = [managedObject valueForKey:AnswerSQLiteAdapter.DB_ANSWER_CREATEDAT];
        answer.updated_at = [managedObject valueForKey:AnswerSQLiteAdapter.DB_ANSWER_UPDATEDAT];
    }
    
    return answer;
}


@end
