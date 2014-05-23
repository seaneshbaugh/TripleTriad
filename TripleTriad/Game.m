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

- (NSUInteger)scoreForPlayer:(Player *)player {
    NSUInteger result = 0;

    for (int x = 0; x < [self.board.cards count]; x++) {
        for (int y = 0; y < [[self.board.cards objectAtIndex:x] count]; y++) {
            if ((id)[[self.board.cards objectAtIndex:x] objectAtIndex:y] != [NSNull null] && [[[[self.board.cards objectAtIndex:x] objectAtIndex:y] controller] isEqual:player]) {
                result += 1;
            }
        }
    }

    return result;
}

@end
