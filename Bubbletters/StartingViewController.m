//
//  StartingViewController.m
//  Bubbletters
//
//  Created by Michael Hoffman on 6/29/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "StartingViewController.h"

@interface StartingViewController ()

@property (weak, nonatomic) IBOutlet UIView *container01;
@property (weak, nonatomic) IBOutlet UIView *container02;
@property (weak, nonatomic) IBOutlet UIButton *creditsButton;
@property (weak, nonatomic) IBOutlet UIButton *instructionButton;
@property (weak, nonatomic) IBOutlet UIView *scrollContainer;

- (IBAction)creditsTapped:(id)sender;
- (IBAction)instructionsTapped:(id)sender;


@end

@implementation StartingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)creditsTapped:(id)sender
{
    
}

- (IBAction)instructionsTapped:(id)sender
{
    [self performSegueWithIdentifier:@"game01Segue" sender:self];
}














@end
