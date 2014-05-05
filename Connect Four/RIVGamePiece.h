//
//  RIVGamePiece.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RIVPlayer, RIVGameBoard;

@interface RIVGamePiece : NSObject

@property (strong, nonatomic) UIColor *color;
@property (weak, nonatomic) RIVPlayer *player;
@property (strong, nonatomic) NSIndexPath *indexPath;
//@property (nonatomic) NSInteger column;
//@property (nonatomic) NSInteger row;

//@property (weak, nonatomic) RIVGameBoard *gameboard;

+ (RIVGamePiece *)redPiece;
+ (RIVGamePiece *)blackPiece;

@end
