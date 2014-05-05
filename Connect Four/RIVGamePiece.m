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
    RIVGamePiece *newPiece = [RIVGamePiece new];
    newPiece.color = [UIColor redColor];
    return newPiece;
}

+ (RIVGamePiece *)blackPiece
{
    RIVGamePiece *newPiece = [RIVGamePiece new];
    newPiece.color = [UIColor blackColor];
    return  newPiece;
}

@end
