#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self->game = [[Game alloc] init];

    [self->game.player1.deck.cards addObject:[[Card alloc] initWithImagePath:@"103-selphie" name:@"Selphie" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:6] left:[NSNumber numberWithInt:4] right:[NSNumber numberWithInt:8]]];
    [self->game.player1.deck.cards addObject:[[Card alloc] initWithImagePath:@"104-quistis" name:@"Quistis" up:[NSNumber numberWithInt:9] down:[NSNumber numberWithInt:10] left:[NSNumber numberWithInt:2] right:[NSNumber numberWithInt:6]]];
    [self->game.player1.deck.cards addObject:[[Card alloc] initWithImagePath:@"105-irvine" name:@"Irvine" up:[NSNumber numberWithInt:2] down:[NSNumber numberWithInt:9] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:6]]];
    [self->game.player1.deck.cards addObject:[[Card alloc] initWithImagePath:@"106-zell" name:@"Zell" up:[NSNumber numberWithInt:8] down:[NSNumber numberWithInt:10] left:[NSNumber numberWithInt:6] right:[NSNumber numberWithInt:5]]];
    [self->game.player1.deck.cards addObject:[[Card alloc] initWithImagePath:@"107-rinoa" name:@"Rinoa" up:[NSNumber numberWithInt:4] down:[NSNumber numberWithInt:2] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:10]]];
    [self->game.player1.deck.cards addObject:[[Card alloc] initWithImagePath:@"110-squall" name:@"Squall" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:6] left:[NSNumber numberWithInt:9] right:[NSNumber numberWithInt:4]]];

    [self->game.player2.deck.cards addObject:[[Card alloc] initWithImagePath:@"100-ward" name:@"Ward" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:2] left:[NSNumber numberWithInt:8] right:[NSNumber numberWithInt:7]]];
    [self->game.player2.deck.cards addObject:[[Card alloc] initWithImagePath:@"101-kiros" name:@"Kiros" up:[NSNumber numberWithInt:6] down:[NSNumber numberWithInt:6] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:7]]];
    [self->game.player2.deck.cards addObject:[[Card alloc] initWithImagePath:@"102-laguna" name:@"Laguna" up:[NSNumber numberWithInt:5] down:[NSNumber numberWithInt:3] left:[NSNumber numberWithInt:9] right:[NSNumber numberWithInt:10]]];
    [self->game.player2.deck.cards addObject:[[Card alloc] initWithImagePath:@"108-edea" name:@"Edea" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:3] left:[NSNumber numberWithInt:3] right:[NSNumber numberWithInt:10]]];
    [self->game.player2.deck.cards addObject:[[Card alloc] initWithImagePath:@"109-seifer" name:@"Seifer" up:[NSNumber numberWithInt:6] down:[NSNumber numberWithInt:10] left:[NSNumber numberWithInt:4] right:[NSNumber numberWithInt:9]]];
    [self->game.player2.deck.cards addObject:[[Card alloc] initWithImagePath:@"099-eden" name:@"Eden" up:[NSNumber numberWithInt:4] down:[NSNumber numberWithInt:9] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:4]]];

    for (int i = 0; i < [self->game.player1.deck.cards count]; i++) {
        [[self->game.player1.deck.cards objectAtIndex:i] imageView].frame = CGRectMake(40, 40 + (60 * i), 93, 120);

        [self.view addSubview:[[self->game.player1.deck.cards objectAtIndex:i] imageView]];
    }

    for (int i = 0; i < [self->game.player2.deck.cards count]; i++) {
        [[self->game.player2.deck.cards objectAtIndex:i] imageView].frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 133, 40 + (60 * i), 93, 120);

        [self.view addSubview:[[self->game.player2.deck.cards objectAtIndex:i] imageView]];
    }

    self->startTouchPosition.x = -1;

    self->startTouchPosition.y = -1;

    self->startImagePosition.x = -1;

    self->startImagePosition.y = -1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];

    CGPoint location = [touch locationInView:touch.view];

    if (self->startTouchPosition.x == -1 && self->startTouchPosition.y == -1) {
        NSMutableArray *possibleTouchedCards = [[NSMutableArray alloc] init];

        for (int i = 0; i < [self->game.player1.deck.cards count]; i++) {
            if (CGRectContainsPoint([[self->game.player1.deck.cards objectAtIndex:i] imageView].frame, location)) {
                [possibleTouchedCards addObject:[self->game.player1.deck.cards objectAtIndex:i]];
            }
        }

        if ([possibleTouchedCards count] > 0) {
            Card *topCard = [possibleTouchedCards objectAtIndex:0];

            int viewIndex = [[self.view subviews] indexOfObject:[topCard imageView]];

            for (int i = 1; i < [possibleTouchedCards count]; i++) {
                if ([[self.view subviews] indexOfObject:[[possibleTouchedCards objectAtIndex:i] imageView]] > viewIndex) {
                    topCard = [possibleTouchedCards objectAtIndex:i];

                    viewIndex = [[self.view subviews] indexOfObject:[topCard imageView]];
                }
            }

            self->startTouchPosition.x = location.x;

            self->startTouchPosition.y = location.y;

            self->startImagePosition.x = [topCard imageView].center.x;

            self->startImagePosition.y = [topCard imageView].center.y;

            self->currentCard = topCard;

            [self.view bringSubviewToFront:[topCard imageView]];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self->startTouchPosition.x != -1 && self->startTouchPosition.y != -1) {
        UITouch *touch = [[event allTouches] anyObject];

        CGPoint location = [touch locationInView:touch.view];

        [self->currentCard imageView].center = CGPointMake(self->startImagePosition.x - (self->startTouchPosition.x - location.x), self->startImagePosition.y - (self->startTouchPosition.y - location.y));
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self->startTouchPosition.x = -1;

    self->startTouchPosition.y = -1;

    self->startImagePosition.x = -1;

    self->startImagePosition.y = -1;

    self->currentCard = nil;
}

@end
