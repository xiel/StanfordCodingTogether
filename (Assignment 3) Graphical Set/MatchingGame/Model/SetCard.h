//
//  SetCard.h
//  MatchingGame
//
//  Created by Felix Leupold on 6/19/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger elementsCount;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shade;

//make a class mathodes public
+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validShades;
+ (NSArray *)elementsCountStrings;
+ (NSUInteger)maxElementsCount;

@end
