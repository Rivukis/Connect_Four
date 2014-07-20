//
//  RIVGamePiece.h
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RIVGamePieceColor) {
    RIVGamePieceColorRed,
    RIVGamePieceColorBlack
};

@interface RIVGamePiece : NSObject

@property (readonly, nonatomic) RIVGamePieceColor color;

//+ (RIVGamePiece *)redPiece;
//+ (RIVGamePiece *)blackPiece;
+ (RIVGamePiece *)pieceWithColor:(RIVGamePieceColor)color;

@end