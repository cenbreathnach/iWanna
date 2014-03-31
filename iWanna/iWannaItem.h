//
//  iWannaItem.h
//  iWanna
//
//  Created by Cionnat Breathnach on 03/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iWannaItem : NSObject <NSCoding>
@property(nonatomic,copy) NSString *text;
@property(nonatomic, assign) BOOL checked;
@property(nonatomic,copy)NSDate *dueDate;
@property(nonatomic,assign)BOOL shouldRemind;
@property(nonatomic,assign)int itemId;

-(void)toggleChecked;
-(void)scheduleNotification;
@end
