//
//  SetGameViewController.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/19/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCardCollectionViewCell.h"

#define SET_STARTING_CARD_COUNT 20
#define SET_MATCHING_MODE 3

@implementation SetGameViewController

+ (int)matchMode {
    return SET_MATCHING_MODE;
}

- (NSUInteger) startingCardCount {
    return SET_STARTING_CARD_COUNT;
}

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void)updateFlipResultLabel:(UILabel*)label usingCards:(NSArray *)cards scored:(int)score {
    
    return;
    
    SetCard *latestSetCard = [cards lastObject];
    
    //check if there is at least one card
    if(latestSetCard){
        //match or mismatch
        if(score != 0){
            int cardCount = 0;
            
            //match
            if(score > 0){
                NSMutableAttributedString *newText = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
                
                for(SetCard *setCard in cards){
                    if(cardCount != 0){
                        [newText appendAttributedString:[[NSAttributedString alloc] initWithString:@" & "]];
                    }
//                    [newText appendAttributedString:[self attributedStringForSetCard:setCard]];
                    cardCount++;
                }
                
                [newText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points!", score]]];
                label.attributedText = newText;
            }
            //mismatch
            else {
                
                NSMutableAttributedString *newText = [[NSMutableAttributedString alloc] init];
                
                for(SetCard *setCard in cards){
                    if(cardCount != 0){
                        [newText appendAttributedString:[[NSAttributedString alloc] initWithString:@" & "]];
                    }
//                    [newText appendAttributedString:[self attributedStringForSetCard:setCard]];
                    cardCount++;
                }
                
                [newText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %d points penalty!", score]]];
                label.attributedText = newText;
            }
        } else
            //no match, just flipped a card up
        {
            NSMutableAttributedString *newText = [[NSMutableAttributedString alloc] initWithString:latestSetCard.isFaceUp ? @"Flipped up " : @"Flipped down "];
//            [newText appendAttributedString:[self attributedStringForSetCard:latestSetCard]];
            label.attributedText = newText;
        }
    }
    //if there are no cards (at the beginning of a new game)
    else {
        label.text = @"Let's play!";
    }
}


- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate {
    
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]){
        
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        
        //some introspection
        if([card isKindOfClass:[SetCard class]]){
            
            SetCard *setCard = (SetCard *)card;
            
            setCardView.elementsCount = setCard.elementsCount;
            setCardView.color = setCard.color;
            setCardView.symbol = setCard.symbol;
            setCardView.shade = setCard.shade;
            setCardView.faceUp = setCard.isFaceUp;
            
            setCardView.hidden = setCard.isUnplayable ? YES : NO;
        }
    }
}


@end
