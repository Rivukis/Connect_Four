//
//  RIVGamePiece.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVGamePiece.h"

@implementation RIVGamePiece

+ (RIVGamePiece *)redPiece
{
    return  [RIVGamePiece pieceWithColor:[UIColor redColor]];
}

+ (RIVGamePiece *)blackPiece
{
    return  [RIVGamePiece pieceWithColor:[UIColor blackColor]];
}

+ (RIVGamePiece *)pieceWithColor:(UIColor *)color
{
    RIVGamePiece *newPiece = [RIVGamePiece new];
    newPiece.color = color;
    
    return newPiece;
}

@end
