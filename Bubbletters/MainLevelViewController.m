//
//  MainLevelViewController.m
//  Bubbletters
//
//  Created by Michael Hoffman on 7/7/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "MainLevelViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Lexicontext.h"
#import "LettersArrays.h"
#import "Scoring.h"

@interface MainLevelViewController ()

//Storyboard-linked properties
@property (weak, nonatomic) IBOutlet UIView *backAnimation;
@property (weak, nonatomic) IBOutlet UIImageView *backView;

@property (weak, nonatomic) IBOutlet UIView *frontAnimation;
@property (weak, nonatomic) IBOutlet UIView *gameOverView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *container2;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIView *container3;
@property (weak, nonatomic) IBOutlet UIView *container4;
@property (weak, nonatomic) IBOutlet UIView *container5;
@property (weak, nonatomic) IBOutlet UIView *container6;
@property (weak, nonatomic) IBOutlet UIView *container7;
@property (weak, nonatomic) IBOutlet UIView *container8;
@property (weak, nonatomic) IBOutlet UIView *container9;
@property (weak, nonatomic) IBOutlet UIView *container10;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *backspaceButton;
@property (weak, nonatomic) IBOutlet UIButton *clearAllButton;

@property UIButton *replayButton;
@property UIButton *continueButton;

@property NSMutableArray *tempWordArray;
@property NSMutableArray *validWordArray;
@property Lexicontext *lexDict;

@property NSTimer *swapTimer01;
@property NSTimer *swapTimer02;
@property NSTimer *swapTimer03;
@property NSTimer *swapTimer04;
@property NSTimer *progressBarTimer;

@property NSInteger gameSeconds;
@property CGFloat swapSeconds;

@property LettersArrays *letters;
@property Scoring *score;
@property NSInteger wordSum;
@property NSInteger wordCount;
@property NSMutableArray *tempScoreArray;
@property NSMutableArray *tempDouble;
@property NSMutableArray *tempTriple;
@property NSMutableArray *tempTotalArray;
@property NSMutableArray *totalArray;

@property NSMutableArray *tileArray;
@property NSMutableArray *whiteTiles;
@property NSMutableArray *pinkTiles;
@property NSMutableArray *redTiles;
@property NSMutableArray *blueTiles;
@property NSMutableArray *navyTiles;

@property NSMutableArray *tileSwapOne;
@property NSMutableArray *tileSwapTwo;
@property NSMutableArray *tileSwapThree;
@property NSMutableArray *tileSwapFour;

- (IBAction)replayTapped:(id)sender;
- (IBAction)continueTapped:(id)sender;
- (IBAction)submitTapped:(id)sender;
- (IBAction)backspaceTapped:(id)sender;
- (IBAction)clearAllTapped:(id)sender;

@end

