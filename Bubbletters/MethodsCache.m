//
//  MethodsCache.m
//  Bubbletters
//
//  Created by Michael Hoffman on 8/2/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "MethodsCache.h"

@implementation MethodsCache

-(UIColor*)colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}

-(void)selectSpecialTiles:(NSInteger)amount fromArray:(NSMutableArray *)arrayOne toArray:(NSMutableArray *)arrayTwo
{
    UIButton *button;
    for (NSInteger i=0; i<amount; i++)
    {
        NSInteger randomTile = arc4random_uniform((u_int32_t)[arrayOne count]);
        //NSLog(@"Random Pink Button: %ld", (long)randomTile);
        button = [arrayOne objectAtIndex:randomTile];
        [arrayTwo addObject:button];
        [arrayOne removeObject:button];
    }
}

-(NSArray *)levelTitles
{
    NSArray *titles = @[@"Level 1", @"Level 2", @"Level 3", @"Level 4", @"Level 5", @"Level 6", @"Level 7", @"Level 8", @"Level 9", @"Level 10", @"Level 11", @"Level 12", @"Level 13", @"Level 14", @"Level 15", @"Level 16", @"Level 17", @"Level 18", @"Level 19", @"Level 20", @"Level 21", @"Level 22", @"Level 23", @"Level 24", @"Level 25"];
    return titles;
}

