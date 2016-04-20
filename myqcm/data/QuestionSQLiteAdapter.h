//
//  QuestionSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 16/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Question.h"

@interface QuestionSQLiteAdapter : NSObject

+ (NSString*) DB_QUESTION_TABLENAME;
+ (NSString*) DB_QUESTION_CONTENT;
+ (NSString *)DB_QUESTION_IDSERVER;
+ (NSString*) DB_QUESTION_CREATEDAT;
+ (NSString*) DB_QUESTION_UPDATEDAT;

- (NSManagedObject*)insert:(Question*)question;
- (NSArray*)getAll;
- (Question *)getByIdServer:(int)idServer;
- (Question *)managedObjectToQuestion:(NSManagedObject *)managedObject;

@end
