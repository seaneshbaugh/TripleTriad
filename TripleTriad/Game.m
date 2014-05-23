#import "Game.h"

@implementation Game

- (id)init {
    self = [super init];

    self.board = [[Board alloc] init];

    self.player1 = [[Player alloc] init];

    self.player1.name = @"Player 1";

    self.player2 = [[Player alloc] init];

    self.player2.name = @"Player 2";

    self.turn = YES;

    return self;
}

@end
