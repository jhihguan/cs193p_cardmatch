//
//  Deck.h
//  class2
//
//  Created by jhihguan on 13/8/14.
//  Copyright (c) 2013年 jhihguan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *) drawRandomCard;

@end
