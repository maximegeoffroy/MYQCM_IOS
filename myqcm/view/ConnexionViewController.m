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

        
    };
    
    UserWebserviceAdapter* adapter = [UserWebserviceAdapter new];
    [adapter getUser:@"maxy" andCallback:callback];
}


@end
