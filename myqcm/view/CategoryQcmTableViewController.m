//
//  CategoryQcmTableViewController.m
//  myqcm
//
//  Created by etudiant on 19/04/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "CategoryQcmTableViewController.h"
#import "CategoryQcmTableViewCell.h"
#import "QcmTableViewController.h"
#import "CategoryQcm.h"
#import "CategoryQcmSQLiteAdapter.h"

@interface CategoryQcmTableViewController (){
    NSManagedObject* selectedCategory;
}
@end

@implementation CategoryQcmTableViewController
@synthesize categoriesQcm;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CategoryQcmSQLiteAdapter* adapter = [CategoryQcmSQLiteAdapter new];
    
    NSArray* array = [adapter getAll];
    
    self.categoriesQcm = array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.categoriesQcm.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"categoryQcmCell";
    
    CategoryQcmTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Crée et réutilise la cellule à chaque fois
    if (cell == nil) {
        cell = [[CategoryQcmTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    CategoryQcm* category = [self.categoriesQcm objectAtIndex:indexPath.row];
    
    cell.labelCategoryName.text = category.name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QcmTableViewController *qtvc = segue.destinationViewController;
    
    //NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    //NSInteger position = index.row;
    
    NSIndexPath *indexCell = [self.tableView indexPathForCell:sender];
    NSInteger positionCell = indexCell.row;
    
    self->selectedCategory = [self.categoriesQcm objectAtIndex:positionCell];
    qtvc.category = self->selectedCategory;
}

@end
