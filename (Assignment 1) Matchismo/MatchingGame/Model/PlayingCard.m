//
//  PlayingCard.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    //map rank number to the card game numbers like ace, jack...
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    //we are only matching one card here... (maybe later more cards)
    if(otherCards.count == 1) {
        
        PlayingCard *otherCard = [otherCards lastObject];
        
        if([otherCard.suit isEqualToString:self.suit]){
            score = 2; //1
        } else if(otherCard.rank == self.rank){
            score = 8; //4
        }
        
    }
    if(otherCards.count == 2){
        int suitScore = 0;
        int rankScore = 0;
        
        int suitMatches = 0;
        int rankMatches = 0;
        
        for (PlayingCard *otherCard in otherCards) {
            if([otherCard.suit isEqualToString:self.suit]){
                suitMatches++;
            } else if(otherCard.rank == self.rank){
                rankMatches++;
            }
        }
        
        if(suitMatches == 1){
            suitScore = 1;
        }
        if(suitMatches == 2){
            suitScore = 4;
        }
        
        if(rankMatches == 1){
            rankScore = 4;
        }
        if(rankMatches == 2){
            rankScore = 24;
        }
        
        score = suitScore + rankScore;
    }
    
    return score;
}

@synthesize suit = _suit; //because we provide setter AND getter
//define a class method, which returns an array of valid suits
+ (NSArray *)validSuits {
    return @[@"♥", @"♦", @"♠", @"♣"];
}
//setter for suits (checks before if new value is valid)
- (void)setSuit:(NSString *)suit {
    //call the class method "validSuits" to get the suits
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}
//use suits getter to make a "zero" suit show up as "?"
- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    //we can access the class method "rankStrings" vida self because maxRank is a class method itself
    return [self rankStrings].count - 1;
}

- (void)setRank:(NSUInteger)rank {
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
