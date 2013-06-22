//
//  PlayingCardGameViewController.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/19/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardCollectionViewCell.h"

#define PLAYING_CARD_MATCHING_MODE 2;
#define PLAYING_CARD_STARTING_COUNT 22
#define CARD_ALPHA_PLAYABLE 1.0
#define CARD_ALPHA_UNPLAYABLE 0.3
#define FLIP_DURATION 0.5

@implementation PlayingCardGameViewController

+ (int)matchMode {
    return PLAYING_CARD_MATCHING_MODE;
}

- (NSUInteger)startingCardCount {
    return PLAYING_CARD_STARTING_COUNT;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)updateFlipResultLabel:(UILabel*)label usingCards:(NSArray *)cards scored:(int)score {
    Card *latestCard = [cards lastObject];
    
    if(latestCard){
        //match or mismatch
        if(score != 0){
            //match
            if(score > 0){
                label.text = [NSString stringWithFormat:@"Matched %@ for %d points", [cards componentsJoinedByString:@" & "], score];
            } else
                //mismatch
            {
                label.text = [NSString stringWithFormat:@"%@ don't match! %d point penalty", [cards componentsJoinedByString:@" & "], score];
            }
        } else
            //no match, just flipped a card up
        {
            label.text = [NSString stringWithFormat: latestCard.isFaceUp ? @"Flipped up %@" : @"Flipped down %@" , latestCard];
        }
    }
    //if there are no cards (at the beginning of a new game)
    else{
        label.text = @"Let's play!";
    }
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate {
    
    
    
    if([cell isKindOfClass:[PlayingCardCollectionViewCell class]]){
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if([card isKindOfClass:[PlayingCard class]]){
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            
            if(animate){
                [UIView transitionWithView:playingCardView
                                  duration:FLIP_DURATION
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.alpha = playingCard.isUnplayable ? CARD_ALPHA_UNPLAYABLE : CARD_ALPHA_PLAYABLE;
                                    playingCardView.faceUp = playingCard.isFaceUp;
                                }
                                completion:NULL];
            } else {
                playingCardView.alpha = playingCard.isUnplayable ? CARD_ALPHA_UNPLAYABLE : CARD_ALPHA_PLAYABLE;
                playingCardView.faceUp = playingCard.isFaceUp;
            }
        }
    }
}

@end
