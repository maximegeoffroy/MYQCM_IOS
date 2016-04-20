//
//  QcmUserSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 16/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "QcmUser.h"

@interface QcmUserSQLiteAdapter : NSObject

+ (NSString*) DB_QCMUSER_TABLENAME;
+ (NSString*) DB_QCMUSER_NOTE;
+ (NSString*) DB_QCMUSER_ISDONE;
+ (NSString *)DB_QCMUSER_IDSERVER;

- (NSManagedObject*)insert:(QcmUser*)qcmuser;
- (NSArray*)getAll;
- (QcmUser*)getByIdServer:(int)idServer;
- (QcmUser*)managedObjectToQcmUser:(NSManagedObject *)managedObject;

@end
