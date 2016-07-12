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
    NSDictionary *dict = @{@"A":[NSNumber numberWithInt:1], @"B":[NSNumber numberWithInt:3], @"C":[NSNumber numberWithInt:3], @"D":[NSNumber numberWithInt:3], @"E":[NSNumber numberWithInt:1], @"F":[NSNumber numberWithInt:4], @"G":[NSNumber numberWithInt:3], @"H":[NSNumber numberWithInt:3], @"I":[NSNumber numberWithInt:1], @"J":[NSNumber numberWithInt:9], @"K":[NSNumber numberWithInt:8], @"L":[NSNumber numberWithInt:1], @"M":[NSNumber numberWithInt:4], @"N":[NSNumber numberWithInt:1], @"O":[NSNumber numberWithInt:1], @"P":[NSNumber numberWithInt:2], @"Q":[NSNumber numberWithInt:10], @"R":[NSNumber numberWithInt:1], @"S":[NSNumber numberWithInt:1], @"T":[NSNumber numberWithInt:1], @"U":[NSNumber numberWithInt:2], @"V":[NSNumber numberWithInt:5], @"W":[NSNumber numberWithInt:5], @"X":[NSNumber numberWithInt:9], @"Y":[NSNumber numberWithInt:3], @"Z":[NSNumber numberWithInt:10]};
    return dict;
}

-(NSDictionary *)doubleScoringDict
{
    //Scrabble tile values
    NSDictionary *dict = @{@"A":[NSNumber numberWithInt:2], @"B":[NSNumber numberWithInt:6], @"C":[NSNumber numberWithInt:6], @"D":[NSNumber numberWithInt:6], @"E":[NSNumber numberWithInt:2], @"F":[NSNumber numberWithInt:8], @"G":[NSNumber numberWithInt:6], @"H":[NSNumber numberWithInt:6], @"I":[NSNumber numberWithInt:2], @"J":[NSNumber numberWithInt:18], @"K":[NSNumber numberWithInt:16], @"L":[NSNumber numberWithInt:2], @"M":[NSNumber numberWithInt:8], @"N":[NSNumber numberWithInt:2], @"O":[NSNumber numberWithInt:2], @"P":[NSNumber numberWithInt:4], @"Q":[NSNumber numberWithInt:20], @"R":[NSNumber numberWithInt:2], @"S":[NSNumber numberWithInt:2], @"T":[NSNumber numberWithInt:2], @"U":[NSNumber numberWithInt:4], @"V":[NSNumber numberWithInt:10], @"W":[NSNumber numberWithInt:10], @"X":[NSNumber numberWithInt:18], @"Y":[NSNumber numberWithInt:6], @"Z":[NSNumber numberWithInt:20]};
    return dict;
}

-(NSDictionary *)tripleScoringDict
{
    //Scrabble tile values
    NSDictionary *dict = @{@"A":[NSNumber numberWithInt:3], @"B":[NSNumber numberWithInt:9], @"C":[NSNumber numberWithInt:9], @"D":[NSNumber numberWithInt:9], @"E":[NSNumber numberWithInt:3], @"F":[NSNumber numberWithInt:12], @"G":[NSNumber numberWithInt:9], @"H":[NSNumber numberWithInt:9], @"I":[NSNumber numberWithInt:3], @"J":[NSNumber numberWithInt:27], @"K":[NSNumber numberWithInt:24], @"L":[NSNumber numberWithInt:3], @"M":[NSNumber numberWithInt:12], @"N":[NSNumber numberWithInt:3], @"O":[NSNumber numberWithInt:3], @"P":[NSNumber numberWithInt:6], @"Q":[NSNumber numberWithInt:30], @"R":[NSNumber numberWithInt:3], @"S":[NSNumber numberWithInt:3], @"T":[NSNumber numberWithInt:3], @"U":[NSNumber numberWithInt:6], @"V":[NSNumber numberWithInt:15], @"W":[NSNumber numberWithInt:15], @"X":[NSNumber numberWithInt:27], @"Y":[NSNumber numberWithInt:9], @"Z":[NSNumber numberWithInt:30]};
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
