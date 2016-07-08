//
//  AnswerSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 16/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Answer.h"

@interface AnswerSQLiteAdapter : NSObject

+ (NSString*) DB_ANSWER_TABLENAME;
+ (NSString*) DB_ANSWER_CONTENT;
+ (NSString *)DB_ANSWER_IDSERVER;
+ (NSString*) DB_ANSWER_POINT;
+ (NSString*) DB_ANSWER_ISVALID;
+ (NSString*) DB_ANSWER_CREATEDAT;
+ (NSString*) DB_ANSWER_UPDATEDAT;


- (NSManagedObject*)insert:(Answer*)answer;
- (NSManagedObject *)getByIdServer:(int)idServer;
- (Answer *)managedObjectToAnswer:(NSManagedObject *)managedObject;

@end
