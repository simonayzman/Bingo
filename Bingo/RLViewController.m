//
//  RLViewController.m
//  Bingo
//
//  Created by Simon Ayzman on 4/28/14.
//  Copyright (c) 2014 Simon Ayzman. All rights reserved.
//

#import "RLViewController.h"
#import "RLBingoGame.h"

@interface RLViewController ()

@property (strong, nonatomic) RLBingoGame *game;
@property (weak, nonatomic) IBOutlet UILabel *letterLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectedBallLabel;
@property (weak, nonatomic) IBOutlet UIButton *randomBallButton;

@end

@implementation RLViewController

- (RLBingoGame *)game
{
    if (!_game)
        _game = [[RLBingoGame alloc] init];
    return _game;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) setup
{
    self.randomBallButton.enabled = YES;
    self.selectedBallLabel.text = @"";
    self.letterLabel.attributedText = [[NSAttributedString alloc]
                                       initWithString: [RLBingoGame allBingoSpaces]
                                       attributes:@{NSFontAttributeName            : [UIFont fontWithName:@"Menlo" size:42],
                                                    NSForegroundColorAttributeName : [UIColor colorWithRed:.4 green:.2 blue:.3 alpha:.4]}];
}
- (IBAction)selectRandomBingoBall
{
    NSString *selectedBingoBall = [self.game getNextSelection];
    if (selectedBingoBall)
    {
        self.selectedBallLabel.text = selectedBingoBall;
        
        NSMutableAttributedString *letterLabelText = [[NSMutableAttributedString alloc] initWithAttributedString: self.letterLabel.attributedText];
        NSString *unparsedLabelText = [letterLabelText string];
        NSRange changeTextRange = [unparsedLabelText rangeOfString:selectedBingoBall];
        [letterLabelText addAttributes: @{NSForegroundColorAttributeName :[UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1.0]} range:changeTextRange];
        self.letterLabel.attributedText = [letterLabelText copy];
    }
    else
    {
        self.selectedBallLabel.text = @"Done!";
        NSMutableAttributedString *letterLabelText = [[NSMutableAttributedString alloc] initWithAttributedString: self.letterLabel.attributedText];
        [letterLabelText addAttributes: @{NSForegroundColorAttributeName : [UIColor colorWithRed:.45 green:0 blue:0.75 alpha:1.0]} range:NSMakeRange(0, [letterLabelText length])];
        self.letterLabel.attributedText = [letterLabelText copy];
        self.randomBallButton.enabled = NO;
    }
}
- (IBAction)reset
{
    [self setup];
    [self.game resetBingoBoard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
