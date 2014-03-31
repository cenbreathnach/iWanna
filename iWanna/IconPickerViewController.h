//
//  IconPickerViewController.h
//  iWanna
//
//  Created by Cionnat Breathnach on 10/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IconPickerViewController;
@protocol IconPickerViewControllerDelegate <NSObject>
-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *) iconName;
@end

@interface IconPickerViewController : UITableViewController

@property (nonatomic,weak) id<IconPickerViewControllerDelegate> delegate;

@end