@implementation MainLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lexDict = [Lexicontext sharedDictionary];
    self.letters = [LettersArrays new];
    self.score = [Scoring new];
    self.tempWordArray = [NSMutableArray new];
    self.validWordArray = [NSMutableArray new];
    self.tempScoreArray = [NSMutableArray new];
    self.tempTotalArray = [NSMutableArray new];
    self.totalArray = [NSMutableArray new];
    self.tempDouble = [NSMutableArray new];
    self.tempTriple = [NSMutableArray new];
    self.scoreLabel.text = @"Score: 0";
    self.swapSeconds = 8.0;
    
    //The tileArray contains all 16 game tiles (UIButtons)
    self.tileArray = [NSMutableArray new];
    //The whiteTiles array contains the tileArray and is used for removing special buttons
    self.whiteTiles = [NSMutableArray new];
    //The pinkTiles contains the double-letter tiles
    self.pinkTiles = [NSMutableArray new];
    //The redTiles contains the double-word tiles
    self.redTiles = [NSMutableArray new];
    //The blueTiles contains the triple-letter tiles
    self.blueTiles = [NSMutableArray new];
    //The navyTiles contains the triple-word tiles
    self.navyTiles = [NSMutableArray new];
    //The tileSwapArray contains the tileArray and is used when creating the arrays for letter-swapping
    self.tileSwapOne = [NSMutableArray new];
    self.tileSwapTwo = [NSMutableArray new];
    self.tileSwapThree = [NSMutableArray new];
    self.tileSwapFour = [NSMutableArray new];
    
    
    
    //The backAnimation color will be replaced with the game background animation
    self.backView.image = [UIImage imageNamed:@"test background"];
    self.frontAnimation.hidden = YES;
    self.gameOverView.hidden = YES;
    
    [self gameTiles];
    
    [self formatWordLabel];
    [self formatContainers];
    [self formatEntryButtons];
    [self createReplayButton];
    [self createContinueButton];
    [self formatProgeressBar];
    
    [self.letters initialLettersForButtonArray:self.whiteTiles];
    if ([self.pinkTiles count] > 0)
    {
        [self.letters initialLettersForButtonArray:self.pinkTiles];
    }
    if ([self.blueTiles count] > 0)
    {
        [self.letters initialLettersForButtonArray:self.blueTiles];
    }
    if ([self.redTiles count] > 0)
    {
        [self.letters initialLettersForButtonArray:self.redTiles];
    }
    if ([self.navyTiles count] > 0)
    {
        [self.letters initialLettersForButtonArray:self.navyTiles];
    }
    
    [self gameTimer];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)containerArray
{
    NSArray *container = @[self.container1, self.container2, self.container3, self.container4, self.container5, self.container6, self.container7, self.container8, self.container9, self.container10];
    return container;
}

-(NSArray *)entryButtons
{
    NSArray *buttons = @[self.submitButton, self. backspaceButton, self.clearAllButton];
    return buttons;
}

-(NSArray *)gameOverButtons
{
    NSArray *buttons = @[self.replayButton, self.continueButton];
    return buttons;
}

#pragma mark - Formatting

-(void)formatWordLabel
{
    self.wordLabel.backgroundColor = [UIColor colorWithRed:230/255.0 green:255/255.0 blue:205/255.0 alpha:1.0];
    self.wordLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.wordLabel.layer.borderWidth = 2;
    self.wordLabel.layer.cornerRadius = 15;
    self.wordLabel.layer.masksToBounds = YES;
}

-(void)formatContainers
{
    for (UIView *container in [self containerArray])
    {
        container.backgroundColor = [UIColor clearColor];
    }
}

-(void)formatEntryButtons
{
    UIColor *border = [UIColor blackColor];
    for (UIButton *button in [self entryButtons])
    {
        button.layer.borderColor = border.CGColor;
        button.layer.borderWidth = 2;
        button.layer.cornerRadius = 15;
    }
}

-(void)formatProgeressBar
{
    //Resizes the ProgressView (width, height).
    self.progressBar.transform = CGAffineTransformScale(self.progressBar.transform, 1, 4);
    
    //Changes the background color of the ProgressView (if "Bar" style is chosen in Storyboard, default is clear).
    self.progressBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
    
    //Changes the bar color of the ProgressView (default is blue).
    self.progressBar.tintColor = [UIColor greenColor];
}

