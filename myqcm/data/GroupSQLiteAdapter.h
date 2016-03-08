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

- (NSManagedObjectID*)insert:(Group*)group;

@end
