//
//  GameResultViewController.m
//  class2
//
//  Created by jhihguan on 13/8/21.
//  Copyright (c) 2013年 jhihguan. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@property (nonatomic) SEL sortSelector;

@end

@implementation GameResultViewController

- (void)updateUI{
    NSString *displayText = @"";
    
    //Datetime formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    
//    for (GameResult *result in [GameResult allGameResults]) {
    for (GameResult *result in [[GameResult allGameResults] sortedArrayUsingSelector:self.sortSelector]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, [formatter stringFromDate:result.end], round(result.duration)];
    }
    self.display.text = displayText;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateUI];
}

@synthesize sortSelector = _sortSelector;

- (SEL)sortSelector{
    if (!_sortSelector) _sortSelector = @selector(compareScoreToGameResult:);
    return _sortSelector;
}

- (void)setSortSelector:(SEL)sortSelector{
    _sortSelector = sortSelector;
    [self updateUI];
}
- (IBAction)sortByDate {
    self.sortSelector = @selector(compareEndDateToGameResul:);
}
- (IBAction)sortByScore {
    self.sortSelector = @selector(compareScoreToGameResult:);
}
- (IBAction)sortByDuration {
    self.sortSelector = @selector(compareDurationToGameResult:);
}

- (void)setup{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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
