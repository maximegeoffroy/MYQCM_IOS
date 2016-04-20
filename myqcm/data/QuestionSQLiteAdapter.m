//
//  QuestionSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 16/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionSQLiteAdapter.h"
#import "AppDelegate.h"

@implementation QuestionSQLiteAdapter
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

+ (NSString*) DB_QUESTION_TABLENAME{return @"Question";}
+ (NSString*) DB_QUESTION_CONTENT{return @"content";}
+ (NSString *)DB_QUESTION_IDSERVER{return @"idServer";}
+ (NSString*) DB_QUESTION_CREATEDAT{return @"created_at";}
+ (NSString*) DB_QUESTION_UPDATEDAT{return @"updated_at";}

- (NSManagedObject*)insert:(Question*)question{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:QuestionSQLiteAdapter.DB_QUESTION_TABLENAME inManagedObjectContext:context];
    
    
    //INSERT IN TABLE
    [managedObject setValue:question.content forKey:QuestionSQLiteAdapter.DB_QUESTION_CONTENT];
    [managedObject setValue:[NSNumber numberWithInt:(question.idServer)] forKey:QuestionSQLiteAdapter.DB_QUESTION_IDSERVER];
    [managedObject setValue:question.created_at forKey:QuestionSQLiteAdapter.DB_QUESTION_CREATEDAT];
    [managedObject setValue:question.updated_at forKey:QuestionSQLiteAdapter.DB_QUESTION_UPDATEDAT];
    
    [appDelegate saveContext];
    
    return managedObject;
}

- (NSArray*)getAll{
    NSArray* questions = [NSArray new];
    
    //REQUEST GET DB
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    //get table for request
    fetchRequest.entity = [NSEntityDescription entityForName:QuestionSQLiteAdapter.DB_QUESTION_TABLENAME inManagedObjectContext:context];
    
    //get all city db object
    questions = [context executeFetchRequest:fetchRequest error:nil];
    
    return questions;
}

- (Question *)getByIdServer:(int)idServer{
    
    //create a filter
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"idServer = %d", idServer];
    
    //create a query
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:QuestionSQLiteAdapter.DB_QUESTION_TABLENAME];
    
    //set the filter on the query
    request.predicate = predicate;
    
    NSArray* results = [context executeFetchRequest:request error:nil];
    
    NSManagedObject* managedObject = nil;
    if (results.count > 0) {
        managedObject = [results objectAtIndex:0];
    }
    
    Question* question = [self managedObjectToQuestion:managedObject];
    
    return question;
}

- (Question *)managedObjectToQuestion:(NSManagedObject *)managedObject{
    Question* question = nil;
    
    if(managedObject != nil){
        question = [Question new];
        question.content = [managedObject valueForKey:QuestionSQLiteAdapter.DB_QUESTION_CONTENT];
        //question.idServer = [managedObject valueForKey:QuestionSQLiteAdapter.DB_QUESTION_IDSERVER];
        question.created_at = [managedObject valueForKey:QuestionSQLiteAdapter.DB_QUESTION_CREATEDAT];
        question.updated_at = [managedObject valueForKey:QuestionSQLiteAdapter.DB_QUESTION_UPDATEDAT];
    }
    
    return question;
}


@end
