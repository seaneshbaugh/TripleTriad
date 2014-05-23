#import "Player.h"

@implementation Player

- (id)init {
    self = [super init];

    self.name = @"Player";

    self.deck = [[Deck alloc] init];

    self.deck.player = (Player *)self;

    return self;
}

@end
