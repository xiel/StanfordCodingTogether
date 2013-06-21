//
//  CardGameViewController.h
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

//imports all the iOS User Interface Classes
#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (nonatomic) NSUInteger startingCardCount; //abstract
+ (int)matchMode; //abstract
- (Deck *)createDeck; //abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate; //abstract
- (void)updateFlipResultLabel:(UILabel*)label usingCards:(NSArray *)cards scored:(int)score;

@end
