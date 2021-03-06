//
//  CardMatchingGame.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "CardMatchingGame.h"

//area to put private properties (called class extension)
@interface CardMatchingGame()

@property (nonatomic) int score;

//new flip result
@property (nonatomic, readwrite) NSMutableArray *latestFlippedCards;

//array to hold the cars of our game, lazy instantiation again
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardMatchingGame

//overwrite the getter
//lazy instantiation for the cards array
- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//lazy instantiation of latest flipped cards
- (NSMutableArray *)latestFlippedCards {
    if(!_latestFlippedCards) _latestFlippedCards = [[NSMutableArray alloc] init];
    return _latestFlippedCards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if(self){
        
        //save deck
        self.deck = deck;
        
        //loop through the specified count of cards
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            
            //return nil if we cannot initialize properly
            if(!card){
                self = nil;
                break;
            } else {
                //add the card to the array
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

//define constants for the score factors
#define FLIP_COST 1
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4

- (void)flipCardAtIndex:(NSUInteger)index {
    
    Card *card = self.cards[index];
    
    int scoreDiff = 0;
    NSMutableArray *playableOpenCards = [[NSMutableArray alloc] init];
    
    //remove all cards and add all open playable cards...
    [self.latestFlippedCards removeAllObjects];
    
    if(!card.isUnplayable){
        
        //check if flipping up this card creates a match or penalty
        if(!card.isFaceUp){
            
            //get other playable open cards
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    //add card to the playable card set
                    [playableOpenCards addObject:otherCard];
                    [self.latestFlippedCards addObject:otherCard];
                    
                    //stop adding card if we have the maximum for current matchMode
                    if(playableOpenCards.count == self.matchMode-1){
                        break;
                    }
                }
            }
            
            //check if enough other playable cards were found
            if(playableOpenCards.count == self.matchMode-1){
                
                //the matching itself happens in the card class itself
                int matchScore = [card match:playableOpenCards];
                
                //if it's a match, we up our score
                if(matchScore){
                    scoreDiff = matchScore * MATCH_BONUS;
                    card.unplayable = YES;
                }
                //if it doesn't match we will get a penalty
                else {
                    scoreDiff = -1 * MATCH_BONUS;
                }
                
                //successfully played cards get unplayable and stay faceUp
                for(Card *playedCard in playableOpenCards){
                    playedCard.unplayable = matchScore ? YES : NO;
                    playedCard.faceUp = matchScore ? YES : NO;
                    playedCard.animateFlip = matchScore ? NO : YES;
                }
                
                //update the game score
                self.score += scoreDiff;
            }
            //it costs points to flip up cards :)
            self.score -= FLIP_COST;
            
        }
        
        //update flipped properties for result label
        //add card, whether is is face up or not
        self.latestFlippedScore = scoreDiff;
        [self.latestFlippedCards addObject:card];
        
        //flip the card
        card.faceUp = !card.isFaceUp;
        card.animateFlip = YES;
    }
    
}

//just return the wanted item, but check if not out of bounds
- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)removeCardAtIndex:(NSUInteger)index {
    [self.cards removeObjectAtIndex:index];
}

- (int)numberOfCardsInPlay {
    return self.cards.count;
}

- (void)addAdditionalCardToGame {
    Card *card = [self.deck drawRandomCard];
    if(card){
        [self.cards addObject:card];
    }
}

#define MATCH_MODE 2

- (int)matchMode {
    if(!_matchMode) _matchMode = MATCH_MODE;
    return _matchMode;
}

@end
