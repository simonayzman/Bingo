//
//  RLBingoGame.h
//  Bingo
//
//  Created by Simon Ayzman on 4/28/14.
//  Copyright (c) 2014 Simon Ayzman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLBingoGame : NSObject

+ (NSString *) allBingoSpaces;
- (void) resetBingoBoard;
- (NSString *) getNextSelection;
- (NSDictionary *) getBingoBoard;

@end
