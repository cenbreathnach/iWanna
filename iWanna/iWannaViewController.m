//
//  ViewController.m
//  iWanna
//
//  Created by Cionnat Breathnach on 03/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "iWannaViewController.h"
#import "iWannaItem.h"
#import "iWannaCategory.h"
#import "DataModel.h"

@implementation iWannaViewController

@synthesize category;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.category.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.category.items count];//number of rows to display
    
}

-(void)updateDueToday{

}

-(void) configureCheckmarkForCell:(UITableViewCell *)cell withIWannaItem:(iWannaItem *)item{
    
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    UILabel *label2 = (UILabel *)[cell viewWithTag:1000];

    if(item.checked){
        label.text = @"√";
        
        //strike through text when completed
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:label2.text];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                value:@2
                                range:NSMakeRange(0, [attributeString length])];
        label2.attributedText = attributeString;
        if(item.shouldRemind){
            item.shouldRemind = NO; //dont remind
            [item scheduleNotification]; //cancel existing notification
        }
    }
    else{
        //reset checkmark and text to normal
        label.text = @"";
        label2.text = label2.text;
    }
}

/**
Setting text of cell.
 */

-(void) configureTextForCell:(UITableViewCell *)cell withIWannaItem:(iWannaItem *)item{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = [NSString stringWithFormat:@"%@", item.text];
}

/**
Table view delegate datesource
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    iWannaItem *item = [self.category.items objectAtIndex:indexPath.row];
    [self configureTextForCell:cell withIWannaItem:item];
    [self configureCheckmarkForCell:cell withIWannaItem:item];
    return cell;
}

/**
Row selected. Toggle checkmark
*/

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    iWannaItem *item = [self.category.items objectAtIndex:indexPath.row];
    [item toggleChecked];
    [self configureCheckmarkForCell:cell withIWannaItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
/**
Swipe left on cell to bring delete prompt
 */
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.category.items removeObjectAtIndex:indexPath.row]; //delete item from array
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic]; //delete from table view
}
/**
Cancel tapped
 */
-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{ //method implemented in delegate
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 Adding items
 */
-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(iWannaItem *)item{
    long newRowIndex = [self.category.items count];
    [self.category.items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];//updates table view with new row
   [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 Editing Items
 */

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(iWannaItem *)item{
    long index = [self.category.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withIWannaItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 Segues for add and edit item
 */

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"AddItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
    }else if ([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.itemToEdit = sender;

    }
}
/**
 Called when user taps accessory btn. Sends item at row to Edit item segue
*/
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    iWannaItem *item = [self.category.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
    
}

@end
