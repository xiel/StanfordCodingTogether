//
//  CardGameViewController.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController () <UICollectionViewDataSource>

//outlets
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

//instance properties
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation CardGameViewController

//gives the subclass the possibility to update the cell
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate {
    //abstract
}

//abstract
+ (int)matchMode {
    return 0;
}

//creates a deck for the game to be played
- (Deck *)createDeck {
    return nil; //abstract - this class won't work if it is not implemented in subclass
}

- (void)updateFlipResultLabel:(UILabel*)label usingCards:(NSArray *)cards scored:(int)score {
    //abstract
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return [self.game numberOfCardsInPlay]; //ask the game how many cards are actually in play
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    
    [self updateCell:cell usingCard:card animate:NO];
    return cell;
}

- (GameResult *)gameResult {
    if(!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

//lazy instantiation for the game
- (CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                         usingDeck:[self createDeck]];
    _game.matchMode = [[self class] matchMode];
    
    return _game;
}

//method the keep the UI insync with our model
- (void)updateUI {
    
    //NEW UPDATE UI for cards
    for(UICollectionViewCell *cell in [self.cardCollectionView visibleCells]){
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        
        //maybe move to update cell
//        if(card.isUnplayable){
//            [self.game removeCardAtIndex:indexPath.item];
//            [self.cardCollectionView deleteItemsAtIndexPaths:@[indexPath]];
//        } else {
//            
//        }
        
        [self updateCell:cell usingCard:card animate: card.animateFlip ? YES : NO ];
        card.animateFlip = NO;
    }
    
    //update the flipsLabel accordanctly by creating a new NSString with Format, %d = description
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
    //update the score label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    //update the flip result label
    [self updateFlipResultLabel:self.flipResultLabel usingCards:self.game.latestFlippedCards scored:self.game.latestFlippedScore];
}

//define the setter for flipCount
- (void)setFlipCount:(int)flipCount {
    //update the instance variable (~ property value)
    _flipCount = flipCount;
}


- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    
    NSLog(@"flipcard!");
    
    //get the tap location and the index of the card
    CGPoint tabLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tabLocation];
    
    if(indexPath){
        
         NSLog(@"we have index path!");
        
        //let the game model do the flipping
        [self.game flipCardAtIndex:indexPath.item];
        
        //update the counter when card is flipped (calls setter and getter)
        self.flipCount++;
        
        //update game result
        self.gameResult.score = self.game.score;
        
        //update the UI whenever a card is flipped
        [self updateUI];
    }
}

- (IBAction)addMoreCards:(id)sender {
    
    [self.game addAdditionalCardToGame];
    [self.cardCollectionView reloadData];
    [self updateUI];
    
}

//redeal cards / restart the game
- (IBAction)dealNewCards {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self.cardCollectionView reloadData];
    [self updateUI];
}

@end
