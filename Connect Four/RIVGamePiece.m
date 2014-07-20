//
//  RIVGamePiece.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVGamePiece.h"

@interface RIVGamePiece ()

@property (assign, nonatomic) RIVGamePieceColor color;

@end

@implementation RIVGamePiece

//+ (RIVGamePiece *)redPiece
//{
//    return  [RIVGamePiece pieceWithColor:RIVGamePieceColorRed];
//}
//
//+ (RIVGamePiece *)blackPiece
//{
//    return  [RIVGamePiece pieceWithColor:RIVGamePieceColorBlack];
//}

+ (RIVGamePiece *)pieceWithColor:(RIVGamePieceColor)color
{
    RIVGamePiece *newPiece = [RIVGamePiece new];
    newPiece.color = color;
    
    return newPiece;
}

@end
