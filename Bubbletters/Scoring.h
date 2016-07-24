//
//  Scoring.h
//  Bubbletters
//
//  Created by Michael Hoffman on 6/2/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Scoring : NSObject

-(NSDictionary *)mainScoringDict;
-(NSInteger)scoring:(NSDictionary *)dict for:(NSMutableArray *)array;
-(NSInteger)valueForLetter:(NSString *)letter;
-(NSInteger)valueForLetter:(NSString *)letter withMultiplier:(NSInteger)multiplier;

@end
