//
//  SetCardDeck.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/19/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

//create a set card deck with all available suits and ranks
- (id)init {
    //call super init
    self = [super init];
    
    //if init was successful (!nil)...
    if(self){
        
        //loop through the suits and ranks
        for (NSUInteger elementsCount = 1; elementsCount <= [SetCard maxValuesPerProperty]; elementsCount++) {
            for (NSUInteger color = 1; color <= [SetCard maxValuesPerProperty]; color++) {
                for (NSUInteger shade = 1; shade <= [SetCard maxValuesPerProperty]; shade++) {
                    for (NSUInteger symbol = 1; symbol <= [SetCard maxValuesPerProperty]; symbol++) {
                        
                        //create a new card, allocate memory and initialize it
                        SetCard *card = [[SetCard alloc] init];
                        
                        //update the card
                        card.symbol = symbol;
                        card.color = color;
                        card.shade = shade;
                        card.elementsCount = elementsCount;
                        
                        //add the card to ourselves (we are a Deck, so we have a inherited method called addCard)
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
