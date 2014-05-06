//
//  RIVMainViewController.m
//  Connect Four
//
//  Created by Brian Radebaugh on 5/5/14.
//  Copyright (c) 2014 Brian Radebaugh. All rights reserved.
//

#import "RIVMainViewController.h"
#import "RIVGameBoard.h"

@interface RIVMainViewController ()

@property (strong, nonatomic) RIVGameBoard *gameboard;

@end

@implementation RIVMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (RIVGameBoard *)gameboard
{
    if (!_gameboard) _gameboard = [RIVGameBoard new];
    return _gameboard;
}



@end
