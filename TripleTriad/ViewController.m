#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 103, 130)];

    NSString *imgFilepath = [[NSBundle mainBundle] pathForResource:@"104-quistis" ofType:@"png"];

    UIImage *img = [[UIImage alloc] initWithContentsOfFile:imgFilepath];

    [imgView setImage:img];

    [self.view addSubview:imgView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
