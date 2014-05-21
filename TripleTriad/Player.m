#import "Player.h"

@implementation Player

- (id)init {
    self = [super init];

    self.deck = [[Deck alloc] init];

    return self;
}

@end
