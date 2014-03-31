//
//  DataModel.h
//  iWanna
//
//  Created by Cionnat Breathnach on 10/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *categorys;
-(void)saveChecklists;
-(void)sortChecklists;
-(int)indexOfSelectedChecklist;
-(void)setIndexOfSelectedChecklist:(int)index;
+(int)nextChecklistItemId;

@end
