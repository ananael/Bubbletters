//
//  ViewController.m
//  Bubbletters
//
//  Created by Michael Hoffman on 6/1/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "ViewController.h"

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

@property NSArray *lettersArray;
@property NSArray *lettersArray02;
@property NSArray *lettersArray03;
@property NSArray *lettersArray04;
@property NSArray *lettersArray05;
@property NSArray *lettersArray06;
@property NSArray *lettersArray07;
@property NSArray *lettersArray08;
@property NSArray *lettersArray09;
@property NSArray *lettersArray10;
@property NSArray *lettersArray11;
@property NSArray *lettersArray12;
@property NSArray *lettersArray13;
@property NSArray *lettersArray14;
@property NSArray *lettersArray15;
@property NSArray *lettersArray16;

@property NSInteger randomIndex01;
@property NSInteger randomIndex02;
@property NSInteger randomIndex03;
@property NSInteger randomIndex04;
@property NSInteger randomIndex05;
@property NSInteger randomIndex06;
@property NSInteger randomIndex07;
@property NSInteger randomIndex08;
@property NSInteger randomIndex09;
@property NSInteger randomIndex10;
@property NSInteger randomIndex11;
@property NSInteger randomIndex12;
@property NSInteger randomIndex13;
@property NSInteger randomIndex14;
@property NSInteger randomIndex15;
@property NSInteger randomIndex16;

@property NSMutableArray *wordArray;
@property NSArray *wordDict;

@property NSTimer *swapTimer01;
@property NSTimer *swapTimer02;
@property NSTimer *swapTimer03;
@property NSTimer *swapTimer04;

- (IBAction)submitTapped:(id)sender;
- (IBAction)backspaceTapped:(id)sender;
- (IBAction)clearAllTapped:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.wordArray = [NSMutableArray new];
    
    //The array has the same Scrabble letter distribution/frequency
    self.lettersArray = @[@"A", @"A", @"A", @"A", @"A", @"A", @"A", @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"D", @"D", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"F", @"F", @"G", @"G", @"G", @"H", @"H", @"I", @"I", @"I", @"I", @"I", @"I", @"I", @"I", @"I", @"J", @"K", @"L", @"L", @"L", @"L", @"M", @"M", @"N", @"N", @"N", @"N", @"N", @"N", @"O", @"O", @"O", @"O", @"O", @"O", @"O", @"O", @"P", @"P", @"Q", @"R", @"R", @"R", @"R", @"R", @"R", @"S", @"S", @"S", @"S", @"T", @"T", @"T", @"T", @"T", @"T", @"U", @"U", @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"Y", @"Y", @"Z"];
    
    [self gameButtons];
    
    
    
    
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

-(void)formatGameButtons:(NSArray *)array
{
    UIColor *buttonColor = [UIColor colorWithRed:255/255 green:255/255 blue:0.0 alpha:1.0];
    UIColor *border = [UIColor blackColor];
    
    for (UIButton *button in [self buttonArray])
    {
        button.layer.borderColor = border.CGColor;
        button.layer.borderWidth = 2;
        button.backgroundColor = buttonColor;
        button.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:45];
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
//    [self letterSwapTimer01];
//    [self.button01 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container03 addSubview:self.button01];
    
    self.button02 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button02.layer.cornerRadius = round;
//    [self letterSwapTimer02];
//    [self.button02 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container03 addSubview:self.button02];
    
    self.button03 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button03.layer.cornerRadius = round;
//    [self letterSwapTimer03];
//    [self.button03 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container03 addSubview:self.button03];
    
    self.button04 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button04.layer.cornerRadius = round;
//    [self letterSwapTimer04];
//    [self.button04 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container03 addSubview:self.button04];
    
    self.button05 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.button05.layer.cornerRadius = round;
//    [self letterSwapTimer04];
//    [self.button05 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container04 addSubview:self.button05];
    
    self.button06 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button06.layer.cornerRadius = round;
//    [self letterSwapTimer03];
//    [self.button06 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container04 addSubview:self.button06];
    
    self.button07 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button07.layer.cornerRadius = round;
//    [self letterSwapTimer02];
//    [self.button07 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container04 addSubview:self.button07];
    
    self.button08 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button08.layer.cornerRadius = round;
//    [self letterSwapTimer01];
//    [self.button08 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container04 addSubview:self.button08];
    
    self.button09 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.button09.layer.cornerRadius = round;
//    [self letterSwapTimer03];
//    [self.button09 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container05 addSubview:self.button09];
    
    self.button10 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button10.layer.cornerRadius = round;
//    [self letterSwapTimer01];
//    [self.button10 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container05 addSubview:self.button10];
    
    self.button11 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button11.layer.cornerRadius = round;
//    [self letterSwapTimer04];
//    [self.button11 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container05 addSubview:self.button11];
    
    self.button12 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button12.layer.cornerRadius = round;
//    [self letterSwapTimer02];
//    [self.button12 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container05 addSubview:self.button12];
    
    self.button13 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, diameter, diameter)];
    self.button13.layer.cornerRadius = round;
//    [self letterSwapTimer02];
//    [self.button13 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container06 addSubview:self.button13];
    
    self.button14 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+(self.button01.frame.size.width+space), 0, diameter, diameter)];
    self.button14.layer.cornerRadius = round;
//    [self letterSwapTimer04];
//    [self.button14 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container06 addSubview:self.button14];
    
    self.button15 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*2)+space*2), 0, diameter, diameter)];
    self.button15.layer.cornerRadius = round;
//    [self letterSwapTimer01];
//    [self.button15 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container06 addSubview:self.button15];
    
    self.button16 = [[UIButton alloc]initWithFrame:CGRectMake(self.button01.frame.origin.x+((self.button01.frame.size.width*3)+space*3), 0, diameter, diameter)];
    self.button16.layer.cornerRadius = round;
//    [self letterSwapTimer03];
//    [self.button16 addTarget:self action:@selector(buttonTapped:) forControlEvents:(UIControlEvents)UIControlEventTouchUpInside];
    [self.container06 addSubview:self.button16];
    
    [self formatGameButtons:[self buttonArray]];
}

- (IBAction)submitTapped:(id)sender
{
    
}

- (IBAction)backspaceTapped:(id)sender
{
    
}

- (IBAction)clearAllTapped:(id)sender
{
    
}
















@end
