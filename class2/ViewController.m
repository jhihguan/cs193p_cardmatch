//
//  ViewController.m
//  class2
//
//  Created by jhihguan on 13/8/14.
//  Copyright (c) 2013年 jhihguan. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cards;
@property (weak, nonatomic) IBOutlet UILabel *flipCount;
@property (nonatomic) int flip;
@property (strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation ViewController

-(CardMatchingGame *)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cards.count usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

-(void)setCards:(NSArray *)cards{
    _cards = cards;
    [self updateUI];
}

-(void)updateUI{
    for (UIButton* cardButton in self.cards) {
        Card *card = [self.game cardAtIndex:[self.cards indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cards indexOfObject:sender]];
    self.flip++;
    [self updateUI];
}

-(void)setFlip:(int)flip{
    _flip = flip;
    self.flipCount.text = [NSString stringWithFormat:@"Flips: %d",self.flip];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
