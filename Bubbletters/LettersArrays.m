//
//  LettersArrays.m
//  Bubbletters
//
//  Created by Michael Hoffman on 6/2/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import "LettersArrays.h"

@implementation LettersArrays

-(NSArray *)lettersArray
{
    NSArray *lettersArray = @[@"A", @"A", @"A", @"A", @"A", @"A", @"A", @"A", @"A", @"B", @"B", @"C", @"C", @"D", @"D", @"D", @"D", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"E", @"F", @"F", @"G", @"G", @"G", @"H", @"H", @"I", @"I", @"I", @"I", @"I", @"I", @"I", @"I", @"I", @"J", @"K", @"L", @"L", @"L", @"L", @"M", @"M", @"N", @"N", @"N", @"N", @"N", @"N", @"O", @"O", @"O", @"O", @"O", @"O", @"O", @"O", @"P", @"P", @"Q", @"R", @"R", @"R", @"R", @"R", @"R", @"S", @"S", @"S", @"S", @"T", @"T", @"T", @"T", @"T", @"T", @"U", @"U", @"U", @"U", @"V", @"V", @"W", @"W", @"X", @"Y", @"Y", @"Z"];
    return lettersArray;
}

-(NSMutableArray *)randomizeArray
{
    NSMutableArray *mArray = [NSMutableArray arrayWithArray:[self lettersArray]];
    NSUInteger count = [mArray count];
    if (count >1)
    {
        for (NSInteger i = count-1; i>0; --i)
        {
            [mArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((u_int32_t)i+1)];
        }
    }
    return mArray;
}







@end