-(NSMutableArray *)levelScores
{
    NSString *level1;
    NSString *level2;
    NSString *level3;
    NSString *level4;
    NSString *level5;
    NSString *level6;
    NSString *level7;
    NSString *level8;
    NSString *level9;
    NSString *level10;
    NSString *level11;
    NSString *level12;
    NSString *level13;
    NSString *level14;
    NSString *level15;
    NSString *level16;
    NSString *level17;
    NSString *level18;
    NSString *level19;
    NSString *level20;
    NSString *level21;
    NSString *level22;
    NSString *level23;
    NSString *level24;
    NSString *level25;
    //Creates a mutable array that will update whenever userDefaults change.
    //The initial value of each userDefault will show as "0" when the app first launches, and until a userDefault receives a value equal-to or greater-than "0".
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level1Score"])
    {
        level1 = @"";
    } else
    {
        level1 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level1Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level2Score"])
    {
        level2 = @"";
    } else
    {
        level2 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level2Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level3Score"])
    {
        level3 = @"";
    } else
    {
        level3 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level3Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level4Score"])
    {
        level4 = @"";
    } else
    {
        level4 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level4Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level5Score"])
    {
        level5 = @"";
    } else
    {
        level5 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level5Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level6Score"])
    {
        level6 = @"";
    } else
    {
        level6 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level6Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level7Score"])
    {
        level7 = @"";
    } else
    {
        level7 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level7Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level8Score"])
    {
        level8 = @"";
    } else
    {
        level8 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level8Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level9Score"])
    {
        level9 = @"";
    } else
    {
        level9 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level9Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level10Score"])
    {
        level10 = @"";
    } else
    {
        level10 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level10Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level11Score"])
    {
        level11 = @"";
    } else
    {
        level11 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level11Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level12Score"])
    {
        level12 = @"";
    } else
    {
        level12 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level12Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level13Score"])
    {
        level13 = @"";
    } else
    {
        level13 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level13Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level14Score"])
    {
        level14 = @"";
    } else
    {
        level14 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level14Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level15Score"])
    {
        level15 = @"";
    } else
    {
        level15 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level15Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level16Score"])
    {
        level16 = @"";
    } else
    {
        level16 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level16Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level17Score"])
    {
        level17 = @"";
    } else
    {
        level17 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level17Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level18Score"])
    {
        level18 = @"";
    } else
    {
        level18 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level18Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level19Score"])
    {
        level19 = @"";
    } else
    {
        level19 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level19Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level20Score"])
    {
        level20 = @"";
    } else
    {
        level20 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level20Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level21Score"])
    {
        level21 = @"";
    } else
    {
        level21 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level21Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level22Score"])
    {
        level22 = @"";
    } else
    {
        level22 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level22Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level23Score"])
    {
        level23 = @"";
    } else
    {
        level23 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level23Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level24Score"])
    {
        level24 = @"";
    } else
    {
        level24 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level24Score"]];
    }
    if (![[NSUserDefaults standardUserDefaults]integerForKey:@"Level25Score"])
    {
        level25 = @"";
    } else
    {
        level25 = [NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults]integerForKey:@"Level25Score"]];
    }
    
    NSMutableArray *scores = [NSMutableArray arrayWithObjects:level1, level2, level3, level4, level5, level6, level7, level8, level9, level10, level11, level12, level13, level14, level15, level16, level17, level18, level19, level20, level21, level22, level23, level24, level25, nil];
    return scores;
    
}

-(NSInteger)previousLevelScoreforRow:(NSInteger)row
{
    NSInteger score;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (row)
    {
        case 0:
            score = [defaults integerForKey:@"Level1Score"];
            break;
        case 1:
            score = [defaults integerForKey:@"Level2Score"];
            break;
        case 2:
            score = [defaults integerForKey:@"Level3Score"];
            break;
        case 3:
            score = [defaults integerForKey:@"Level4Score"];
            break;
        case 4:
            score = [defaults integerForKey:@"Level5Score"];
            break;
        case 5:
            score = [defaults integerForKey:@"Level6Score"];
            break;
        case 6:
            score = [defaults integerForKey:@"Level7Score"];
            break;
        case 7:
            score = [defaults integerForKey:@"Level8Score"];
            break;
        case 8:
            score = [defaults integerForKey:@"Level9Score"];
            break;
        case 9:
            score = [defaults integerForKey:@"Level10Score"];
            break;
        case 10:
            score = [defaults integerForKey:@"Level11Score"];
            break;
        case 11:
            score = [defaults integerForKey:@"Level12Score"];
            break;
        case 12:
            score = [defaults integerForKey:@"Level13Score"];
            break;
        case 13:
            score = [defaults integerForKey:@"Level14Score"];
            break;
        case 14:
            score = [defaults integerForKey:@"Level15Score"];
            break;
        case 15:
            score = [defaults integerForKey:@"Level16Score"];
            break;
        case 16:
            score = [defaults integerForKey:@"Level17Score"];
            break;
        case 17:
            score = [defaults integerForKey:@"Level18Score"];
            break;
        case 18:
            score = [defaults integerForKey:@"Level19Score"];
            break;
        case 19:
            score = [defaults integerForKey:@"Level20Score"];
            break;
        case 20:
            score = [defaults integerForKey:@"Level21Score"];
            break;
        case 21:
            score = [defaults integerForKey:@"Level22Score"];
            break;
        case 22:
            score = [defaults integerForKey:@"Level23Score"];
            break;
        case 23:
            score = [defaults integerForKey:@"Level24Score"];
            break;
        case 24:
            score = [defaults integerForKey:@"Level25Score"];
            break;
            
        default:
            break;
    }
    return score;
}

-(void)updateLevelScore:(NSInteger)score forRow:(NSInteger)row
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (row)
    {
        case 0:
            [defaults setInteger:score forKey:@"Level1Score"];
            break;
        case 1:
            [defaults setInteger:score forKey:@"Level2Score"];
            break;
        case 2:
            [defaults setInteger:score forKey:@"Level3Score"];
            break;
        case 3:
            [defaults setInteger:score forKey:@"Level4Score"];
            break;
        case 4:
            [defaults setInteger:score forKey:@"Level5Score"];
            break;
        case 5:
            [defaults setInteger:score forKey:@"Level6Score"];
            break;
        case 6:
            [defaults setInteger:score forKey:@"Level7Score"];
            break;
        case 7:
            [defaults setInteger:score forKey:@"Level8Score"];
            break;
        case 8:
            [defaults setInteger:score forKey:@"Level9Score"];
            break;
        case 9:
            [defaults setInteger:score forKey:@"Level10Score"];
            break;
        case 10:
            [defaults setInteger:score forKey:@"Level11Score"];
            break;
        case 11:
            [defaults setInteger:score forKey:@"Level12Score"];
            break;
        case 12:
            [defaults setInteger:score forKey:@"Level13Score"];
            break;
        case 13:
            [defaults setInteger:score forKey:@"Level14Score"];
            break;
        case 14:
            [defaults setInteger:score forKey:@"Level15Score"];
            break;
        case 15:
            [defaults setInteger:score forKey:@"Level16Score"];
            break;
        case 16:
            [defaults setInteger:score forKey:@"Level17Score"];
            break;
        case 17:
            [defaults setInteger:score forKey:@"Level18Score"];
            break;
        case 18:
            [defaults setInteger:score forKey:@"Level19Score"];
            break;
        case 19:
            [defaults setInteger:score forKey:@"Level20Score"];
            break;
        case 20:
            [defaults setInteger:score forKey:@"Level21Score"];
            break;
        case 21:
            [defaults setInteger:score forKey:@"Level22Score"];
            break;
        case 22:
            [defaults setInteger:score forKey:@"Level23Score"];
            break;
        case 23:
            [defaults setInteger:score forKey:@"Level24Score"];
            break;
        case 24:
            [defaults setInteger:score forKey:@"Level25Score"];
            break;
            
        default:
            break;
    }
    
}












@end
