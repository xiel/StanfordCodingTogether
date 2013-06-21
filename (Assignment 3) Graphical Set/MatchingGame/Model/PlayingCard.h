//
//  PlayingCard.h
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "Card.h"

//define the public API of this class
@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

//make a class mathodes public
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
