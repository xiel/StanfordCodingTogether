//
//  SetCard.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/19/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "SetCard.h"

#define MAX_SHAPE_COUNT 3;

@implementation SetCard

- (NSString *)contents{
    NSArray *elementsCountStrings = [SetCard elementsCountStrings];
    
    //return the contents as one string (eg. OneBlueSolid▲)
    return [[[elementsCountStrings[self.elementsCount]
              stringByAppendingString:self.color]
                stringByAppendingString:self.shade]
                    stringByAppendingString:self.symbol];
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
        
        score = (validColors && validShades && validSymbols && validCount) ? 5 : 0;
    }
    
    return score;
}

- (void)setElementsCount:(NSUInteger)elementsCount {
    if(elementsCount <= [SetCard maxElementsCount]){
        _elementsCount = elementsCount;
    }
}

@synthesize symbol = _symbol;

- (void)setSymbol:(NSString *)symbol {
    if([[SetCard validSymbols] containsObject:symbol]){
        _symbol = symbol;
    }
}
- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

@synthesize color = _color;

- (void)setColor:(NSString *)color {
    if([[SetCard validColors] containsObject:color]){
        _color = color;
    }
}
- (NSString *)color {
    return _color ? _color : @"?";
}

@synthesize shade = _shade;

- (void)setShade:(NSString *)shade {
    //call the class method "validSuits" to get the suits
    if([[SetCard validShades] containsObject:shade]){
        _shade = shade;
    }
}

- (NSString *)shade {
    return _shade ? _shade : @"?";
}

+ (NSArray *)validSymbols {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validColors {
    return @[@"Red", @"Green", @"Blue"];
}

+ (NSArray *)validShades {
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)elementsCountStrings {
    return @[@"?", @"One", @"Two", @"Three"];
}

+ (NSUInteger)maxElementsCount {
    return MAX_SHAPE_COUNT;
}



@end