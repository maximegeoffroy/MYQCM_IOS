//
//  Answer.h
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface Answer : NSObject

@property (nonatomic, strong) NSString* content;
@property (nonatomic) int point;
@property (nonatomic) Boolean is_valid;
@property (nonatomic) int idServer;
@property (nonatomic, strong) NSDate* created_at;
@property (nonatomic, strong) NSDate* updated_at;
@property (nonatomic, strong) Question* question;

@end
