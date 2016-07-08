//
//  Question.h
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Qcm.h"

@interface Question : NSObject

@property (nonatomic, strong) NSString* content;
@property (nonatomic) int idServer;
@property (nonatomic, strong) NSDate* created_at;
@property (nonatomic, strong) NSDate* updated_at;
@property (nonatomic, strong) Qcm* qcm;
@property (nonatomic, strong) NSArray* answers;

@end
