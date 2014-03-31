//
//  iWannaItem.m
//  iWanna
//
//  Created by Cionnat Breathnach on 03/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "DataModel.h"
#import "iWannaItem.h"

@implementation iWannaItem
@synthesize text,checked, dueDate, shouldRemind, itemId;

-(id)init{
    if((self = [super init])){
        self.itemId = [DataModel nextChecklistItemId]; //unique id for items
        self.dueDate = [NSDate date];
    }
       return self;
}
/**
Loading from plist
*/
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [aDecoder decodeIntForKey:@"ItemID"];
    }
    return self;
}
/**
 Saving to plist
 */
-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"ItemID"];
}

/**
 gets notification, if any of the item
 */
-(UILocalNotification *)notificationForThisItem{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in  allNotifications) {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        if(number != nil && [number intValue] == self.itemId){
            return notification;
        }
        
    }
    return nil;
}

/**
First cancel any existing and update with new notification if needed
 */
-(void)scheduleNotification{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if(existingNotification != nil){
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    if(self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending){
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = self.dueDate;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.alertBody = self.text;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"ItemID"];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}
/**
 toggle checkmark
 */
-(void)toggleChecked{
    self.checked = !self.checked;
}
/**
if deleted cancel notification
 */
-(void) dealloc{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if(existingNotification != nil){
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
}
@end
