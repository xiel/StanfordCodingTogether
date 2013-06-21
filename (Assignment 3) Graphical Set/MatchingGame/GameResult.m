//
//  GameResult.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/18/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "GameResult.h"

#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define ALL_RESULTS_KEY @"GameResult_All"

@interface GameResult()
@property (nonatomic) NSDate *start;
@property (nonatomic) NSDate *end;
@end

@implementation GameResult

//designated initializer
- (id)init {
    self = [super init];
    
    if(self){
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
}

//convencience initializer
- (id)initFromPropertyList:(id)plist {
    self = [self init];
    
    if(self){
        if([plist isKindOfClass:[NSDictionary class]]){
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] integerValue];
            
            if(!_start || !_end) self = nil;
        }
    }
    
    return self;
}

+(NSArray *)allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for(id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]){
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}

//define the getter of the duration (timeinterval)
- (NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

//when the score is set, the end is set as well (to now)
- (void)setScore:(int)score {
    _score = score;
    self.end = [NSDate date];
    
    //everytime the score changes, we will sync
    [self syncronize];
}

//save the results in the user defaults to be persitent
- (void)syncronize {
    
    //get dictionary from user defaults (mutable)
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    //if there is so dictionary, we create a new one
    if(!mutableGameResultsFromUserDefaults){
        mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    }
    
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    
    //put them back and syncronize (save)
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList {
    return @{START_KEY: self.start, END_KEY: self.end, SCORE_KEY: @(self.score) };
}

@end
