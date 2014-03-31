//
//  ViewController.h
//  iWanna
//
//  Created by Cionnat Breathnach on 03/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class iWannaCategory;

@interface iWannaViewController : UITableViewController <DetailViewControllerDelegate>

@property(nonatomic,strong) iWannaCategory *category;
-(void) updateDueToday;
@end
