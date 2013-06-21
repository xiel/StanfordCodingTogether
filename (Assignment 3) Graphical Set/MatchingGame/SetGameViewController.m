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
#import "SetCardCollectionViewCell.h"

#define SET_STARTING_CARD_COUNT 24
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
                    [newText appendAttributedString:[self attributedStringForSetCard:setCard]];
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
                    [newText appendAttributedString:[self attributedStringForSetCard:setCard]];
                    cardCount++;
                }
                
                [newText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" don't match! %d points penalty!", score]]];
                label.attributedText = newText;
            }
        } else
            //no match, just flipped a card up
        {
            NSMutableAttributedString *newText = [[NSMutableAttributedString alloc] initWithString:latestSetCard.isFaceUp ? @"Flipped up " : @"Flipped down "];
            [newText appendAttributedString:[self attributedStringForSetCard:latestSetCard]];
            label.attributedText = newText;
        }
    }
    //if there are no cards (at the beginning of a new game)
    else {
        label.text = @"Let's play!";
    }
}

+ (NSDictionary *)colorDictionary {
    return @{ @"Red": [UIColor redColor],
              @"Green": [UIColor greenColor],
              @"Blue": [UIColor blueColor]
    };
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate {
    
    if([cell isKindOfClass:[SetCardCollectionViewCell class]]){
        
        UITextView *setCardTextView = ((SetCardCollectionViewCell *)cell).setCardTextView;
        
        if([card isKindOfClass:[SetCard class]]){
            
            SetCard *setCard = (SetCard *)card;
            
            setCardTextView.attributedText = [self attributedStringForSetCard:setCard];
            
            if(!setCard.isUnplayable){
                setCardTextView.hidden = NO;
                
                if(setCard.isFaceUp){
                    setCardTextView.backgroundColor = [UIColor lightGrayColor];
                } else {
                    setCardTextView.backgroundColor = [UIColor whiteColor];
                }
            } else {
                //disabled cards
                setCardTextView.hidden = YES;
            }
        }
    }
}

- (NSAttributedString *)attributedStringForSetCard:(SetCard *)setCard {
    
    NSMutableAttributedString *mat;
    
    if(setCard){
        //build & set text from symbols and elementscount
        NSMutableString *symbolCountText = [[NSMutableString alloc] init];
        for (int elementCounter = 1; elementCounter <= setCard.elementsCount; elementCounter++) {
            [symbolCountText appendString:setCard.symbol];
        }
        
        //update the attributed strings
        mat = [[NSMutableAttributedString alloc] initWithString:symbolCountText];
        UIColor *cardBaseColor = [[self class] colorDictionary][setCard.color];
        NSRange textRange = NSMakeRange(0, setCard.elementsCount);
        
        NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
        pStyle.alignment = NSTextAlignmentCenter;
        
        //ToDo: use switch statement instead! to much repeatition here
        if([setCard.shade isEqual: @"solid"]){
            
            [mat setAttributes:@{ NSForegroundColorAttributeName : [cardBaseColor colorWithAlphaComponent: 1],
                                  NSStrokeWidthAttributeName: @-3,
                                  NSStrokeColorAttributeName: cardBaseColor,
                                  NSParagraphStyleAttributeName: pStyle
                                  } range:textRange];
            
        } else if([setCard.shade isEqual: @"striped"]) {
            
            [mat setAttributes:@{ NSForegroundColorAttributeName : [cardBaseColor colorWithAlphaComponent:0.5],
                                  NSStrokeWidthAttributeName: @-3,
                                  NSStrokeColorAttributeName: cardBaseColor,
                                  NSParagraphStyleAttributeName: pStyle
                                  } range:textRange];
            
        } else if([setCard.shade isEqual: @"open"]) {
            
            [mat setAttributes:@{ NSForegroundColorAttributeName : [cardBaseColor colorWithAlphaComponent:0],
                                  NSStrokeWidthAttributeName: @-3,
                                  NSStrokeColorAttributeName: cardBaseColor,
                                  NSParagraphStyleAttributeName: pStyle
                                  } range:textRange];
        }
    }
    
    NSAttributedString *attString = [mat copy];
    
    return attString;
}

@end
