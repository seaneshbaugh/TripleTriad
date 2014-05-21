#import "Card.h"

@implementation Card

- (id)initWithImagePath:(NSString *)imagePath {
    return [self initWithImagePath:imagePath name:@"New Card" up:[NSNumber numberWithInt:1] down:[NSNumber numberWithInt:1] left:[NSNumber numberWithInt:1] right:[NSNumber numberWithInt:1] element:@""];
}

- (id)initWithImagePath:(NSString *)imagePath name:(NSString *)name {
    return [self initWithImagePath:imagePath name:name up:[NSNumber numberWithInt:1] down:[NSNumber numberWithInt:1] left:[NSNumber numberWithInt:1] right:[NSNumber numberWithInt:1] element:@""];
}

- (id)initWithImagePath:(NSString *)imagePath name:(NSString *)name up:(NSNumber *)up down:(NSNumber *)down left:(NSNumber *)left right:(NSNumber *)right {
    return [self initWithImagePath:imagePath name:name up:up down:down left:left right:right element:@""];
}

- (id)initWithImagePath:(NSString *)imagePath name:(NSString *)name up:(NSNumber *)up down:(NSNumber *)down left:(NSNumber *)left right:(NSNumber *)right element:(NSString *)element {
    self = [super init];

    self.imagePath = imagePath;

    NSString *imageFilepath = [[NSBundle mainBundle] pathForResource:imagePath ofType:@"png"];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 93, 120)];

    self.image = [[UIImage alloc] initWithContentsOfFile:imageFilepath];

    [self.imageView setImage:self.image];

    self.name = name;

    self.up = up;

    self.down = down;

    self.left = left;

    self.right = right;

    self.element = element;

    return self;
}

@end
