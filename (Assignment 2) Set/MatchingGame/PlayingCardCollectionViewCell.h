//
//  PlayingCardCollectionViewCell.h
//  MatchingGame
//
//  Created by Felix Leupold on 6/19/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

//public API for the playing card view
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
