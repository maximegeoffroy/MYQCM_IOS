//
//  QcmTableViewController.h
//  myqcm
//
//  Created by etudiant on 19/04/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryQcm.h"

@interface QcmTableViewController : UITableViewController

@property (nonatomic, strong) CategoryQcm* category;
@property (nonatomic, strong) NSArray* qcms;

@end
