//
//  CategoryQcmSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 08/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryQcm.h"
#import <CoreData/CoreData.h>

@interface CategoryQcmSQLiteAdapter : NSObject

+ (NSString*) DB_CATEGORYQCM_TABLENAME;
+ (NSString*) DB_CATEGORYQCM_NAME;
+ (NSString*) DB_CATEGORYQCM_IDSERVER;
+ (NSString*) DB_CATEGORYQCM_DATECREATED;
+ (NSString*) DB_CATEGORYQCM_DATEUPDATED;

- (NSManagedObject*)insert:(CategoryQcm *)categoryQcm;
- (NSArray*)getAll;
- (NSManagedObject *)getByName:(CategoryQcm *)categoryQcm;
- (CategoryQcm *)getByIdServer:(int)idServer;

@end
