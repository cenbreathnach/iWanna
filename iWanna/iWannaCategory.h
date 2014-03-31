//
//  iWannaCategory.h
//  iWanna
//
//  Created by Cionnat Breathnach on 08/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iWannaCategory : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic,copy) NSString *iconName;

- (int)countUncheckedItems;

@end
