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

- (BOOL)cardAt:(CGPoint)point {
    if ((id)[[self.cards objectAtIndex:point.x] objectAtIndex:point.y] == [NSNull null]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)putCard:(Card *)card atPoint:(CGPoint)point {
    [[self.cards objectAtIndex:point.x] replaceObjectAtIndex:point.y withObject:card];
}

@end
