//
//  QcmSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 09/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Qcm.h"

@interface QcmSQLiteAdapter : NSObject

+ (NSString *)DB_QCM_TABLENAME;
+ (NSString *)DB_QCM_NAME;
+ (NSString *)DB_QCM_STARTAT;
+ (NSString *)DB_QCM_ENDAT;
+ (NSString *)DB_QCM_DURATION;
+ (NSString *)DB_QCM_IDSERVER;
+ (NSString *)DB_QCM_CREATEDAT;
+ (NSString *)DB_QCM_UPDATEDAT;
+ (NSString *)DB_QCM_CATEGORYQCM;

- (NSManagedObject*)insert:(Qcm*)qcm;
- (NSArray*)getAll;
- (Qcm*)getByIdServer:(int)idServer;
- (NSArray *)getAllByCategoryId:(int)idCategory;
- (NSManagedObject *)getByIdServerManagedObject:(int)idServer;
- (Qcm *)managedObjectToQcm:(NSManagedObject *)managedObject;

@end
