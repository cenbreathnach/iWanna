//
//  itemDetailViewController.m
//  iWanna
//
//  Created by Cionnat Breathnach on 04/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "iWannaItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController{
    NSDate *dueDate;
}

@synthesize delegate;
@synthesize itemToEdit;
@synthesize switchControl;
@synthesize dueDateLabel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 Updating label on cell
 */
-(void)updateDueDateLabel{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if(self.itemToEdit != nil){
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
        self.switchControl.on = self.itemToEdit.shouldRemind;
        dueDate = self.itemToEdit.dueDate;
    }
    else{
        self.switchControl.on = NO;
        dueDate = [NSDate date];
    }
    [self updateDueDateLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder]; //makes keyboard pop up for editing text
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        return indexPath; //only can select row 3
    }
    else{
        return nil;

    }
    
}
#pragma mark - Table view data source

-(IBAction)cancel{
    [self.delegate itemDetailViewControllerDidCancel:self];
}

/**
 Update/Add items
 */

-(IBAction)done{
    if(self.itemToEdit == nil){
    iWannaItem *item = [[iWannaItem alloc]init];
    item.text = self.textField.text;
    item.checked = NO;
    item.shouldRemind = self.switchControl.on;
    item.dueDate = dueDate;
    [item scheduleNotification];
    [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    }
    else{
        self.itemToEdit.text = self.textField.text;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate;
        [self.itemToEdit scheduleNotification];
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}
/**
 if characters in cell >0 enable done button
 */
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = [newText length] > 0;
    return YES;
}

/**
 Prep for pick date segue
 */
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PickDate"]){
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}
/**
 Cancel date picker
 */
-(void) datePickerDidCancel:(DatePickerViewController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 select date
 */
-(void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date{
    dueDate = date;
    [self updateDueDateLabel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
