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

#define SET_STARTING_CARD_COUNT 12
#define SET_MATCHING_MODE 3

@interface SetGameViewController()
@property (weak, nonatomic) IBOutlet SetCardView *latestCardViewOne;
@property (weak, nonatomic) IBOutlet SetCardView *latestCardViewTwo;
@property (weak, nonatomic) IBOutlet SetCardView *latestCardViewThree;
@property (strong, nonatomic) NSArray *latestCardViews;
@end

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

- (NSArray *)latestCardViews {
    if(!_latestCardViews) {
        _latestCardViews = @[self.latestCardViewOne,
                             self.latestCardViewTwo,
                             self.latestCardViewThree];
    }
    return _latestCardViews;
}

- (void)updateFlipResultLabel:(UILabel*)label usingCards:(NSArray *)cards scored:(int)score {
    
    SetCard *latestSetCard = [cards lastObject];
    
//    for (int i = 1; i<=2; i++) {
//        if(i <= cards.count){
//            SetCard *setCard = cards[cards.count - i];
//            SetCardView *setCardView = self.latestCardViews[self.latestCardViews.count - i];
//            
//            setCardView.elementsCount = setCard.elementsCount;
//            setCardView.color = setCard.color;
//            setCardView.symbol = setCard.symbol;
//            setCardView.shade = setCard.shade;
//            setCardView.faceUp = setCard.isFaceUp;
//        }
//        
//    }
    
    int i = 0;
    for (SetCardView *setCardView in self.latestCardViews){
        
        if(i < cards.count){
            
            setCardView.hidden = NO;
            SetCard *setCard = cards[i];
            
            setCardView.elementsCount = setCard.elementsCount;
            setCardView.color = setCard.color;
            setCardView.symbol = setCard.symbol;
            setCardView.shade = setCard.shade;
            setCardView.faceUp = setCard.isFaceUp;
            
        } else {
            setCardView.hidden = YES;
        }
        
        i++;
    }
    
    //check if there is at least one card
    if(latestSetCard){
        //match or mismatch
        if(score != 0){
            
            //match
            if(score > 0){
                
            }
            //mismatch
            else {
                
               
            }
        } else
        //no match, just flipped a card up
        {
            
        }
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
