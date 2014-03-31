//
//  AllListsViewController.h
//  iWanna
//
//  Created by Cionnat Breathnach on 08/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate> //implementing delegates

@property (nonatomic, strong) DataModel *dataModel;

@end
