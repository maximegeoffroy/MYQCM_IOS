//
//  UserWebserviceAdapter.m
//  myqcm
//
//  Created by etudiant on 22/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "UserWebserviceAdapter.h"
#import "AFNetworking.h"

@implementation UserWebserviceAdapter


+ (NSString *)JSON_USER{return @"user";}
+ (NSString *)JSON_USER_USERNAME{return @"username";}
+ (NSString *)JSON_USER_EMAIL{return @"email";}
+ (NSString *)JSON_USER_PASSWORD{return @"password";}
+ (NSString *)JSON_USER_CREATEDAT{return @"created_at";}
+ (NSString *)JSON_USER_UPDATEDAT{return @"updated_at";}
+ (NSString *)JSON_USER_USERQCMS{return @"user_qcms";}

- (void)getUser:(NSString*)name andCallback:(void (^)(User *))callback{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    NSString* startUrl = @"http://192.168.1.11/myQCM/web/app_dev.php/api/users/";
    NSString* endUrl = name;
    
    NSString* url = [NSString stringWithFormat: @"%@%@", startUrl, endUrl];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //Callback
        User* user = [self extract:responseObject];
        callback(user);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //Callback
        callback(nil);
    }];
}

- (User*)extract:(NSDictionary *)json{
    User* user = nil;
    
    if(json != nil){
        user = [User new];
        //NSArray* userArray = [json objectForKey:UserWebserviceAdapter.JSON_USER];
        NSDictionary* userDic = [json objectForKey:UserWebserviceAdapter.JSON_USER]; // il y en a qu'1 sinon il faut faire une boucle
        
        user.username = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_USERNAME];
        user.email = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_EMAIL];
        user.password = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_PASSWORD];
        user.created_at = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_CREATEDAT];
        user.updated_at = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_UPDATEDAT];
        user.qcmUsers = [userDic objectForKey:UserWebserviceAdapter.JSON_USER_USERQCMS];
        //user.idServer = [[userDic objectForKey:WeatherWebserviceAdapter.JSON_ID] intValue];
    }
    
    return user;
}

@end
