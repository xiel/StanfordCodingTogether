//
//  CardGameViewController.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/17/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()

//outlets
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeSwitch;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

//instance properties
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGameViewController

- (GameResult *)gameResult {
    if(!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

//lazy instantiation for the game
- (CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
    
    //set match mode like switch
    [_game setMatchMode:self.matchModeSwitch.selectedSegmentIndex+2];
    
    return _game;
}

//implement the setter for the cardButtons, even this proptery is set by iOS to the array of buttons
- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

//method the keep the UI insync with our model
- (void)updateUI {
    
    NSLog(@"MatchMode: %d", self.game.matchMode);
    
    //create cardback iamge object
    
    
    for(UIButton *cardButton in self.cardButtons){
        //get the card from the game stack
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        //set the button titles for the different states
        [cardButton setTitle:nil forState:UIControlStateNormal];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        //add cardback to normal state
        UIImage *cardBackImage = card.isFaceUp ? nil :[UIImage imageNamed:@"cardback.png"];
        cardButton.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        
        //update buttons status
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable; //disable the button, if the card is unplayable
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0; //make the button semi-transparent when it is disabled
    }
    
    //update the flipsLabel accordanctly
    //by creating a new NSString with Format, %d = description
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
    //update the score label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    //update the flip result label
    self.flipResultLabel.text = self.game.lastFlipResult;
    
    //enable or disable the switch
    self.matchModeSwitch.enabled = self.flipCount == 0 ? YES : NO;
    
}

//define the setter for flipCount
- (void)setFlipCount:(int)flipCount {
    
    //update the instance variable (~ property value)
    _flipCount = flipCount;

    //how to log something
    //NSLog(@"flipCount was updated to %d", self.flipCount);
}


- (IBAction)flipCard:(UIButton *)sender {
    //let the game model do the flipping
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    //update the counter when card is flipped (calls setter and getter)
    self.flipCount++;
    
    //update game result
    self.gameResult.score = self.game.score;
    
    //update the UI whenever a card is flipped
    [self updateUI];
}

- (IBAction)dealNewCards {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)updateMatchMode:(id)sender {
    
    // The segmented control was clicked, handle it here
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    [self.game setMatchMode:segmentedControl.selectedSegmentIndex+2];
    
    NSLog(@"New MatchMode: %d", self.game.matchMode);
    
}

@end