-(void)formatGameButtons:(NSArray *)array withImage:(UIImage *)image
{
    for (UIButton *button in array)
    {
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:35];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

#pragma mark - Tiles

-(void)gameTiles
{
    NSInteger diameter;
    NSInteger space = 19;
    
    if (UIScreen.mainScreen.bounds.size.height == 480) // 4s
    {
        diameter = self.container3.frame.size.height*0.80;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 568) // 5s
    {
        diameter = self.container3.frame.size.height*0.81;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 667) // 6
    {
        diameter = self.container3.frame.size.height*1.0;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 736) // 6 Plus
    {
        diameter = self.container3.frame.size.height*1.13;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 1024) //For iPad Air
    {
        diameter = self.container3.frame.size.height*1.70;
        space = 83;
    }
    else
    {
        //For iPad Pro
        diameter = self.container3.frame.size.height*2.27;
        space = 117;
    }
    
    NSInteger roundTile = diameter/2;
    
    //The game tiles are created in 4 groups of 4 so that each quartet has the same spacing to fit in properly in each one of the containers.
    for (NSInteger i=0; i<4; i++)
    {
        for (NSInteger j=0; j<4; j++)
        {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((diameter+space)*j, 0, diameter, diameter)];
            button.layer.cornerRadius = roundTile;
            [self.tileArray addObject:button];
            
        }
    }
    
    [self createTileTags];
    [self assignTilesToContainers];
    
    //Used as the modifiable base mutArray from which to create special tiles.
    self.whiteTiles = [NSMutableArray arrayWithArray:self.tileArray];
    //Used when creating the arrays for letter-swapping
    self.tileSwapOne = [NSMutableArray arrayWithArray:self.tileArray];
    
    [self formatPinkTiles];
    [self formatBlueTiles];
    [self formatRedTiles];
    [self formatNavyTiles];
    [self formatGameButtons:self.whiteTiles withImage:[UIImage imageNamed:@"white tile@3x"]];
    [self buttonAction:self.tileArray];
    [self buttonAction:self.pinkTiles];
    [self buttonAction:self.blueTiles];
    [self buttonAction:self.redTiles];
    [self buttonAction:self.navyTiles];
    
    [self createTileSwapArrays];
    [self letterSwapTimer01];
    [self letterSwapTimer02];
    [self letterSwapTimer03];
    [self letterSwapTimer04];
    
    
}

-(void)createTileTags
{
    for (NSInteger j=0; j<[self.tileArray count]; j++)
    {
        UIButton *button;
        button = [self.tileArray objectAtIndex:j];
        [button setTag:j+1];
    }
}

-(void)assignTilesToContainers
{
    for (UIButton *button in self.tileArray)
    {
        NSLog(@"Button Tag = %ld", (long)button.tag);
        
        if ([button tag] < 5)
        {
            [self.container3 addSubview:button];
        }
        else if ([button tag] > 4 && [button tag] < 9)
        {
            [self.container4 addSubview:button];
        }
        else if ([button tag] > 8 && [button tag] < 13)
        {
            [self.container5 addSubview:button];
        }
        else if ([button tag] > 12)
        {
            [self.container6 addSubview:button];
        }
    }
}

-(void)createReplayButton
{
    NSInteger diameter = self.container10.frame.size.height;
    
    if (UIScreen.mainScreen.bounds.size.height == 480) // 4s
    {
        diameter = self.container10.frame.size.height*0.80;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 568) // 5s
    {
        diameter = self.container10.frame.size.height*0.81;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 667) // 6
    {
        diameter = self.container10.frame.size.height*1.0;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 736) // 6 Plus
    {
        diameter = self.container10.frame.size.height*1.13;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 1024) //For iPad Air
    {
        diameter = self.container10.frame.size.height*1.70;
    }
    else
    {
        //For iPad Pro
        diameter = self.container10.frame.size.height*2.27;
    }
    
    NSInteger xAxis = self.view.center.x;
    
    self.replayButton = [[UIButton alloc]initWithFrame:CGRectMake(xAxis-(diameter*1.5), 0, diameter, diameter)];
    self.replayButton.layer.cornerRadius = diameter/2;
    [self.replayButton setImage:[UIImage imageNamed:@"replay button@3x"] forState:UIControlStateNormal];
    [self.replayButton addTarget:self action:@selector(replayTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.container10 addSubview:self.replayButton];
}

-(void)createContinueButton
{
    NSInteger diameter = self.container10.frame.size.height;
    
    if (UIScreen.mainScreen.bounds.size.height == 480) // 4s
    {
        diameter = self.container10.frame.size.height*0.80;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 568) // 5s
    {
        diameter = self.container10.frame.size.height*0.81;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 667) // 6
    {
        diameter = self.container10.frame.size.height*1.0;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 736) // 6 Plus
    {
        diameter = self.container10.frame.size.height*1.13;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 1024) //For iPad Air
    {
        diameter = self.container10.frame.size.height*1.70;
    }
    else
    {
        //For iPad Pro
        diameter = self.container10.frame.size.height*2.27;
    }
    
    NSInteger xAxis = self.view.center.x;
    
    self.continueButton = [[UIButton alloc]initWithFrame:CGRectMake(xAxis+(diameter*0.5), 0, diameter, diameter)];
    self.continueButton.layer.cornerRadius = diameter/2;
    [self.continueButton setImage:[UIImage imageNamed:@"continue button@3x"] forState:UIControlStateNormal];
    [self.continueButton addTarget:self action:@selector(continueTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.container10 addSubview:self.continueButton];
}

#pragma mark - Special Tiles

-(void)selectPinkTiles
{
    UIButton *button;
    for (NSInteger i=0; i<2; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[self.whiteTiles count]);
        //NSLog(@"Random Pink Button: %ld", (long)randomTile);
        button = [self.whiteTiles objectAtIndex:randomTile];
        [self.pinkTiles addObject:button];
        [self.whiteTiles removeObject:button];
    }
}

-(void)formatPinkTiles
{
    [self selectPinkTiles];
    [self formatGameButtons:self.pinkTiles withImage:[UIImage imageNamed:@"pink tile@3x"]];
}

-(void)selectBlueTiles
{
    UIButton *button;
    for (NSInteger i=0; i<1; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[self.whiteTiles count]);
        //NSLog(@"Random Blue Button: %ld", (long)randomTile);
        button = [self.whiteTiles objectAtIndex:randomTile];
        [self.blueTiles addObject:button];
        [self.whiteTiles removeObject:button];
    }
}

