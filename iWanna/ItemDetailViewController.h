//
//  itemDetailViewController
//  iWanna
//
//  Created by Cionnat Breathnach on 04/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerViewController.h"

@class ItemDetailViewController;
@class iWannaItem;

@protocol DetailViewControllerDelegate <NSObject> //declaring delegate

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(iWannaItem *)item;
-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(iWannaItem *)item;

@end

/**
 
 */

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate, DatePickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, strong) IBOutlet UISwitch *switchControl;
@property (nonatomic, strong) IBOutlet UILabel *dueDateLabel;

@property (nonatomic, weak) id <DetailViewControllerDelegate> delegate;

@property (nonatomic,strong) iWannaItem *itemToEdit;

-(IBAction)cancel;
-(IBAction)done;
@end
