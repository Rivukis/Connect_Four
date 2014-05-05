//
//  RIVGameBoard.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVGameBoard.h"
#import "RIVPlayer.h"

@implementation RIVGameBoard

- (instancetype)initWithPlayers
{
    self = [super init];
    if (self) {
        RIVPlayer *firstPlayer = [[RIVPlayer alloc] initWithColor:[UIColor blackColor]];
        RIVPlayer *secondPlayer = [[RIVPlayer alloc] initWithColor:[UIColor redColor]];
        self.players = @[firstPlayer, secondPlayer];
    }
    return self;
}

@end
