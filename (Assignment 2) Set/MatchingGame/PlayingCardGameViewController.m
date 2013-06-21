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
#define PLAYING_CARD_STARTING_COUNT 20
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
