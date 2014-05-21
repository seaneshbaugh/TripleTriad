#import <Foundation/Foundation.h>
#import "Player.h"

@interface Card : NSObject

@property (strong, nonatomic) NSString *imagePath;

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSNumber *up;

@property (strong, nonatomic) NSNumber *down;

@property (strong, nonatomic) NSNumber *left;

@property (strong, nonatomic) NSNumber *right;

@property (strong, nonatomic) NSString *element;

@property (weak, nonatomic) Player *owner;

@property (weak, nonatomic) Player *controller;

- (id)initWithImagePath:(NSString *)imagePath;

- (id)initWithImagePath:(NSString *)imagePath name:(NSString *)name;

- (id)initWithImagePath:(NSString *)imagePath name:(NSString *)name up:(NSNumber *)up down:(NSNumber *)down left:(NSNumber *)left right:(NSNumber *)right;

- (id)initWithImagePath:(NSString *)imagePath name:(NSString *)name up:(NSNumber *)up down:(NSNumber *)down left:(NSNumber *)left right:(NSNumber *)right element:(NSString *)element;

@end
