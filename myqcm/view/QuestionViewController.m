//
//  QuestionViewController.m
//  myqcm
//
//  Created by etudiant on 20/04/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController
@synthesize checkBoxButton, qcm;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    checked = NO;
    
    for (int i = 1; i <= 5; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"unchecked.jpg"] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)checkButton:(id)sender {
    if (!checked) {
        [checkBoxButton setImage:[UIImage imageNamed:@"unchecked.jpg"] forState:UIControlStateNormal];
        checked = YES;
    }
    
    else if (checked){
        [checkBoxButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateNormal];
        checked = NO;
    }
}
@end
