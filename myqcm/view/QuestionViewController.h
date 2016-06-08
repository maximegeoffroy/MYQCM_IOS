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
}

@property (weak, nonatomic) IBOutlet UILabel *labelQuestionName;
@property (nonatomic, strong) Qcm *qcm;

@end
