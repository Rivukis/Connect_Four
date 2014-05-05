//
//  RIVGameBoard.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVGameBoard.h"
#import "RIVPlayer.h"
#import "RIVGamePiece.h"

@implementation RIVGameBoard

- (instancetype)initWithPlayers
{
    self = [super init];
    if (self) {
        RIVPlayer *firstPlayer = [[RIVPlayer alloc] initWithColor:[UIColor blackColor] andPieceCount:21];
        RIVPlayer *secondPlayer = [[RIVPlayer alloc] initWithColor:[UIColor redColor] andPieceCount:21];
        self.players = @[firstPlayer, secondPlayer];
        
        
    }
    return self;
}

- (NSArray *)pieces
{
    if (!_pieces) {
        NSMutableArray *tempArray = [NSMutableArray new];
        
//        for (NSInteger i = 0; i < 42; i++) {
//            RIVGamePiece *tempPiece = [RIVGamePiece new];
//            tempPiece.gameboard = self;
//            [tempArray addObject:tempPiece];
//        }
        
        for (RIVPlayer *player in self.players) {
            [tempArray addObjectsFromArray:player.gamePieces];
        }
        
        _pieces = tempArray;
    }
    
    return _pieces;
}

@end
