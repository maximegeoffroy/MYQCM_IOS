//
//  GroupSQLiteAdapter.m
//  myqcm
//
//  Created by etudiant on 07/03/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "GroupSQLiteAdapter.h"
#import "AppDelegate.h"

@implementation GroupSQLiteAdapter
static AppDelegate *appDelegate;
static NSManagedObjectContext *context;

-(id) init {
    
    self = [super init];
    if(self)
    {
        appDelegate = [[UIApplication sharedApplication]delegate];
        context = appDelegate.managedObjectContext;
    }
    return self;
    
}

- (NSManagedObjectID*)insert:(Group*)group{
    //GET TABLE
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Group" inManagedObjectContext:context];
    
    
    //INSERT IN TABLE
    [managedObject setValue:group.name forKey:@"name"];
    [managedObject setValue:group.created_at forKey:@"created_at"];
    [managedObject setValue:group.updated_at forKey:@"updated_at"];
    
    [appDelegate saveContext];
    
    return managedObject.objectID;
}

@end