-(void)formatBlueTiles
{
    [self selectBlueTiles];
    [self formatGameButtons:self.blueTiles withImage:[UIImage imageNamed:@"blue tile@3x"]];
}

-(void)selectRedTiles
{
    UIButton *button;
    for (NSInteger i=0; i<1; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[self.whiteTiles count]);
        //NSLog(@"Random Red Button: %ld", (long)randomTile);
        button = [self.whiteTiles objectAtIndex:randomTile];
        [self.redTiles addObject:button];
        [self.whiteTiles removeObject:button];
    }
}

-(void)formatRedTiles
{
    [self selectRedTiles];
    [self formatGameButtons:self.redTiles withImage:[UIImage imageNamed:@"red tile@3x"]];
}

-(void)selectNavyTiles
{
    UIButton *button;
    for (NSInteger i=0; i<1; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[self.whiteTiles count]);
        //NSLog(@"Random Navy Button: %ld", (long)randomTile);
        button = [self.whiteTiles objectAtIndex:randomTile];
        [self.navyTiles addObject:button];
        [self.whiteTiles removeObject:button];
    }
}

-(void)formatNavyTiles
{
    [self selectNavyTiles];
    [self formatGameButtons:self.navyTiles withImage:[UIImage imageNamed:@"navy tile@3x"]];
}

-(void)disableGameButtons
{
    for (UIButton *button in self.tileArray)
    {
        [button setEnabled:NO];
    }
}

-(void)disableEntryButtons
{
    for (UIButton *button in [self entryButtons])
    {
        [button setEnabled:NO];
    }
}

-(void)enableGameButtons
{
    for (UIButton *button in self.tileArray)
    {
        [button setEnabled:YES];
    }
}

-(void)enableEntryButtons
{
    for (UIButton *button in [self entryButtons])
    {
        [button setEnabled:YES];
    }
}

#pragma mark - Timers

