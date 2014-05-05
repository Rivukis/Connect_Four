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
#import "RIVPlaySpot.h"

@implementation RIVGameBoard

- (instancetype)initWithPlayers
{
    self = [super init];
    if (self) {
        RIVPlayer *firstPlayer = [[RIVPlayer alloc] initWithColor:[UIColor blackColor] andPieceCount:21];
        RIVPlayer *secondPlayer = [[RIVPlayer alloc] initWithColor:[UIColor redColor] andPieceCount:21];
//        firstPlayer.gameboard = self;
//        secondPlayer.gameboard = self;
        self.players = @[firstPlayer, secondPlayer];
    }
    return self;
}

- (NSMutableArray *)playedPieces
{
    if (!_playedPieces) {
        _playedPieces = [NSMutableArray new];
    }
    return _playedPieces;
}

- (void)playPlayers:(RIVPlayer *)player gamePiece:(RIVGamePiece *)gamePiece atIndex:(NSIndexPath *)indexPath
{
    
}

- (NSArray *)spots
{
//    Columns
//    
//    6
//    5
//    4
//    3
//    2
//    1, 2, 3, 4, 5, 6, 7   Rows
    
    if (!_spots) {
        NSMutableArray *columns = [NSMutableArray new];
        NSMutableArray *rows;
        RIVPlaySpot *spot;
        
        for (NSInteger col = 0; col < 7; col++) {
            rows = [NSMutableArray new];
            for (NSInteger row = 0; row < 6; row++) {
                spot = [RIVPlaySpot new];
                [rows addObject:spot];
            }
            [columns addObject:[rows copy]];
        }
        _spots = [columns copy];
    }
    return _spots;
}







//- (NSArray *)pieces
//{
////    NSMutableArray *tempArray = [NSMutableArray new];
////    for (RIVPlayer *player in self.players) {
////        [tempArray addObjectsFromArray:player.gamePieces];
////    }
////    return tempArray;
//    
//    
//    if (!_pieces) {
//        NSMutableArray *tempArray = [NSMutableArray new];
//        for (RIVPlayer *player in self.players) {
////            for (RIVGamePiece *piece in player.gamePieces) piece.gameboard = self;
//            [tempArray addObjectsFromArray:player.unplayedPieces];
//        }
//        _pieces = tempArray;
//    }
//    
//    return _pieces;
//}

@end
