#import <Foundation/Foundation.h>
#include "deck.h"

@interface Player : NSObject

@property (strong, nonatomic) Deck *deck;

- (id)init;

@end
