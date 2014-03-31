//
//  AllListsViewController.m
//  iWanna
//
//  Created by Cionnat Breathnach on 08/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "AllListsViewController.h"
#import "iWannaCategory.h"
#import "iWannaViewController.h"
#import "iWannaItem.h"
//#import "ListDetailViewController.h"

@interface AllListsViewController ()

@end


@implementation AllListsViewController{
}
@synthesize dataModel;



- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.dataModel = [[DataModel alloc]init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataModel.categorys count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    iWannaCategory *checklist = [self.dataModel.categorys objectAtIndex:indexPath.row];
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.imageView.image = [UIImage imageNamed:checklist.iconName];
    int count = [checklist countUncheckedItems];
    
    //setting category subtitle to number of items
    if ([checklist.items count] == 0) {
        cell.detailTextLabel.text = @"(No Items)";
    }
    else if (count == 0) {
            cell.detailTextLabel.text = @"All Done!";
        }
    else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining", count];
        }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];//writes row tapped to user defaults for reloadign current cell
    
    iWannaCategory *category = [self.dataModel.categorys objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowIWannaList" sender:category];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowIWannaList"]){ //Show items segue
        iWannaViewController *controller = segue.destinationViewController;
        controller.category = sender; //sending the name of category clicked/tapped to VC for use in title
    }else if ([segue.identifier isEqualToString:@"AddChecklist"]) { //add category
        UINavigationController *navigationController = segue.destinationViewController;
        ListDetailViewController *controller = (ListDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.checklistToEdit = nil;
    }


}
/**
 
 Editing categorys
 **/
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    ListDetailViewController *controller = (ListDetailViewController *) navigationController.topViewController;
    controller.delegate = self;
    iWannaCategory *checklist = [self.dataModel.categorys objectAtIndex:indexPath.row];
    controller.checklistToEdit = checklist;
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

-(void)listDetailViewControllerDidCancel:(ListDetailViewController *) controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 Add checklist
 **/
-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(iWannaCategory *)checklist
{
    [self.dataModel.categorys addObject:checklist];
    [self.dataModel sortChecklists];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 Edit checklists
 **/
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(iWannaCategory *)checklist
{
    [self.dataModel sortChecklists]; //sorted alphabetically
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 Delete category
 **/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataModel.categorys removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}
/**
 
 **/
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self) {
        [self.dataModel setIndexOfSelectedChecklist:-1]; //if back pressed set index to -1 in userdefaults
    }
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    int index = [self.dataModel indexOfSelectedChecklist];
    if (index >= 0 && index < [self.dataModel.categorys count]) {
        iWannaCategory *checklist = [self.dataModel.categorys objectAtIndex:index];
        [self performSegueWithIdentifier:@"ShowIWannaList" sender:checklist];
    }
}

@end
