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
        for(NSString *symbol in [SetCard validSymbols]){
            for(NSString *color in [SetCard validColors]){
                for(NSString *shade in [SetCard validShades]){
                    for (NSUInteger elementsCount = 1; elementsCount <= [SetCard maxElementsCount]; elementsCount++) {
                        
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
