//
//  ListDetailViewController.h
//  iWanna
//
//  Created by Cionnat Breathnach on 09/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class iWannaCategory;
@protocol ListDetailViewControllerDelegate <NSObject>
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(iWannaCategory *)checklist;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(iWannaCategory *)checklist;
@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>
//@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) iWannaCategory *checklistToEdit;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
- (IBAction)cancel;
- (IBAction)done;
@end