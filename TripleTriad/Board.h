#import <Foundation/Foundation.h>
#import "Card.h"

@interface Board : NSObject

@property (strong, nonatomic) NSArray *cards;

- (id)init;

- (BOOL)cardAt:(CGPoint)point;

- (void)putCard:(Card *)card atPoint:(CGPoint)point;

- (void)checkForFlipsAt:(CGPoint)point;

- (void)flipCard:(Card *)card toController:(Player *)controller;

@end
