//
//  DataModel.m
//  iWanna
//
//  Created by Cionnat Breathnach on 10/03/2014.
//  Copyright (c) 2014 Cionnat Breathnach. All rights reserved.
//

#import "DataModel.h"
#import "iWannaCategory.h"
#import "iWannaItem.h"

@implementation DataModel
@synthesize categorys;

/**
 
 Gets next id of item
 **/
+(int)nextChecklistItemId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    long itemId = [userDefaults integerForKey:@"ChecklistItemId"];
    [userDefaults setInteger:itemId +1 forKey:@"ChecklistItemId"];
    [userDefaults synchronize];
    return (int)itemId;
}

/**
 Returns apps document directory
 **/
-(NSString *)documentsDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (void)registerDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
    [NSNumber numberWithInt:-1], @"ChecklistIndex",
    [NSNumber numberWithBool:YES], @"FirstTime",
    [NSNumber numberWithInt:0], @"ChecklistItemId",
                                nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(NSString *)dataFilePath{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"iWanna.plist"];
}
/**
 
 Saves checklists
 **/
-(void)saveChecklists{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:categorys forKey:@"iWannaList"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}
/**
 
 Loads checklists
 **/
-(void)loadChecklists{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        categorys = [unarchiver decodeObjectForKey:@"iWannaList"];
        [unarchiver finishDecoding];
    }
    else {
        categorys = [[NSMutableArray alloc] initWithCapacity:20];
    }
}
/**
 
 If app is run for the first time, populates cells with data
 **/
- (void)handleFirstTime
{
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    if (firstTime) {
        iWannaCategory *checklist = [[iWannaCategory alloc] init];
        checklist.name = @"Chores";
        checklist.iconName = @"Chores";
        [self.categorys addObject:checklist];
        [self setIndexOfSelectedChecklist:0];

        
        iWannaItem *chore1 = [[iWannaItem alloc]init];
        chore1.text = @"Clean Room";
        [checklist.items addObject:chore1 ];
        
        iWannaItem *chore2 = [[iWannaItem alloc]init];
        chore2.text = @"Do Ironing";
        [checklist.items addObject:chore2 ];
        
        iWannaItem *chore3 = [[iWannaItem alloc]init];
        chore3.text = @"Get Eggs";
        [checklist.items addObject:chore3 ];
        
        
        iWannaCategory *checklist2 = [[iWannaCategory alloc] init];
        checklist2.name = @"Films";
        checklist2.iconName = @"Photos";
        [self.categorys addObject:checklist2];
        [self setIndexOfSelectedChecklist:1];
        
        iWannaItem *item1 = [[iWannaItem alloc]init];
        item1.text = @"Anchorman";
        [checklist2.items addObject:item1 ];
        
        iWannaItem *item2 = [[iWannaItem alloc]init];
        item2.text = @"Batman";
        [checklist2.items addObject:item2 ];
        
        
        iWannaItem *item3 = [[iWannaItem alloc]init];
        item3.text = @"Watch 12 Years a Slave";
        [checklist2.items addObject:item3];
        
        
        iWannaCategory *checklist3 = [[iWannaCategory alloc] init];
        checklist3.name = @"Groceries";
        checklist3.iconName = @"Groceries";
        [self.categorys addObject:checklist3];
        [self setIndexOfSelectedChecklist:2];
        
        iWannaItem *gc1 = [[iWannaItem alloc]init];
        gc1.text = @"Buy chicken";
        [checklist3.items addObject:gc1 ];
        
        iWannaItem *gc2 = [[iWannaItem alloc]init];
        gc2.text = @"Get milk";
        [checklist3.items addObject:gc2 ];
        
        iWannaItem *gc3 = [[iWannaItem alloc]init];
        gc3.text = @"Get pasta";
        [checklist3.items addObject:gc3];
        
        
        iWannaCategory *checklist4 = [[iWannaCategory alloc] init];
        checklist4.name = @"Trips";
        checklist4.iconName = @"Trips";
        [self.categorys addObject:checklist4];
        [self setIndexOfSelectedChecklist:4];
        
        iWannaItem *t1 = [[iWannaItem alloc]init];
        t1.text = @"Ask Richy B about space hotel";
        [checklist4.items addObject:t1];
        
        iWannaItem *t2 = [[iWannaItem alloc]init];
        t2.text = @"Go to Bora Bora";
        [checklist4.items addObject:t2];
        
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
    }
}
- (void)sortChecklists
{
    [self.categorys sortUsingSelector:@selector(compare:)];
}

-(id)init {
    if ((self = [super init])) {
        [self loadChecklists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

- (int)indexOfSelectedChecklist
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

- (void)setIndexOfSelectedChecklist:(int)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}
@end
