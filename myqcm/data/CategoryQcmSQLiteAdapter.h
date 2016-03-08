//
//  CategoryQcmSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryQcm.h"

@interface CategoryQcmSQLiteAdapter : NSObject

+ (NSString*) DB_CATEGORYQCM_TABLENAME;
+ (NSString*) DB_CATEGORYQCM_NAME;
+ (NSString*) DB_CATEGORYQCM_DATECREATED;
+ (NSString*) DB_CATEGORYQCM_DATEUPDATED;

- (void)insert:(CategoryQcm *)categoryQcm;
- (NSArray*)getAll;

@end
