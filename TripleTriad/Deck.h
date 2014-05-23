#import <Foundation/Foundation.h>
@class Card;
@class Player;

@interface Deck : NSObject

@property (weak, nonatomic) Player *player;

@property (strong, nonatomic) NSMutableArray *cards;

- (id)init;

- (void)addCard:(Card *)card;

@end
