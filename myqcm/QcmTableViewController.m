//
//  QcmTableViewController.m
//  myqcm
//
//  Created by etudiant on 19/04/2016.
//  Copyright © 2016 iia. All rights reserved.
//

#import "QcmTableViewController.h"
#import "QcmTableViewCell.h"
#import "Qcm.h"
#import "QuestionViewController.h"
#import "QcmSQLiteAdapter.h"

@interface QcmTableViewController (){
    Qcm* selectedQcm;
}

@end

@implementation QcmTableViewController
@synthesize qcms;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QcmSQLiteAdapter* adapter = [QcmSQLiteAdapter new];
    
    int idServer = self.category.idServer;
    
    NSArray* array = [adapter getAllByCategoryId:self.category.idServer];
    
    Qcm* q = [adapter getByIdServer:1];
    
    //NSArray* array = [adapter getAll];
    
    for (int i=0; i<sizeof(array); i++) {
        //NSLog(@"ID CAT : %d", ((Qcm*)[array objectAtIndex:i]).categoryQcm.idServer);
    }
    
    self.qcms = array;
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
    return self.qcms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"qcmCell";
    
    QcmTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //Crée et réutilise la cellule à chaque fois
    if (cell == nil) {
        cell = [[QcmTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Qcm* qcm = [self.qcms objectAtIndex:indexPath.row];
    
    cell.labelQcmName.text = qcm.name;
    
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
    QuestionViewController* qvc = segue.destinationViewController;
    
    NSIndexPath *indexCell = [self.tableView indexPathForCell:sender];
    NSInteger positionCell = indexCell.row;
    
    self->selectedQcm = [self.qcms objectAtIndex:positionCell];
    qvc.qcm = self->selectedQcm;
}


@end
