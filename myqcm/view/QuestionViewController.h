//
//  QuestionViewController.h
//  myqcm
//
//  Created by etudiant on 20/04/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Qcm.h"

@interface QuestionViewController : UIViewController{
    BOOL checked;
}

@property (nonatomic, strong) Qcm *qcm;
@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton;
- (IBAction)checkButton:(id)sender;

@end
