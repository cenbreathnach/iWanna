//
//  iWannaCategory.m
//  iWanna
//
//  Created by Cionnat Breathnach on 08/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "iWannaCategory.h"
#import "iWannaItem.h"

@implementation iWannaCategory
@synthesize name;
@synthesize items;
@synthesize iconName;


- (id)init {
    if ((self = [super init])) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
        self.iconName = @"No Icon";
    }
    return self;
}
/**
 Return number of items to do
 */
- (int)countUncheckedItems
{
    int count = 0;
    for (iWannaItem *item in self.items) {
        if (!item.checked) {
            count += 1;
        }
    }
    return count;
}
/**
 Comparing items alphabetically
**/
- (NSComparisonResult)compare:(iWannaCategory *)otherChecklist {
    return [self.name localizedStandardCompare:otherChecklist.name];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
}

@end