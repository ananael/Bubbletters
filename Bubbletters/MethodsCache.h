//
//  MethodsCache.h
//  Bubbletters
//
//  Created by Michael Hoffman on 8/2/16.
//  Copyright © 2016 Strong Atomic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MethodsCache : NSObject

-(UIColor*)colorWithHexString:(NSString*)hex alpha:(CGFloat)alpha;
-(void)selectSpecialTiles:(NSInteger)amount fromArray:(NSMutableArray *)arrayOne toArray:(NSMutableArray *)arrayTwo;

@end
