//
//  Qcm.h
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryQcm.h"

@interface Qcm : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSDate* start_at;
@property (nonatomic, strong) NSDate* end_at;
@property (nonatomic) int duration;
@property (nonatomic) int idServer;
@property (nonatomic, strong) NSDate* created_at;
@property (nonatomic, strong) NSDate* updated_at;
@property (nonatomic) int idCategory;
@property (nonatomic, strong) CategoryQcm* categoryQcm;
@property (nonatomic, strong) NSArray* qcmUsers;
@property (nonatomic, strong) NSArray* questions;

@end
