//
//  QcmSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 09/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Qcm.h"

@interface QcmSQLiteAdapter : NSObject

+ (NSString *)DB_QCM_TABLENAME;
+ (NSString *)DB_QCM_NAME;
+ (NSString *)DB_QCM_STARTAT;
+ (NSString *)DB_QCM_ENDAT;
+ (NSString *)DB_QCM_DURATION;
+ (NSString *)DB_QCM_CREATEDAT;
+ (NSString *)DB_QCM_UPDATEDAT;
+ (NSString *)DB_QCM_CATEGORYQCM;

- (void)insert:(Qcm*)qcm;
- (NSArray*)getAll;

@end
