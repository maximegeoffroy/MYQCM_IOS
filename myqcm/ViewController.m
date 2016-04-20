//
//  ViewController.m
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "ViewController.h"
#import "UserWebserviceAdapter.h"
#import "User.h"
#import "QcmUser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    void (^callback)(User*) = ^(User* user) {
        //NSLog(@"Username: %@, email: %@, password: %@",user.username, user.email,user.password);
        
        for(NSDictionary* qcmUser in user.qcmUsers){
            QcmUser* newQcmUser = [QcmUser new];
            newQcmUser.idServer = [[qcmUser objectForKey:@"id"] intValue];
            newQcmUser.is_done = [[qcmUser objectForKey:@"is_done"] boolValue];
            newQcmUser.qcm = [qcmUser objectForKey:@"qcm"];
            
            NSLog(@"idServer: %d", newQcmUser.idServer);
            
        }
        
    };
    
    UserWebserviceAdapter* adapter = [UserWebserviceAdapter new];
    [adapter getUser:@"maxy" andCallback:callback];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
