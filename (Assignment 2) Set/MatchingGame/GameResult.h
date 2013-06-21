//
//  GameResult.h
//  MatchingGame
//
//  Created by Felix Leupold on 6/18/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults; //of GameResult

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly) NSTimeInterval duration;
@property (nonatomic) int score;

@end
