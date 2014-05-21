#import "Deck.h"

@implementation Deck

- (id)init {
    self = [super init];

    self.cards = [[NSMutableArray alloc] init];

    return self;
}

@end
