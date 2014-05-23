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

    [self checkForFlipsAt:point];
}

- (void)checkForFlipsAt:(CGPoint)point {
    Card *card = (Card *)[[self.cards objectAtIndex:point.x] objectAtIndex:point.y];

    NSLog(@"Checking for flips for %@ at [%d, %d]", card.name, (int)point.x, (int)point.y);

    Card *otherCard;

    if (point.x > 0 && [self cardAt:CGPointMake(point.x - 1, point.y)]) {
        otherCard = (Card *)[[self.cards objectAtIndex:(point.x - 1)] objectAtIndex:point.y];

        NSLog(@"Found %@ above at [%d, %d]", otherCard.name, (int)point.x - 1, (int)point.y);

        if (![card.controller isEqual:otherCard.controller] && [card.up intValue] > [otherCard.down intValue]) {
            NSLog(@"%@ controls %@, %@ controls %@ AND %d is > %d, flipping %@", card.controller.name, card.name, otherCard.controller.name, otherCard.name, [card.up intValue], [otherCard.down intValue], otherCard.name);

            [self flipCard:otherCard toController:card.controller];

            [self checkForFlipsAt:CGPointMake(point.x - 1, point.y)];
        }
    }

    if (point.x < 2 && [self cardAt:CGPointMake(point.x + 1, point.y)]) {
        otherCard = (Card *)[[self.cards objectAtIndex:(point.x + 1)] objectAtIndex:point.y];

        NSLog(@"Found %@ below at [%d, %d]", otherCard.name, (int)point.x + 1, (int)point.y);

        if (![card.controller isEqual:otherCard.controller] && [card.down intValue] > [otherCard.up intValue]) {
            NSLog(@"%@ controls %@, %@ controls %@ AND %d is > %d, flipping %@", card.controller.name, card.name, otherCard.controller.name, otherCard.name, [card.down intValue], [otherCard.up intValue], otherCard.name);

            [self flipCard:otherCard toController:card.controller];

            [self checkForFlipsAt:CGPointMake(point.x + 1, point.y)];
        }
    }

    if (point.y > 0 && [self cardAt:CGPointMake(point.x, point.y - 1)]) {
        otherCard = (Card *)[[self.cards objectAtIndex:point.x] objectAtIndex:(point.y - 1)];

        NSLog(@"Found %@ to the left at [%d, %d]", otherCard.name, (int)point.x, (int)point.y - 1);

        NSLog(@"card.controler != otherCard.controller: %d. %d(%@) > %d(%@): %d", ![card.controller isEqual:otherCard.controller], [card.left intValue], card.name, [otherCard.right intValue], otherCard.name, [card.left intValue] > [otherCard.right intValue]);

        if (![card.controller isEqual:otherCard.controller] && [card.left intValue] > [otherCard.right intValue]) {
            NSLog(@"%@ controls %@, %@ controls %@ AND %d is > %d, flipping %@", card.controller.name, card.name, otherCard.controller.name, otherCard.name, [card.left intValue], [otherCard.right intValue], otherCard.name);

            [self flipCard:otherCard toController:card.controller];

            [self checkForFlipsAt:CGPointMake(point.x, point.y - 1)];
        }
    }

    if (point.y < 2 && [self cardAt:CGPointMake(point.x, point.y + 1)]) {
        otherCard = (Card *)[[self.cards objectAtIndex:point.x] objectAtIndex:(point.y + 1)];

        NSLog(@"Found %@ to the right at [%d, %d]", otherCard.name, (int)point.x, (int)point.y + 1);

        NSLog(@"card.controler != otherCard.controller: %d. %d(%@) > %d(%@): %d", ![card.controller isEqual:otherCard.controller], [card.right intValue], card.name, [otherCard.left intValue], otherCard.name, [card.right intValue] > [otherCard.left intValue]);

        if (![card.controller isEqual:otherCard.controller] && [card.right intValue] > [otherCard.left intValue]) {
            NSLog(@"%@ controls %@, %@ controls %@ AND %d is > %d, flipping %@", card.controller.name, card.name, otherCard.controller.name, otherCard.name, [card.right intValue], [otherCard.left intValue], otherCard.name);

            [self flipCard:otherCard toController:card.controller];

            [self checkForFlipsAt:CGPointMake(point.x, point.y + 1)];
        }
    }
}


- (void)flipCard:(Card *)card toController:(Player *)controller {
    card.controller = controller;

    NSMutableArray *parts = [NSMutableArray arrayWithArray:[card.imagePath componentsSeparatedByString:@"-"]];

    NSString *color = [parts lastObject];

    NSString *newColor;

    if ([color isEqual: @"blue"]) {
        newColor = @"red";
    } else {
        newColor = @"blue";
    }

    [parts removeObjectAtIndex:([parts count] - 1)];

    NSString *newImagePath = [[[parts componentsJoinedByString:@"-"] stringByAppendingString:@"-"] stringByAppendingString:newColor];

    card.imagePath = newImagePath;

    NSString *imageFilepath = [[NSBundle mainBundle] pathForResource:newImagePath ofType:@"png"];

    card.image = [[UIImage alloc] initWithContentsOfFile:imageFilepath];

    UIView *myView = [card imageView];

    CALayer *layer = myView.layer;

    CATransform3D transform = CATransform3DIdentity;

    transform.m34 = 1.0 / -500;

    layer.transform = transform;

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 0 * M_PI / 2, 0, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 1 * M_PI / 2, 0, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 2 * M_PI / 2, 0, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 3 * M_PI / 2, 0, 1, 0)],
                        [NSValue valueWithCATransform3D:CATransform3DRotate(transform, 4 * M_PI / 2, 0, 1, 0)], nil];

    animation.duration = 0.3;

    [layer addAnimation:animation forKey:animation.keyPath];

    [card.imageView setImage:card.image];
}

@end
