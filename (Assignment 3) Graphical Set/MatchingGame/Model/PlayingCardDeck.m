//
//  PlayingCardDeck.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

//create a playing card deck with all available suits and ranks
- (id)init {
    //ONLY here we are assigning a value to self
    //by calling super classes initializer (this is needed if we overwrite the init method)
    self = [super init];
    
    //if init was successful (!nil)...
    if(self){
        
        //loop through the suits and ranks
        for(NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                
                //create a new card, allocate memory and initialize it
                PlayingCard *card = [[PlayingCard alloc] init];
                
                //update the propertys using dot notation, instead of [card setRank:rank] (?)
                card.rank = rank;
                card.suit = suit;
                
                //add the card to ourselves (we are a Deck, so we have a inherited method called addCard)
                [self addCard:card atTop:YES];
                
            }
        }
        
    }
    
    return self;
}

@end