-(void)letterSwapTimer01
{
    self.swapTimer01 = [NSTimer scheduledTimerWithTimeInterval:self.swapSeconds-1
                                                        target:self
                                                      selector:@selector(letterSwap01)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)letterSwapTimer02
{
    self.swapTimer02 = [NSTimer scheduledTimerWithTimeInterval:self.swapSeconds-1.5
                                                        target:self
                                                      selector:@selector(letterSwap02)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)letterSwapTimer03
{
    self.swapTimer03 = [NSTimer scheduledTimerWithTimeInterval:self.swapSeconds
                                                        target:self
                                                      selector:@selector(letterSwap03)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)letterSwapTimer04
{
    self.swapTimer04 = [NSTimer scheduledTimerWithTimeInterval:self.swapSeconds-0.5
                                                        target:self
                                                      selector:@selector(letterSwap04)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)gameTimer
{
    self.progressBarTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                             target:self
                                                           selector:@selector(updateProgressBar)
                                                           userInfo:nil
                                                            repeats:YES];
}

#pragma mark - Timer Selectors

-(void)updateProgressBar
{
    //This increases the counter by 1.
    self.gameSeconds ++;
    
    //If the counter is an integer, it must be cast as (float) for the progress (which is decimal-based.
    self.progressBar.progress = (float)self.gameSeconds/120;
    
    //Provides an upper limit to the timer with instructions to stop counting when the counter reaches a specific value.
    if (self.gameSeconds == 90) //90
    {
        self.progressBar.tintColor = [UIColor yellowColor];
    }
    else if (self.gameSeconds == 110)//110
    {
        self.progressBar.tintColor = [UIColor redColor];
    }
    else if (self.gameSeconds == 120)//120
    {
        [self.progressBarTimer invalidate];
        [self disableGameButtons];
        [self disableEntryButtons];
        [self.swapTimer01 invalidate];
        [self.swapTimer02 invalidate];
        [self.swapTimer03 invalidate];
        [self.swapTimer04 invalidate];
        
        self.frontAnimation.hidden = NO;
        self.frontAnimation.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
        self.gameOverView.hidden = NO;
        
        NSLog(@"Timer STOPPED!");
        NSLog(@"%@", self.validWordArray);
    }
}

//Randomly add 4 buttons to each of the tileSwap arrays for use in the letterSwap methods
-(void)createTileSwapArrays
{
    UIButton *button;
    for (NSInteger i=0; i<4; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[self.tileSwapOne count]);
        NSLog(@"Tile Swap One: %ld", (long)randomTile);
        button = [self.tileSwapOne objectAtIndex:randomTile];
        [self.tileSwapTwo addObject:button];
        [self.tileSwapOne removeObject:button];
    }
    for (NSInteger i=0; i<4; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[self.tileSwapOne count]);
        //NSLog(@"Random Button: %ld", (long)randomTile);
        button = [self.tileSwapOne objectAtIndex:randomTile];
        [self.tileSwapThree addObject:button];
        [self.tileSwapOne removeObject:button];
    }
    for (NSInteger i=0; i<4; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[self.tileSwapOne count]);
        //NSLog(@"Random Button: %ld", (long)randomTile);
        button = [self.tileSwapOne objectAtIndex:randomTile];
        [self.tileSwapFour addObject:button];
        [self.tileSwapOne removeObject:button];
    }
}

-(void)letterSwap01
{
    [self.letters letterSwapForArray:self.tileSwapOne];
}

-(void)letterSwap02
{
    [self.letters letterSwapForArray:self.tileSwapTwo];
}

-(void)letterSwap03
{
    [self.letters letterSwapForArray:self.tileSwapThree];
}

-(void)letterSwap04
{
    [self.letters letterSwapForArray:self.tileSwapFour];
}

