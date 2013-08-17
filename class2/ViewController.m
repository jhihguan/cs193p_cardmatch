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
@property (strong,nonatomic) Deck *deck;
@property (nonatomic) int flip;
@property (strong,nonatomic) CardMatchingGame *game;
@end

@implementation ViewController

-(Deck *)deck{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

-(CardMatchingGame *)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cards.count usingDeck:self.deck];
    }
    return _game;
}

-(void)setCards:(NSArray *)cards{
    _cards = cards;
    for (UIButton *cardButto in cards) {
        Card *card = [self.deck drawRandomCard];
        [cardButto setTitle:card.contents forState:UIControlStateSelected];
    }
}

- (IBAction)flipCard:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.flip++;
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
