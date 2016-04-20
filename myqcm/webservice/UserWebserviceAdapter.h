//
//  UserWebserviceAdapter.h
//  myqcm
//
//  Created by etudiant on 22/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserWebserviceAdapter : NSObject

+ (NSString *)JSON_USER;
+ (NSString *)JSON_USER_USERNAME;
+ (NSString *)JSON_USER_EMAIL;
+ (NSString *)JSON_USER_PASSWORD;
+ (NSString *)JSON_USER_CREATEDAT;
+ (NSString *)JSON_USER_UPDATEDAT;
+ (NSString *)JSON_USER_USERQCMS;

- (void)getUser:(NSString*) name andCallback:(void (^)(User *))callback;

@end
