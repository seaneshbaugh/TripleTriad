#import "Game.h"

@implementation Game

- (id)init {
    self = [super init];

    self.board = [[Board alloc] init];

    self.player1 = [[Player alloc] init];

    self.player2 = [[Player alloc] init];

    return self;
}

@end
