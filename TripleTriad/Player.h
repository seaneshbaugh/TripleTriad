#import <Foundation/Foundation.h>
#import "Deck.h"

@interface Player : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) Deck *deck;

- (id)init;

@end
