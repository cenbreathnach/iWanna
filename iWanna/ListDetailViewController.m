//
//  ListDetailViewController.m
//  iWanna
//
//  Created by Cionnat Breathnach on 09/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "ListDetailViewController.h"
#import "iWannaCategory.h"

@implementation ListDetailViewController{
    NSString *iconName;
}
@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize checklistToEdit;

- (void)viewDidLoad{
    [super viewDidLoad];
    if (self.checklistToEdit != nil) {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
        iconName = self.checklistToEdit.iconName;
    }
    self.iconImageView.image = [UIImage imageNamed:iconName];
}
/**
 Defaults to Folder icon
 **/
-(id)initWithCoder:(NSCoder *)aDecoder{
    if((self = [super initWithCoder:aDecoder])){
        iconName = @"Folder";
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

-(IBAction)cancel{
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.checklistToEdit == nil) {
        iWannaCategory *checklist = [[iWannaCategory alloc] init];
        checklist.name = self.textField.text;
        checklist.iconName = iconName;
        [self.delegate listDetailViewController:self didFinishAddingChecklist: checklist];
    }
    else {
        self.checklistToEdit.name = self.textField.text;
        self.checklistToEdit.iconName = iconName;
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
}
/**
    Only select 2nd row
 **/
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return indexPath;
    }
    else {
        return nil;
    }
}

/**
 Sets done bar to enabled
 **/
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}
/**
 Icon Picker segue
 **/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"PickIcon"]){
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}
/**
 icon picker delegate method
 **/
-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)theIconName{
    iconName = theIconName;
    self.iconImageView.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES]; //pop instead of dismiss because segue is push
}

@end
