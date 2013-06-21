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
    //abstract
    NSLog(@"updateFlipResultLabel in SetGameViewController");
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
            
            //if we have a custom set card view we will use playingCardView.rank = playingCard.rank to update the card...
            //for now we just use attributed strings
            
            //build & set text from symbols and elementscount
            NSMutableString *symbolCountText = [[NSMutableString alloc] init];
            for (int elementCounter = 1; elementCounter <= setCard.elementsCount; elementCounter++) {
                [symbolCountText appendString:setCard.symbol];
                
            }
            setCardTextView.text = symbolCountText;
            
            //update the attributed strings
            NSMutableAttributedString *mat = [setCardTextView.attributedText mutableCopy];
            UIColor *cardBaseColor = [[self class] colorDictionary][setCard.color];
            NSRange textRange = NSMakeRange(0, setCard.elementsCount);
            
            //ToDo: use switch statement instead! to much repeatition here
            if([setCard.shade isEqual: @"solid"]){
                
                [mat addAttributes:@{ NSForegroundColorAttributeName : [cardBaseColor colorWithAlphaComponent: 1],
                                      NSStrokeWidthAttributeName: @-3,
                                      NSStrokeColorAttributeName: cardBaseColor
                                      } range:textRange];
                
            } else if([setCard.shade isEqual: @"striped"]) {
                
                [mat addAttributes:@{ NSForegroundColorAttributeName : [cardBaseColor colorWithAlphaComponent:0.5],
                                      NSStrokeWidthAttributeName: @-3,
                                      NSStrokeColorAttributeName: cardBaseColor
                                      } range:textRange];
                
            } else if([setCard.shade isEqual: @"open"]) {
                
                [mat addAttributes:@{ NSForegroundColorAttributeName : [cardBaseColor colorWithAlphaComponent:0],
                                      NSStrokeWidthAttributeName: @-3,
                                      NSStrokeColorAttributeName: cardBaseColor
                                      } range:textRange];
            }
            
            setCardTextView.attributedText = mat;
            
            if(!setCard.isUnplayable){
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

@end
