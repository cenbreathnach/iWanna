//
//  IconPickerViewController.m
//  iWanna
//
//  Created by Cionnat Breathnach on 10/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController{
    NSArray *icons;
}
@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 Initializes array with icons
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    icons = [NSArray arrayWithObjects:
             @"No Icon",
             @"Appointments",
             @"Birthdays",
             @"Chores",
             @"Drinks",
             @"Folder",
             @"Groceries",
             @"Inbox",
             @"Photos",
             @"Trips",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [icons count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    NSString *icon = [icons objectAtIndex:indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *iconName = [icons objectAtIndex:indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}


@end
