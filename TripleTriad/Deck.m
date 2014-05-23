#import "Deck.h"
#import "Card.h"

@implementation Deck

- (id)init {
    self = [super init];

    self.cards = [[NSMutableArray alloc] init];

    return self;
}

- (void)addCard:(Card*)card {
    card.owner = self.player;

    card.controller = self.player;

    [self.cards addObject:card];
}

@end
