//
//  RIVGridLocation.h
//  Connect Four
//
//  Created by Brian Radebaugh on 7/19/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RIVGamePiece;

@interface RIVGridLocation : NSObject

@property (strong, nonatomic) RIVGamePiece *piece;

@end
