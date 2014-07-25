//
//  RIVGameBoard.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RIVGamePiece;
@class RIVPlayer;

extern const NSInteger numberOfRows;
extern const NSInteger numberOfColumns;

typedef NS_ENUM(NSInteger, RIVGameBoardPlayState) {
    RIVGameBoardPlayStateNotPlayable,
    RIVGameBoardPlayStatePlayed,
    RIVGameBoardPlayStateWinningMove
};

@interface RIVGameBoard : NSObject

@property (strong, nonatomic) NSArray *grid; // 2-Dimensional Array of RIVGridLocation
@property (strong, nonatomic) NSArray *players; // of RIVPlayer
@property (weak, nonatomic) RIVPlayer *playerToAct; // Player to Act Next

- (instancetype)initWithTwoPlayers;
- (RIVGameBoardPlayState)playGamePieceonColumn:(NSInteger)column fromPlayer:(RIVPlayer *)player;

@end