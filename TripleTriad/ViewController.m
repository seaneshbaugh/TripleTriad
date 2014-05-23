#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self->game = [[Game alloc] init];

    [self->game.player1.deck addCard:[[Card alloc] initWithImagePath:@"103-selphie-blue" name:@"Selphie" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:6] left:[NSNumber numberWithInt:4] right:[NSNumber numberWithInt:8]]];
    [self->game.player1.deck addCard:[[Card alloc] initWithImagePath:@"104-quistis-blue" name:@"Quistis" up:[NSNumber numberWithInt:9] down:[NSNumber numberWithInt:10] left:[NSNumber numberWithInt:2] right:[NSNumber numberWithInt:6]]];
    [self->game.player1.deck addCard:[[Card alloc] initWithImagePath:@"105-irvine-blue" name:@"Irvine" up:[NSNumber numberWithInt:2] down:[NSNumber numberWithInt:9] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:6]]];
    [self->game.player1.deck addCard:[[Card alloc] initWithImagePath:@"106-zell-blue" name:@"Zell" up:[NSNumber numberWithInt:8] down:[NSNumber numberWithInt:10] left:[NSNumber numberWithInt:6] right:[NSNumber numberWithInt:5]]];
    [self->game.player1.deck addCard:[[Card alloc] initWithImagePath:@"107-rinoa-blue" name:@"Rinoa" up:[NSNumber numberWithInt:4] down:[NSNumber numberWithInt:2] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:10]]];
    [self->game.player1.deck addCard:[[Card alloc] initWithImagePath:@"110-squall-blue" name:@"Squall" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:6] left:[NSNumber numberWithInt:9] right:[NSNumber numberWithInt:4]]];

    [self->game.player2.deck addCard:[[Card alloc] initWithImagePath:@"100-ward-red" name:@"Ward" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:2] left:[NSNumber numberWithInt:8] right:[NSNumber numberWithInt:7]]];
    [self->game.player2.deck addCard:[[Card alloc] initWithImagePath:@"101-kiros-red" name:@"Kiros" up:[NSNumber numberWithInt:6] down:[NSNumber numberWithInt:6] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:7]]];
    [self->game.player2.deck addCard:[[Card alloc] initWithImagePath:@"102-laguna-red" name:@"Laguna" up:[NSNumber numberWithInt:5] down:[NSNumber numberWithInt:3] left:[NSNumber numberWithInt:9] right:[NSNumber numberWithInt:10]]];
    [self->game.player2.deck addCard:[[Card alloc] initWithImagePath:@"108-edea-red" name:@"Edea" up:[NSNumber numberWithInt:10] down:[NSNumber numberWithInt:3] left:[NSNumber numberWithInt:3] right:[NSNumber numberWithInt:10]]];
    [self->game.player2.deck addCard:[[Card alloc] initWithImagePath:@"109-seifer-red" name:@"Seifer" up:[NSNumber numberWithInt:6] down:[NSNumber numberWithInt:10] left:[NSNumber numberWithInt:4] right:[NSNumber numberWithInt:9]]];
    [self->game.player2.deck addCard:[[Card alloc] initWithImagePath:@"099-eden-red" name:@"Eden" up:[NSNumber numberWithInt:4] down:[NSNumber numberWithInt:9] left:[NSNumber numberWithInt:10] right:[NSNumber numberWithInt:4]]];

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

    self->originalImagePosition.x = -1;

    self->originalImagePosition.y = -1;

    self->originalImageIndex = 0;
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

        Deck *deck;

        if (self->game.turn == YES) {
            deck = self->game.player1.deck;
        } else {
            deck = self->game.player2.deck;
        }

        for (int i = 0; i < [deck.cards count]; i++) {
            if (CGRectContainsPoint([[deck.cards objectAtIndex:i] imageView].frame, location)) {
                [possibleTouchedCards addObject:[deck.cards objectAtIndex:i]];
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

            self->originalImagePosition.x = [topCard imageView].center.x;

            self->originalImagePosition.y = [topCard imageView].center.y;

            self->originalImageIndex = [self.view.subviews indexOfObject:[topCard imageView]];

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
    UITouch *touch = [[event allTouches] anyObject];

    CGPoint location = [touch locationInView:touch.view];

    // Board offset: 240, 186
    // Board points:
    // [0, 0]: [287, 246]
    // [0, 1]: [384, 246]
    // [0, 2]: [483, 246]
    // [1, 0]: [287, 371]
    // [1, 1]: [384, 371]
    // [1, 2]: [483, 371]
    // [2, 0]: [287, 496]
    // [2, 1]: [384, 496]
    // [2, 2]: [483, 496]

    NSArray *boardPoints = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(287, 246)], [NSValue valueWithCGPoint:CGPointMake(384, 246)], [NSValue valueWithCGPoint:CGPointMake(483, 246)],
                            [NSValue valueWithCGPoint:CGPointMake(287, 371)], [NSValue valueWithCGPoint:CGPointMake(384, 371)], [NSValue valueWithCGPoint:CGPointMake(483, 371)],
                            [NSValue valueWithCGPoint:CGPointMake(287, 496)], [NSValue valueWithCGPoint:CGPointMake(384, 496)], [NSValue valueWithCGPoint:CGPointMake(483, 496)], nil];

    NSArray *boardIndicies = [NSArray arrayWithObjects:
                              [NSArray arrayWithObjects:
                               [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                               [NSValue valueWithCGPoint:CGPointMake(0, 1)],
                               [NSValue valueWithCGPoint:CGPointMake(0, 2)], nil],
                              [NSArray arrayWithObjects:
                               [NSValue valueWithCGPoint:CGPointMake(1, 0)],
                               [NSValue valueWithCGPoint:CGPointMake(1, 1)],
                               [NSValue valueWithCGPoint:CGPointMake(1, 2)], nil],
                              [NSArray arrayWithObjects:
                               [NSValue valueWithCGPoint:CGPointMake(2, 0)],
                               [NSValue valueWithCGPoint:CGPointMake(2, 1)],
                               [NSValue valueWithCGPoint:CGPointMake(2, 2)], nil], nil];

    int closestBoardPointIndex = 0;

    double closestDistanceFromBoard = sqrt((pow(location.x - [[boardPoints objectAtIndex:0] CGPointValue].x, 2) + pow(location.y - [[boardPoints objectAtIndex:0] CGPointValue].y, 2)));

    for (int i = 1; i < [boardPoints count]; i++) {
        double distanceFromBoardPoint = sqrt((pow(location.x - [[boardPoints objectAtIndex:i] CGPointValue].x, 2) + pow(location.y - [[boardPoints objectAtIndex:i] CGPointValue].y, 2)));

        if (distanceFromBoardPoint < closestDistanceFromBoard) {
            closestDistanceFromBoard = distanceFromBoardPoint;

            closestBoardPointIndex = i;
        }
    }

    CGPoint boardIndex;

    [[[boardIndicies objectAtIndex:(closestBoardPointIndex / 3)] objectAtIndex:(closestBoardPointIndex % 3)] getValue:&boardIndex];

    if (closestDistanceFromBoard > 50 || [self->game.board cardAt:boardIndex]) {
        [self.view insertSubview:[currentCard imageView] atIndex:self->originalImageIndex];

        [UIView animateWithDuration:0.35
                              delay:0.0
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             [[currentCard imageView] setCenter:self->originalImagePosition];
                         }
                         completion:nil];
    } else {
        [UIView animateWithDuration:0.35
                              delay:0.0
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             [currentCard imageView].center = [[boardPoints objectAtIndex:closestBoardPointIndex] CGPointValue];
                         }
                         completion:nil];

        [self->game.board putCard:currentCard atPoint:boardIndex];

        self->player1Score.text = [NSString stringWithFormat:@"%tu", [self->game scoreForPlayer:self->game.player1]];

        self->player2Score.text = [NSString stringWithFormat:@"%tu", [self->game scoreForPlayer:self->game.player2]];

        self->game.turn = !self->game.turn;
    }

    self->startTouchPosition.x = -1;

    self->startTouchPosition.y = -1;

    self->startImagePosition.x = -1;

    self->startImagePosition.y = -1;

    self->originalImagePosition.x = -1;

    self->originalImagePosition.y = -1;

    self->currentCard = nil;
}

@end
