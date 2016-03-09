//
//  GroupSQLiteAdapter.h
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <CoreData/CoreData.h>

@interface GroupSQLiteAdapter : NSObject

+ (NSString*) DB_GROUP_TABLENAME;
+ (NSString*) DB_GROUP_NAME;
+ (NSString*) DB_GROUP_CREATEDAT;
+ (NSString*) DB_GROUP_UPDATEDAT;


- (NSManagedObject*)insert:(Group*)group;
- (NSManagedObject *)getByName:(Group *)group;

@end