-(void)buttonTapped:(UIButton *)button
{
    NSInteger regLetter = 1;
    NSInteger dblLetter = 2;
    NSInteger trplLetter = 3;
    [self.tempWordArray addObject:button.titleLabel.text];
    
    //Regular Letter Tiles
    for (UIButton *white in self.whiteTiles)
    {
        if ([button tag] == white.tag)
        {
            [self.tempScoreArray addObject:[NSNumber numberWithInteger:[self.score valueForLetter:white.titleLabel.text withMultiplier:regLetter]]];
            
            NSLog(@"White Letter = %@\nWhite Value = %ld", white.titleLabel.text, (long)[self.score valueForLetter:white.titleLabel.text withMultiplier:regLetter]);
        }
    }
    
    //Double Letter Tiles
    for (UIButton *pink in self.pinkTiles)
    {
        if ([button tag] == pink.tag)
        {
            [self.tempScoreArray addObject:[NSNumber numberWithInteger:[self.score valueForLetter:pink.titleLabel.text withMultiplier:dblLetter]]];
            
            NSLog(@"Pink Letter = %@\nPink Value = %ld", pink.titleLabel.text, (long)[self.score valueForLetter:pink.titleLabel.text withMultiplier:dblLetter]);
        }
    }
    
    //Triple Letter Tiles
    for (UIButton *blue in self.blueTiles)
    {
        if ([button tag] == blue.tag)
        {
            [self.tempScoreArray addObject:[NSNumber numberWithInteger:[self.score valueForLetter:blue.titleLabel.text withMultiplier:trplLetter]]];
            
            NSLog(@"Blue Letter = %@\nBlue Value = %ld", blue.titleLabel.text, (long)[self.score valueForLetter:blue.titleLabel.text withMultiplier:trplLetter]);
        }
    }
    
    //Double Word Tiles
    for (UIButton *red in self.redTiles)
    {
        if ([button tag] == red.tag)
        {
            [self.tempScoreArray addObject:[NSNumber numberWithInteger:[self.score valueForLetter:red.titleLabel.text withMultiplier:regLetter]]];
            [self.tempDouble addObject:red];
            
            NSLog(@"Red Letter = %@\nRed Value = %ld", red.titleLabel.text, (long)[self.score valueForLetter:red.titleLabel.text withMultiplier:regLetter]);
        }
        //NSLog(@"Double Word Count = %lu", (unsigned long)[self.tempDouble count]);
    }
    
    //Triple Word Tiles
    for (UIButton *navy in self.navyTiles)
    {
        if ([button tag] == navy.tag)
        {
            [self.tempScoreArray addObject:[NSNumber numberWithInteger:[self.score valueForLetter:navy.titleLabel.text withMultiplier:regLetter]]];
            [self.tempTriple addObject:navy];
            
            NSLog(@"Navy Letter = %@\nNavy Value = %ld", navy.titleLabel.text, (long)[self.score valueForLetter:navy.titleLabel.text withMultiplier:regLetter]);
        }
        //NSLog(@"Triple Word Count = %lu", (unsigned long)[self.tempTriple count]);
    }
    
    NSLog(@"Double Word Count = %lu", (unsigned long)[self.tempDouble count]);
    NSLog(@"Triple Word Count = %lu", (unsigned long)[self.tempTriple count]);
    NSLog(@"WORD ARRAY: %@", _tempWordArray);
    [self wordLabelDisplay];
}

-(void)buttonAction:(NSArray *)array
{
    for (UIButton *button in array)
    {
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    }
}

-(void)wordLabelDisplay
{
    self.wordLabel.text = [self.tempWordArray componentsJoinedByString:@""];
}

-(void)replayReset
{
    self.frontAnimation.hidden = YES;
    self.wordLabel.text = @"";
    self.scoreLabel.text = @"0";
    self.countLabel.text = @"0";
    self.wordCount = 0; //resets word count to zero
    self.gameSeconds = 0; //needed to reset the progress bar rate
    self.progressBar.progress = 0.0; //resets the bar to the beginning
    self.progressBar.tintColor = [UIColor greenColor]; //otherwise progress bar restarts as end color
    [self.tempWordArray removeAllObjects];
    [self.validWordArray removeAllObjects];
    [self.tempScoreArray removeAllObjects];
    [self.tempDouble removeAllObjects];
    [self.tempTriple removeAllObjects];
    [self.tempTotalArray removeAllObjects];
    [self.totalArray removeAllObjects];
    [self enableGameButtons];
    [self enableEntryButtons];
    self.gameOverView.hidden = YES;
    [self gameTimer];
    [self.letters initialLettersForButtonArray:self.tileArray]; //otherwise starts with same ending letters
    [self letterSwapTimer01]; //validates the timer for new game
    [self letterSwapTimer02]; //validates the timer for new game
    [self letterSwapTimer03]; //validates the timer for new game
    [self letterSwapTimer04]; //validates the timer for new game
}

