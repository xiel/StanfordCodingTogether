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
@property (nonatomic) int matchMode;
@property (nonatomic) NSString *lastFlipResult;

//array to hold the cars of our game, lazy instantiation again
@property (strong, nonatomic) NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

//overwrite the getter
//lazy instantiation for the cards array
- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if(self){
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
    NSMutableArray *otherPlayedCardsForCard = [[NSMutableArray alloc] init];
    
    if(!card.isUnplayable){
        
        //check if flipping up this card creates a match or penalty
        if(!card.isFaceUp){
            
            //get other playable open cards
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    //add card to the playable card set
                    [playableOpenCards addObject:otherCard];
                    
                    //stop adding card if we have the maximum for current matchMode
                    if(playableOpenCards.count == self.matchMode-1){
                        break;
                    }
                }
            }
            
            //check if enough other playable cards were found
            if(playableOpenCards.count == self.matchMode-1){
                
                //the matching itself happens in the card class itself
                //int matchScore = [card match:playableOpenCards];
                int matchScore = 0;
                
                NSArray *playedCards = [playableOpenCards arrayByAddingObject:card];
                
                //check all cards for the best match
                for (Card *playedCard in playedCards) {
                    //get the other cards for this card
                    [otherPlayedCardsForCard addObjectsFromArray:playedCards];
                    [otherPlayedCardsForCard removeObject:playedCard];
                    
                    int matchScoreForCard = [playedCard match:otherPlayedCardsForCard];
                    matchScore = matchScoreForCard > matchScore ? matchScoreForCard : matchScore;
                }
                
                //if it's a match, we up our score
                if(matchScore){
                    scoreDiff = matchScore * MATCH_BONUS;
                    card.unplayable = YES;
                    self.lastFlipResult = [NSString stringWithFormat:@"Matched %@ for %d points",                                       [playedCards componentsJoinedByString:@" & "], scoreDiff];
                }
                //if it doesn't match we will get a penalty
                else {
                    scoreDiff = -1 * MATCH_BONUS;
                    self.lastFlipResult = [NSString stringWithFormat:@"%@ don't match! %d point penalty",                                       [playedCards componentsJoinedByString:@" & "], scoreDiff];
                }
                
                //successfully played cards get unplayable and stay faceUp
                for(Card *playedCard in playableOpenCards){
                    playedCard.unplayable = matchScore ? YES : NO;
                    playedCard.faceUp = matchScore ? YES : NO;
                }
                
                //update the game score
                self.score += scoreDiff;
            }
            //it costs points to flip up cards :)
            self.score -= FLIP_COST;
        }
        
        //flip the card
        card.faceUp = !card.isFaceUp;
        
        if(!scoreDiff){
            self.lastFlipResult = [NSString stringWithFormat: card.isFaceUp ? @"Flipped up %@" : @"Flipped down %@" , card];
        }
    }
    
}

//just return the wanted item, but check if not out of bounds
- (Card *)cardAtIndex:(NSUInteger)index {    
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)setMatchMode:(int)newMode {
    _matchMode = newMode;
}



@end
