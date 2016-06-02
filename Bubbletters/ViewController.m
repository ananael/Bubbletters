//
//  ViewController.m
//  Bubbletters
//
//  Created by Michael Hoffman on 6/1/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "ViewController.h"
#import "Lexicontext.h"
#import "LettersArrays.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UIView *container01;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIView *container02;
@property (weak, nonatomic) IBOutlet UIView *container03;
@property (weak, nonatomic) IBOutlet UIView *container04;
@property (weak, nonatomic) IBOutlet UIView *container05;
@property (weak, nonatomic) IBOutlet UIView *container06;
@property (weak, nonatomic) IBOutlet UIView *container07;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *backspaceButton;
@property (weak, nonatomic) IBOutlet UIButton *clearAllButton;

@property UIButton *button01;
@property UIButton *button02;
@property UIButton *button03;
@property UIButton *button04;
@property UIButton *button05;
@property UIButton *button06;
@property UIButton *button07;
@property UIButton *button08;
@property UIButton *button09;
@property UIButton *button10;
@property UIButton *button11;
@property UIButton *button12;
@property UIButton *button13;
@property UIButton *button14;
@property UIButton *button15;
@property UIButton *button16;

@property NSMutableArray *wordArray;
@property Lexicontext *lexDict;

@property NSTimer *swapTimer01;
@property NSTimer *swapTimer02;
@property NSTimer *swapTimer03;
@property NSTimer *swapTimer04;

@property LettersArrays *letters;

- (IBAction)submitTapped:(id)sender;
- (IBAction)backspaceTapped:(id)sender;
- (IBAction)clearAllTapped:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.lexDict = [Lexicontext sharedDictionary];
    self.letters = [LettersArrays new];
    self.wordArray = [NSMutableArray new];
    
    [self gameButtons];
    [self formatWordLabel];
    [self formatContainers];
    [self formatEntryButtons];
    [self.letters initialLettersForButtonArray:[self buttonArray]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)buttonArray
{
    NSArray *buttons = @[self.button01, self.button02, self.button03, self.button04, self.button05, self.button06, self.button07, self.button08, self.button09, self.button10, self.button11, self.button12, self.button13, self.button14, self.button15, self.button16];
    return buttons;
}

-(NSArray *)buttonSwapArray01
{
    NSArray *buttons = @[self.button01, self.button08, self.button10, self.button15];
    return buttons;
}

-(NSArray *)buttonSwapArray02
{
    NSArray *buttons = @[self.button02, self.button07, self.button12, self.button13];
    return buttons;
}

-(NSArray *)buttonSwapArray03
{
    NSArray *buttons = @[self.button03, self.button06, self.button09, self.button16];
    return buttons;
}

-(NSArray *)buttonSwapArray04
{
    NSArray *buttons = @[self.button04, self.button05, self.button11, self.button14];
    return buttons;
}

-(NSArray *)containerArray
{
    NSArray *container = @[self.container01, self.container02, self.container03, self.container04, self.container05, self.container06, self.container07];
    return container;
}

-(NSArray *)entryButtons
{
    NSArray *buttons = @[self.submitButton, self. backspaceButton, self.clearAllButton];
    return buttons;
}

