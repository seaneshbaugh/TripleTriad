#import <UIKit/UIKit.h>
#import "Game.h"
#import "Card.h"

@interface ViewController : UIViewController {
    IBOutlet UIImageView *boardBackgroundImage;

    // This doesn't seem to be where I should put this but I have no idea how else to do it yet.
    Game *game;

    CGPoint startTouchPosition;

    CGPoint startImagePosition;

    CGPoint originalImagePosition;

    NSUInteger originalImageIndex;

    Card *currentCard;
}

@end
