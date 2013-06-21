//
//  GameResultsViewController.m
//  MatchingGame
//
//  Created by Felix Leupold on 6/18/13.
//  Copyright (c) 2013 xiel. All rights reserved.
//

#import "GameResultsViewController.h"
#import "GameResult.h"

@interface GameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultsViewController

//initialiation that can't wait until view did load
- (void)setup {
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) awakeFromNib {
    [self setup];
}

- (void)updateUI {
    NSString *displayText = @"";
    
    for(GameResult *result in [GameResult allGameResults]){
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %f)\n", result.score, result.end, round(result.duration) ];
    }
    self.display.text = displayText;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    // Custom initialization
    [self setup];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
