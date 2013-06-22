//
//  SetCard.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/19/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "SetCard.h"

#define VALUES_PER_PROPERTY 3;

@implementation SetCard

+ (NSUInteger)maxValuesPerProperty {
    return VALUES_PER_PROPERTY;
}

- (NSString *)contents{
    return nil;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    //check if the cards are a valid set
    if(otherCards.count == 2){
        SetCard *otherFirst = otherCards[0];
        SetCard *otherSecond = otherCards[1];
        
        //check all paramenters
        BOOL validColors = (self.color == otherFirst.color && self.color == otherSecond.color)
            || (self.color != otherFirst.color && self.color != otherSecond.color && otherFirst.color != otherSecond.color);
        
        BOOL validShades = (self.shade == otherFirst.shade && self.shade == otherSecond.shade)
            || (self.shade != otherFirst.shade && self.shade != otherSecond.shade && otherFirst.shade != otherSecond.shade);
        
        BOOL validSymbols = (self.symbol == otherFirst.symbol && self.symbol == otherSecond.symbol)
        || (self.symbol != otherFirst.symbol && self.symbol != otherSecond.symbol && otherFirst.symbol != otherSecond.symbol);

        BOOL validCount = (self.elementsCount == otherFirst.elementsCount && self.elementsCount == otherSecond.elementsCount)
        || (self.elementsCount != otherFirst.elementsCount && self.elementsCount != otherSecond.elementsCount && otherFirst.elementsCount != otherSecond.elementsCount);
        
        score = (validColors && validShades && validSymbols && validCount) ? 10 : 0;
    }
    
    return score;
}

- (void)setElementsCount:(NSUInteger)elementsCount {
    if(elementsCount <= [SetCard maxValuesPerProperty]){
        _elementsCount = elementsCount;
    }
}

- (void)setColor:(NSUInteger)color {
    if(color <= [SetCard maxValuesPerProperty]){
        _color = color;
    }
}

- (void)setSymbol:(NSUInteger)symbol {
    if(symbol <= [SetCard maxValuesPerProperty]){
        _symbol = symbol;
    }
}

- (void)setShade:(NSUInteger)shade {
    if(shade <= [SetCard maxValuesPerProperty]){
        _shade = shade;
    }
}

@end