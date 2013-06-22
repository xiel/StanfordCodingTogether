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
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger symbol;
@property (nonatomic) NSUInteger shade;

//make a class mathodes public
+ (NSUInteger)maxValuesPerProperty;

@end
