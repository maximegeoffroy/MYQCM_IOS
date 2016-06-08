//
//  QuestionViewController.m
//  myqcm
//
//  Created by etudiant on 20/04/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QuestionViewController.h"
#import "Question.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController
@synthesize qcm;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self->_labelQuestionName.text = self->qcm.name;
    
    NSDate* date = [NSDate new];
    
    Question* q = [Question new];
    q.content = @"Quelle est ton sport préféré ?";
    q.idServer = 1;
    q.created_at = date;
    q.updated_at = date;
    
    Question* q1 = [Question new];
    q1.content = @"Quelle est ta matière préférée ?";
    q1.idServer = 2;
    q1.created_at = date;
    q1.updated_at = date;
    
    Question* q2 = [Question new];
    q2.content = @"Quelle est ta ville préférée ?";
    q2.idServer = 3;
    q2.created_at = date;
    q2.updated_at = date;
    
    NSMutableArray* questionList = [NSMutableArray new];
    
    [questionList addObject:q];
    [questionList addObject:q1];
    [questionList addObject:q2];
    
    float y= 230.00;
    
    for(Question* q in questionList){
        UISwitch *mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(130, y, 0, 0)];
        
        [mySwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:mySwitch];
        
        y = y + 50.0;
    }
}

- (void)changeSwitch:(id)sender{
    
    if([sender isOn]){
        NSLog(@"Switch is ON");
    } else{
        NSLog(@"Switch is OFF");
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
@end
