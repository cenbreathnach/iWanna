//
//  DatePickerViewController.h
//  iWanna
//
//  Created by Cionnat Breathnach on 12/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerViewController;
@protocol DatePickerViewControllerDelegate <NSObject> //declaring delegate

-(void)datePickerDidCancel:(DatePickerViewController *)picker;
-(void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date;

@end


@interface DatePickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id <DatePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDate *date;

-(IBAction)cancel;
-(IBAction)done;
-(IBAction)dateChanged;

@end
