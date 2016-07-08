//
//  UserWebserviceAdapter.m
//  myqcm
//
//  Created by etudiant on 22/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "UserWebserviceAdapter.h"
#import "AFNetworking.h"
#import "QcmUser.h"
#import "Question.h"
#import "Answer.h"
#import "QcmUserSQLiteAdapter.h"
#import "AnswerSQLiteAdapter.h"
#import "QuestionSQLiteAdapter.h"
#import "QcmSQLiteAdapter.h"
#import "CategoryQcmSQLiteAdapter.h"

@implementation UserWebserviceAdapter


+ (NSString *)JSON_USER{return @"user";}
+ (NSString *)JSON_USER_USERNAME{return @"username";}
+ (NSString *)JSON_USER_EMAIL{return @"email";}
+ (NSString *)JSON_USER_PASSWORD{return @"password";}
+ (NSString *)JSON_USER_CREATEDAT{return @"created_at";}
+ (NSString *)JSON_USER_UPDATEDAT{return @"updated_at";}
+ (NSString *)JSON_USER_USERQCMS{return @"user_qcms";}

/* Get user in webservice database */
- (void)getUser:(NSString*)name andCallback:(void (^)(User *))callback{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    NSString* startUrl = @"http://172.20.10.2/myQCM/web/app_dev.php/api/users/";
    NSString* endUrl = name;
    
    NSString* url = [NSString stringWithFormat: @"%@%@", startUrl, endUrl];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //Callback
        User* user = [self extract:responseObject];
        callback(user);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR: %@", error);
        //Callback
        callback(nil);
    }];
}

/* Convert json to user */
- (User*)extract:(NSDictionary *)json{
    User* user = nil;
    
    if(json != nil){
        user = [User new];
        //NSArray* userArray = [json objectForKey:UserWebserviceAdapter.JSON_USER];
        NSDictionary* userDic = json;//[json objectForKey:UserWebserviceAdapter.JSON_USER];
        
        user.username = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_USERNAME];
        user.email = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_EMAIL];
        user.password = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_PASSWORD];
        user.created_at = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_CREATEDAT];
        user.updated_at = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_UPDATEDAT];
        user.qcmUsers = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_USERQCMS];
        
        
        QcmUserSQLiteAdapter* qcmUserSQLiteAdapter = [QcmUserSQLiteAdapter new];
        QcmSQLiteAdapter* qcmSQLiteAdapter = [QcmSQLiteAdapter new];
        //CategoryQcmSQLiteAdapter* categoryQcmSQLiteAdapter = [CategoryQcmSQLiteAdapter new];

        int countQcmsUserArray = [user.qcmUsers count];
        for (int i=0; i<countQcmsUserArray; i++) {
            QcmUser* qcmUser = [QcmUser new];
            NSDictionary* qcmUserDic = [user.qcmUsers objectAtIndex:i];
            
            qcmUser.idServer = [[qcmUserDic objectForKey:@"id"]intValue];
            qcmUser.is_done = [[qcmUserDic objectForKey:@"is_done"]boolValue];
            qcmUser.note = [[qcmUserDic objectForKey:@"note"]floatValue];
            
            //[qcmUserSQLiteAdapter insert:qcmUser];
            
            NSDictionary* qcmDic = [qcmUserDic objectForKey:@"qcm"];
            Qcm* qcm = [Qcm new];
            qcm.idServer = [[qcmDic objectForKey:@"id"]intValue];
            qcm.name = [qcmDic objectForKey:@"name"];
            qcm.end_at = [qcmDic objectForKey:@"end_date"];
            qcm.start_at = [qcmDic objectForKey:@"start_at"];
            qcm.created_at = [qcmDic objectForKey:@"created_at"];
            qcm.updated_at = [qcmDic objectForKey:@"updated_at"];
            qcm.duration = [[qcmDic objectForKey:@"duration"]intValue];
            
            
            NSDictionary* categoryQcmDic = [qcmDic objectForKey:@"category"];
            CategoryQcm* categoryQcm = [CategoryQcm new];
            categoryQcm.idServer = [[categoryQcmDic objectForKey:@"id"]intValue];
            categoryQcm.name = [categoryQcmDic objectForKey:@"name"];
            categoryQcm.created_at = [categoryQcmDic objectForKey:@"created_at"];
            categoryQcm.updated_at = [categoryQcmDic objectForKey:@"updated_at"];
            
            qcm.idCategory = categoryQcm.idServer;
            
            //[categoryQcmSQLiteAdapter insert:categoryQcm];
            
            qcm.categoryQcm = categoryQcm;
            
            [qcmSQLiteAdapter insert:qcm];
            
            QuestionSQLiteAdapter* questionSQLiteAdapter = [QuestionSQLiteAdapter new];
            AnswerSQLiteAdapter* answerSQLiteAdapter = [AnswerSQLiteAdapter new];
            
            NSArray* questionsArray = [qcmDic objectForKey:@"questions"];
            int countQuestionArray = [questionsArray count];
            for (int j=0; j<countQuestionArray; j++) {
                NSDictionary* questionDic = [questionsArray objectAtIndex:j];
                Question* question = [Question new];
                question.idServer = [[questionDic objectForKey:@"id"]intValue];
                question.content = [questionDic objectForKey:@"content"];
                question.created_at = [questionDic objectForKey:@"created_at"];
                question.updated_at = [questionDic objectForKey:@"updated_at"];
                
                [questionSQLiteAdapter insert:question];
                
                NSArray* answersArray = [questionDic objectForKey:@"answers"];
                int countAnswerArray = [answersArray count];
                for (int k=0; k<countAnswerArray; k++) {
                    NSDictionary* answerDic = [answersArray objectAtIndex:k];
                    Answer* answer = [Answer new];
                    answer.idServer = [[answerDic objectForKey:@"id"]intValue];
                    answer.content = [answerDic objectForKey:@"content"];
                    answer.point = [[answerDic objectForKey:@"point"]intValue];
                    answer.is_valid = [[answerDic objectForKey:@"is_valid"]boolValue];
                    answer.created_at = [answerDic objectForKey:@"created_at"];
                    answer.updated_at = [answerDic objectForKey:@"updated_at"];
                    
                    [answerSQLiteAdapter insert:answer];
                }
            }
        }
        //user.idServer = [[userDic objectForKey:WeatherWebserviceAdapter.JSON_ID] intValue];
    }
    
    return user;
}

@end
