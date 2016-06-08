//
//  ConnexionViewController.m
//  myqcm
//
//  Created by etudiant on 21/05/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "ConnexionViewController.h"
#import "QcmUser.h"
#import "UserWebserviceAdapter.h"

@interface ConnexionViewController ()

@end

@implementation ConnexionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    void (^callback)(User*) = ^(User* user) {
        NSLog(@"Username: %@, email: %@, password: %@",user.username, user.email,user.password);
        
//        for(NSDictionary* qcmUser in user.qcmUsers){
//            QcmUser* newQcmUser = [QcmUser new];
//            newQcmUser.idServer = [[qcmUser objectForKey:@"id"] intValue];
//            newQcmUser.is_done = [[qcmUser objectForKey:@"is_done"] boolValue];
//            newQcmUser.qcm = [qcmUser objectForKey:@"qcm"];
//            
//            NSLog(@"Name qcm: %@", newQcmUser.qcm.name);
//            
//        }
        
    };
    
    UserWebserviceAdapter* adapter = [UserWebserviceAdapter new];
    [adapter getUser:@"maxy" andCallback:callback];
}


@end
