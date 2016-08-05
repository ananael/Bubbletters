//
//  HomeViewController.m
//  Bubbletters
//
//  Created by Michael Hoffman on 7/7/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "MainLevelViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIView *backAnimation;
@property (weak, nonatomic) IBOutlet UIView *container01;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UIView *container02;
@property (weak, nonatomic) IBOutlet UIButton *creditsButton;
@property (weak, nonatomic) IBOutlet UIButton *instructionButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *levelScores;

@property NSArray *testArray01;
@property NSArray *testArray03;

- (IBAction)creditsTapped:(id)sender;
- (IBAction)instructionsTapped:(id)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 85;
    
    //Removes unused cells from tableView.
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //Removes color from tableView.
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"unlockedLevel"];
    
    self.backAnimation.backgroundColor = [UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0];
    self.bannerImage.image = [UIImage imageNamed:@"Bubbletters banner"];
    
    self.testArray01 = @[@"Level 01", @"Level 02", @"Level 03", @"Level 04", @"Level 05", @"Level 06", @"Level 07", @"Level 08", @"Level 09", @"Level 10", @"Level 11", @"Level 12", @"Level 13", @"Level 14", @"Level 15"];
    self.testArray03 = @[@1000, @478, @10000, @537, @19, @620, @9264, @500, @96, @453, @123, @775, @340, @223, @876];
    
    self.levelScores = [NSMutableArray arrayWithObjects:@0, @0, @0, @0, @0, @0, @0, @0, @0, @0, nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// **********  VERY IMPORTANT TO UPDATE TABEVIEW ON RETURN!! **********
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.testArray01 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    //Removes color from tableViewCell.
    cell.backgroundColor = [UIColor clearColor];
    
    cell.cellView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    cell.levelLabel.text = self.testArray01[indexPath.row];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@", self.levelScores[indexPath.row]];
    
    //Make the cell nonresponsive until the unlockValue changes.
    //The userDefault value is initially set at "0" in viewDidLoad, so that the first cell is enabled.
    //The userDefault value is increased from data paased back from the unwind VC.
    cell.userInteractionEnabled = NO;
    
    if (indexPath.row <= [[NSUserDefaults standardUserDefaults]integerForKey:@"unlockedLevel"])
    {
        cell.userInteractionEnabled = YES;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0)
    {
        [self performSegueWithIdentifier:@"mainLevelSegue" sender:self];
    }
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if ([segue.identifier isEqualToString:@"mainLevelSegue"])
     {
         MainLevelViewController *mainVC = segue.destinationViewController;
         NSIndexPath *selectedPath = [self.tableView indexPathForSelectedRow];
         NSLog(@"Selected Path = %lu", (long)selectedPath.row);
         mainVC.selectedRow = selectedPath.row;
     }
     
     
 }

-(IBAction)returnToMainVC:(UIStoryboardSegue *)unwindSegue
{
    if ([unwindSegue.identifier isEqualToString:@"unwindMainLevel"])
    {
        MainLevelViewController *mainVC= unwindSegue.sourceViewController;
        
        NSLog(@"Number = %ld\nScore = %@", (long)mainVC.selectedRow, mainVC.finalScore);
        
        //This allows me to change the player's level score ONLY if the new value is higher than the old value.
        if (mainVC.finalScore > [self.levelScores objectAtIndex:mainVC.selectedRow])
        {
            [self.levelScores replaceObjectAtIndex:mainVC.selectedRow withObject:mainVC.finalScore];
        }
    }
}


- (IBAction)creditsTapped:(id)sender
{
    
}

- (IBAction)instructionsTapped:(id)sender
{
    [self performSegueWithIdentifier:@"mainLevelSegue" sender:self];
}


@end
