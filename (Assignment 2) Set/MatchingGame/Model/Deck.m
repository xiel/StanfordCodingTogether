//
//  Deck.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation Deck

//1. default getter for the the cards property gets "overwritten" to make it initiate the first time we try to get it
//2. it's not really overwritten, the compiler noticed it, and so it is just defined here (the default method is never implemented)
//3. this is called "lazy instantiation"
- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//1. insetObject and addObject are methods of NSMutableArray
//2. self.cards? before objects can be added, we need to have that array initiated
// so let's "overwrite" the getter
- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if(self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
