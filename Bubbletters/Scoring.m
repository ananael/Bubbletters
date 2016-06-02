//
//  Scoring.m
//  Bubbletters
//
//  Created by Michael Hoffman on 6/2/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "Scoring.h"

@implementation Scoring

-(NSDictionary *)mainScoringDict
{
    //Scrabble tile values
    NSDictionary *dict = @{@"A":[NSNumber numberWithInt:1], @"B":[NSNumber numberWithInt:3], @"C":[NSNumber numberWithInt:3], @"D":[NSNumber numberWithInt:2], @"E":[NSNumber numberWithInt:1], @"F":[NSNumber numberWithInt:4], @"G":[NSNumber numberWithInt:2], @"H":[NSNumber numberWithInt:4], @"I":[NSNumber numberWithInt:1], @"J":[NSNumber numberWithInt:8], @"K":[NSNumber numberWithInt:5], @"L":[NSNumber numberWithInt:1], @"M":[NSNumber numberWithInt:3], @"N":[NSNumber numberWithInt:1], @"O":[NSNumber numberWithInt:1], @"P":[NSNumber numberWithInt:3], @"Q":[NSNumber numberWithInt:10], @"R":[NSNumber numberWithInt:1], @"S":[NSNumber numberWithInt:1], @"T":[NSNumber numberWithInt:1], @"U":[NSNumber numberWithInt:1], @"V":[NSNumber numberWithInt:4], @"W":[NSNumber numberWithInt:4], @"X":[NSNumber numberWithInt:8], @"Y":[NSNumber numberWithInt:4], @"Z":[NSNumber numberWithInt:10]};
    return dict;
}

-(NSInteger)scoring:(NSDictionary *)dict for:(NSMutableArray *)array
{
    //Setting the value to "0" provides something for the "+=" to add and sum with.
    //Without setting the value, the sum given is nonsensical.
    NSInteger wordSum = 0;
    NSNumber *value;
    NSMutableArray *values = [NSMutableArray new];
    
    for (NSInteger i=0; i<[array count]; i++)
    {
        if ([array objectAtIndex:i] !=nil)
        {
            //Retrieves the value for each letter in the wordArray and places the values in a mutable array.
            value = [dict valueForKey:[array objectAtIndex:i]];
            [values addObject:value];
        }
    }
    NSLog(@"VALUES: %@", values);
    
    //Each letter value in the array is separated
    for (NSNumber *num in values)
    {
        //Each value is added together
        wordSum += [num integerValue];
    }
    NSLog(@"%ld", (long)wordSum);
    return wordSum;
}


@end