-(void)formatWordLabel
{
    self.wordLabel.backgroundColor = [UIColor colorWithRed:147/255.0 green:114/255.0 blue:205/255.0 alpha:1.0];
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

-(void)formatGameButtons:(NSArray *)array
{
    UIColor *buttonColor = [UIColor colorWithRed:255/255 green:255/255 blue:0.0 alpha:1.0];
    UIColor *border = [UIColor blackColor];
    
    for (UIButton *button in [self buttonArray])
    {
        button.layer.borderColor = border.CGColor;
        button.layer.borderWidth = 2;
        button.backgroundColor = buttonColor;
        button.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:35];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

-(void)gameButtons
{
    NSInteger diameter;
    NSInteger space = 19;
    
    if (UIScreen.mainScreen.bounds.size.height == 480) // 4s
    {
        diameter = self.container03.frame.size.height*0.80;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 568) // 5s
    {
        diameter = self.container03.frame.size.height*0.81;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 667) // 6
    {
        diameter = self.container03.frame.size.height*1.0;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 736) // 6 Plus
    {
        diameter = self.container03.frame.size.height*1.13;
    }
    else if (UIScreen.mainScreen.bounds.size.height == 1024) //For iPad Air
    {
        diameter = self.container03.frame.size.height*1.70;
        space = 83;
    }
    else
    {
        //For iPad Pro
        diameter = self.container03.frame.size.height*2.27;
        space = 117;
    }
    
    NSInteger round = diameter/2;
    
    self.button01 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.button01.layer.cornerRadius = round;
    [self.container03 addSubview:self.button01];
    
    self.button02 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button02.layer.cornerRadius = round;
    [self.container03 addSubview:self.button02];
    
    self.button03 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button03.layer.cornerRadius = round;
    [self.container03 addSubview:self.button03];
    
    self.button04 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button04.layer.cornerRadius = round;
    [self.container03 addSubview:self.button04];
    
    self.button05 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.button05.layer.cornerRadius = round;
    [self.container04 addSubview:self.button05];
    
    self.button06 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button06.layer.cornerRadius = round;
    [self.container04 addSubview:self.button06];
    
    self.button07 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button07.layer.cornerRadius = round;
    [self.container04 addSubview:self.button07];
    
    self.button08 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button08.layer.cornerRadius = round;
    [self.container04 addSubview:self.button08];
    
    self.button09 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.button09.layer.cornerRadius = round;
    [self.container05 addSubview:self.button09];
    
    self.button10 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button10.layer.cornerRadius = round;
    [self.container05 addSubview:self.button10];
    
    self.button11 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button11.layer.cornerRadius = round;
    [self.container05 addSubview:self.button11];
    
    self.button12 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button12.layer.cornerRadius = round;
    [self.container05 addSubview:self.button12];
    
    self.button13 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.button13.layer.cornerRadius = round;
    [self.container06 addSubview:self.button13];
    
    self.button14 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button14.layer.cornerRadius = round;
    [self.container06 addSubview:self.button14];
    
    self.button15 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button15.layer.cornerRadius = round;
    [self.container06 addSubview:self.button15];
    
    self.button16 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button16.layer.cornerRadius = round;
    [self.container06 addSubview:self.button16];
    
    [self formatGameButtons:[self buttonArray]];
    [self buttonAction:[self buttonArray]];
    [self letterSwapTimer01];
    [self letterSwapTimer02];
    [self letterSwapTimer03];
    [self letterSwapTimer04];
}

-(void)letterSwapTimer01
{
    self.swapTimer01 = [NSTimer scheduledTimerWithTimeInterval:6.0
                                                        target:self
                                                      selector:@selector(letterSwap01)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)letterSwapTimer02
{
    self.swapTimer02 = [NSTimer scheduledTimerWithTimeInterval:5.5
                                                        target:self
                                                      selector:@selector(letterSwap02)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)letterSwapTimer03
{
    self.swapTimer03 = [NSTimer scheduledTimerWithTimeInterval:7.0
                                                        target:self
                                                      selector:@selector(letterSwap03)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)letterSwapTimer04
{
    self.swapTimer04 = [NSTimer scheduledTimerWithTimeInterval:6.5
                                                        target:self
                                                      selector:@selector(letterSwap04)
                                                      userInfo:nil
                                                       repeats:YES];
}

-(void)letterSwap01
{
    [self.letters letterSwapForArray:[self buttonSwapArray01]];
}

-(void)letterSwap02
{
    [self.letters letterSwapForArray:[self buttonSwapArray02]];
}

-(void)letterSwap03
{
    [self.letters letterSwapForArray:[self buttonSwapArray03]];
}

-(void)letterSwap04
{
    [self.letters letterSwapForArray:[self buttonSwapArray04]];
}

-(void)buttonTapped:(UIButton *)button
{
    [self.wordArray addObject:button.titleLabel.text];
    NSLog(@"WORD ARRAY: %@", _wordArray);
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
    self.wordLabel.text = [self.wordArray componentsJoinedByString:@""];
}

- (IBAction)submitTapped:(id)sender
{
    if ([_lexDict containsDefinitionFor:[self.wordLabel.text lowercaseString]])
    {
        NSLog(@"FOUND! - %@", self.wordLabel.text);
        [self.wordArray removeAllObjects];
        self.wordLabel.text = @"";
    }
    else
    {
        NSLog(@"NOPE!!");
    }
}

- (IBAction)backspaceTapped:(id)sender
{
    [self.wordArray removeLastObject];
    self.wordLabel.text = [self.wordArray componentsJoinedByString:@""];
}

- (IBAction)clearAllTapped:(id)sender
{
    [self.wordArray removeAllObjects];
    self.wordLabel.text = @"";
}
















@end
