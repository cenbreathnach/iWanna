//
//  DatePickerViewController.m
//  iWanna
//
//  Created by Cionnat Breathnach on 12/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController{
    UILabel *dateLabel;
}

@synthesize tableView, datePicker, delegate, date;


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.datePicker setDate:self.date animated:YES];
}

/**
 Update label with new date
 */
-(void) updateDateLabel{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    dateLabel.text = [formatter stringFromDate:self.date];
}
/**
 set date and call update label
 */
-(IBAction)dateChanged{
    self.date = [self.datePicker date];
    [self updateDateLabel];
}
/**
 cancel selection of date
 */
-(IBAction)cancel{
    [self.delegate datePickerDidCancel:self];
}
/**
 set date
 */
-(IBAction)done{
    [self.delegate datePicker:self didPickDate:self.date];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 Only one row on table view
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

/**
 Updating
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateCell"];
    dateLabel = (UILabel *)[cell viewWithTag:1000];
    [self updateDateLabel];
    return cell;
}
/**
 Cant select datelabel's cell
 */

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
/**
 Puts a header of 77pts on top of cell.
 */
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 77;
}

@end
