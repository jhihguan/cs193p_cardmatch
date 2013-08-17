//
//  Card.h
//  class2
//
//  Created by jhihguan on 13/8/14.
//  Copyright (c) 2013年 jhihguan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;
@property (nonatomic,getter = isFaceUp) BOOL faceUp;
@property (nonatomic,getter = isUnplayable) BOOL unplayable;

-(int) match:(NSArray *)otherCards;

@end
