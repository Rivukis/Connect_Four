//
//  RIVPlayer.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVPlayer.h"
#import "RIVGamePiece.h"

@interface RIVPlayer ()

@property (strong, nonatomic) NSMutableArray *unplayedPieces;
@property (assign, nonatomic) RIVGamePieceColor color;

@end

@implementation RIVPlayer

- (instancetype)initWithColor:(RIVGamePieceColor)color andPieceCount:(NSInteger)count
{
    self = [super init];
    if (self) {
        self.color = color;
        
        self.unplayedPieces = [NSMutableArray new];
        for (NSInteger i = 0; i < count; i++) {
            RIVGamePiece *newPiece = [RIVGamePiece pieceWithColor:color];
            [self.unplayedPieces addObject:newPiece];
        }
    }
    return self;
}

- (void)removePieceFromPlayerPool
{
    if (self.unplayedPieces.count) [self.unplayedPieces removeLastObject];
}

@end
