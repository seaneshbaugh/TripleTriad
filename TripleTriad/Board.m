#import "Board.h"

@implementation Board

- (id)init {
    self = [super init];

    self.cards = [NSArray arrayWithObjects:
                  [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], nil],
                  [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], nil],
                  [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], nil], nil];

    return self;
}

@end
