//
//  CardMatchingGame.h
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

//the public interface of the cardMatchingGame (game logic)
@interface CardMatchingGame : NSObject

//designated initializer, use this instead of init
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)flipCardAtIndex:(NSUInteger)index;

@property (nonatomic) int matchMode;
@property (nonatomic, readonly) int score;

//new flip result
@property (nonatomic, readonly) NSMutableArray *latestFlippedCards;
@property (nonatomic) int latestFlippedScore;


@end
