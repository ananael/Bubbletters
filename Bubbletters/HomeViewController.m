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
#import "MethodsCache.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIView *backAnimation;
@property (weak, nonatomic) IBOutlet UIView *container01;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UIView *container02;
@property (weak, nonatomic) IBOutlet UIButton *creditsButton;
@property (weak, nonatomic) IBOutlet UIButton *instructionButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property MethodsCache *methods;

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
    
    self.backAnimation.backgroundColor = [UIColor colorWithRed:173/255.0 green:216/255.0 blue:230/255.0 alpha:1.0];
    self.bannerImage.image = [UIImage imageNamed:@"Bubbletters banner"];
    
    self.methods = [MethodsCache new];
    [self.methods levelTitles];
    [self.methods levelScores];
    
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
    return [[self.methods levelTitles] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    //Removes color from tableViewCell.
    cell.backgroundColor = [UIColor clearColor];
    
    cell.cellView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    cell.levelLabel.text = [self.methods levelTitles][indexPath.row];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@", [self.methods levelScores][indexPath.row]];
    
    //Make the cells nonresponsive until the unlockValue changes.
    cell.userInteractionEnabled = NO;
    
    // If it is the first time the game is played, the unlockedLevel userDefault will not have been set, so the first tableViewCell interaction is enabled.
    //After the first game is played (and won), the unlockedLevel userDefault determines which levels are available to play, even after the game has been closed/re-opened.
    //The userDefault value is increased from data paased back from the unwind VC.
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"unlockedLevel"])
    {
        if (indexPath.row == 0)
        {
            cell.userInteractionEnabled = YES;
        }
        
    } else if ([[NSUserDefaults standardUserDefaults]integerForKey:@"unlockedLevel"] > 0)
    {
        if (indexPath.row <= [[NSUserDefaults standardUserDefaults]integerForKey:@"unlockedLevel"])
        {
            cell.userInteractionEnabled = YES;
        }
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
    NSLog(@"NEW Array Contents = %@", [self.methods levelScores]);
}


- (IBAction)creditsTapped:(id)sender
{
    
}

- (IBAction)instructionsTapped:(id)sender
{
    [self performSegueWithIdentifier:@"mainLevelSegue" sender:self];
}


@end
