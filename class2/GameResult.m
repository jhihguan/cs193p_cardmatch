//
//  GameResult.m
//  class2
//
//  Created by jhihguan on 13/8/21.
//  Copyright (c) 2013年 jhihguan. All rights reserved.
//

#import "GameResult.h"

@interface GameResult ()

@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;

@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"

+ (NSArray *)allGameResults{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    return allGameResults;
}

// convenience initializer
- (id)initFromPropertyList:(id)plist{
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            if (!_start || !_end) {
                self = nil;
            }
            
        }
    }
    
    return self;
    
}

- (void)synchronize {
    NSMutableDictionary *mutableGameResultFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    if (!mutableGameResultFromUserDefaults) mutableGameResultFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (id)asPropertyList{
    return @{ START_KEY : self.start, END_KEY:self.end, SCORE_KEY : @(self.score) };
}


// designated initializer
-(id)init{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
}

-(NSTimeInterval)duration{
    return [self.end timeIntervalSinceDate:self.start];
}

-(void)setScore:(int)score{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
    
}

-(NSComparisonResult)compareScoreToGameResult:(GameResult *)otherResult{
    if (self.score > otherResult.score) {
        return NSOrderedAscending;
    }else if (self.score == otherResult.score) {
        return NSOrderedSame;
    }else {
        return NSOrderedDescending;
    }
}

- (NSComparisonResult)compareEndDateToGameResul:(GameResult *)otherResult{
    return [otherResult.end compare:self.end];
}

- (NSComparisonResult)compareDurationToGameResult:(GameResult *)otherResult{
    if (self.duration > otherResult.duration) {
        return NSOrderedDescending;
    }else if (self.duration == otherResult.duration) {
        return NSOrderedSame;
    }else{
        return NSOrderedAscending;
    }
}

@end
