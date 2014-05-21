#import <Foundation/Foundation.h>
#import "Player.h"
#import "Board.h"

@interface Game : NSObject

@property (strong, nonatomic) Board *board;

@property (strong, nonatomic) Player *player1;

@property (strong, nonatomic) Player *player2;

- (id)init;

@end
