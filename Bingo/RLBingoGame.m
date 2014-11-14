//
//  RLBingoGame.m
//  Bingo
//
//  Created by Simon Ayzman on 4/28/14.
//  Copyright (c) 2014 Simon Ayzman. All rights reserved.
//

#import "RLBingoGame.h"

@interface RLBingoGame()

@property (strong, nonatomic) NSMutableArray *unselectedSpaces;
@property (strong, nonatomic) NSMutableDictionary *bingoBoard;

@end

@implementation RLBingoGame

- (NSMutableArray *) unselectedSpaces
{
    if (!_unselectedSpaces)
        _unselectedSpaces = [[NSMutableArray alloc] init];
    return _unselectedSpaces;
}

- (NSMutableDictionary *) bingoBoard
{
    if (!_bingoBoard)
        _bingoBoard = [[NSMutableDictionary alloc] init];
    return _bingoBoard;
}

- (instancetype) init
{
    if (self = [super init])
    {
        for (int letterIndex = 0; letterIndex < 5; ++letterIndex)
        {
            for (int numberModulo = 1; numberModulo <= 15; ++numberModulo)
            {
                NSString *letter = @[@"B",@"I",@"N",@"G",@"O"][letterIndex];
                int number = letterIndex * 15 + numberModulo;
                NSString *bingoSpace = [NSString stringWithFormat:@"%@%d", letter, number];
                [self.bingoBoard setObject:@(1) forKey:bingoSpace];
                [self.unselectedSpaces addObject:bingoSpace];
            }
        }
    }
    return self;
}

+ (NSString *) allBingoSpaces
{
    NSString *bingoSpaces = @"";
    for (int numberModulo = 1; numberModulo <= 15; ++numberModulo)
    {
        for (int letterIndex = 0; letterIndex < 5; ++letterIndex)
        {
            NSString *letter = @[@"B",@"I",@"N",@"G",@"O"][letterIndex];
            int number = letterIndex * 15 + numberModulo;
            bingoSpaces = [bingoSpaces stringByAppendingString: [NSString stringWithFormat:@"%@%d%@%@", letter, number, @"   ", numberModulo < 10 && [letter isEqualToString:@"B"] ? @" " : @""]];
        }
        bingoSpaces = [bingoSpaces stringByAppendingString:@"\n"];
    }
    return bingoSpaces;
}

- (void) resetBingoBoard
{
    [self.bingoBoard removeAllObjects];
    [self.unselectedSpaces removeAllObjects];
    for (int letterIndex = 0; letterIndex < 5; ++letterIndex)
    {
        for (int numberModulo = 1; numberModulo <= 15; ++numberModulo)
        {
            NSString *letter = @[@"B",@"I",@"N",@"G",@"O"][letterIndex];
            int number = letterIndex * 15 + numberModulo;
            NSString *bingoSpace = [NSString stringWithFormat:@"%@%d", letter, number];
            [self.bingoBoard setObject:@(1) forKey:bingoSpace];
            [self.unselectedSpaces addObject:bingoSpace];
        }
    }
}

- (NSString *) getNextSelection
{
    if ([self.unselectedSpaces count] > 0)
    {
        NSUInteger randomSelection = arc4random() % [self.unselectedSpaces count];
        NSString *randomBingoSpace = self.unselectedSpaces[randomSelection];
        self.bingoBoard[randomBingoSpace] = @(0);
        [self.unselectedSpaces removeObjectAtIndex:randomSelection];
        return randomBingoSpace;
    }
    return nil;
}

- (NSDictionary *) getBingoBoard
{
    return [self.bingoBoard copy];
}

- (NSString *) description
{
    NSString *description = @"";
    for (int letterIndex = 0; letterIndex < 5; ++letterIndex)
    {
        for (int numberModulo = 1; numberModulo <= 15; ++numberModulo)
        {
            NSString *letter = @[@"B",@"I",@"N",@"G",@"O"][letterIndex];
            int number = letterIndex * 15 + numberModulo;
            NSString *bingoSpace = [NSString stringWithFormat:@"%@%d", letter, number];
            description = [NSString stringWithFormat: @"%@%@ : %@\n", description, bingoSpace, ([self.bingoBoard[bingoSpace] unsignedIntegerValue] == 1 ? @"Active": @"Inactive")] ;
        }
    }
    return description;
}

@end