- (IBAction)replayTapped:(id)sender
{
    [self replayReset];
}

- (IBAction)continueTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitTapped:(id)sender
{
    if ([_lexDict containsDefinitionFor:[self.wordLabel.text lowercaseString]])
    {
        //NSLog(@"FOUND! - %@", self.wordLabel.text);
        self.wordCount ++;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)[self scoring]];
        self.countLabel.text = [NSString stringWithFormat:@"Words: %ld", (long)self.wordCount];
        [self.validWordArray addObject:self.wordLabel.text];
        [self.tempWordArray removeAllObjects];
        [self.tempScoreArray removeAllObjects];
        [self.tempDouble removeAllObjects];
        [self.tempTriple removeAllObjects];
        [self.tempTotalArray removeAllObjects];
        self.wordLabel.text = @"";
    }
    else
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self.tempWordArray removeAllObjects];
        [self.tempScoreArray removeAllObjects];
        [self.tempTotalArray removeAllObjects];
        [self.tempDouble removeAllObjects];
        [self.tempTriple removeAllObjects];
        self.wordLabel.text = @"";
    }
}

- (IBAction)backspaceTapped:(id)sender
{
    [self.tempWordArray removeLastObject];
    [self.tempScoreArray removeLastObject];
    [self.tempDouble removeAllObjects];
    [self.tempTriple removeAllObjects];
    self.wordLabel.text = [self.tempWordArray componentsJoinedByString:@""];
}

- (IBAction)clearAllTapped:(id)sender
{
    [self.tempWordArray removeAllObjects];
    [self.tempScoreArray removeAllObjects];
    [self.tempDouble removeAllObjects];
    [self.tempTriple removeAllObjects];
    self.wordLabel.text = @"";
}

-(NSInteger)scoring
{
    self.wordSum = 0;
    NSInteger tempSum = 0;
    NSInteger doubleTotal = 0;
    NSInteger tripleTotal = 0;
    NSInteger bothTotal = 0;
    NSInteger regTotal = 0;
    NSInteger doubleWord = pow(2, [self.tempDouble count]);
    NSInteger tripleWord = pow(3, [self.tempTriple count]);
    
    NSLog(@"Double Word Power = %ld", doubleWord);
    
    [self.tempTotalArray addObjectsFromArray:self.tempScoreArray];
    NSLog(@"Score: %@", self.tempTotalArray);
    for (NSNumber *points in self.tempTotalArray)
    {
        tempSum += [points integerValue];
    }
    
    if ([self.tempDouble count] > 0 && [self.tempTriple count] == 0)
    {
        doubleTotal = tempSum*doubleWord;
        [self.totalArray addObject:[NSNumber numberWithInteger:doubleTotal]];
        NSLog(@"Double Word = %ld", doubleTotal);
    }
    if ([self.tempTriple count] > 0 && [self.tempDouble count] == 0)
    {
        tripleTotal = tempSum*tripleWord;
        [self.totalArray addObject:[NSNumber numberWithInteger:tripleTotal]];
        NSLog(@"Triple Word = %ld", tripleTotal);
    }
    if ([self.tempDouble count] > 0 && [self.tempTriple count] > 0)
    {
        bothTotal = tempSum*doubleWord*tripleWord;
        [self.totalArray addObject:[NSNumber numberWithInteger:bothTotal]];
        NSLog(@"Both Word = %ld", bothTotal);
    }
    if ([self.tempDouble count] == 0 && [self.tempTriple count] == 0)
    {
        //regTotal = tempSum;
        [self.totalArray addObject:[NSNumber numberWithInteger:tempSum]];
        NSLog(@"Regular Word = %ld", regTotal);
    }
    NSLog(@"Totals Array: %@", self.totalArray);
    for (NSNumber *total in self.totalArray)
    {
        self.wordSum += [total integerValue];
    }
    
    return self.wordSum;
}

@end
