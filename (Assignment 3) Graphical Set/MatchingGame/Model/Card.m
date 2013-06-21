//
//  Card.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards{
    
    //create local int variable
    int score = 0;
    
    //loop through the other cards and check if the strings do match
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    //return the variable
    return score;
}

- (NSString *)description {
    return self.contents;
}

@end