//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Henry Dinhofer on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard()

@property (strong, nonatomic, readwrite)NSString *suit;

@property (strong, nonatomic, readwrite)NSString *rank;

@property (strong, nonatomic, readwrite)NSString *cardLabel;

@property (nonatomic, readwrite)NSUInteger cardValue;

@end

@implementation FISCard

+(NSArray *)validSuits {
    return @[@"♠", @"♥", @"♣", @"♦"];
}

+(NSArray *)validRanks {
    return @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
-(instancetype)init {
    return [self initWithSuit:@"!" rank:@"N"];
}

-(instancetype)initWithSuit:(NSString *)suit
                    rank:(NSString *)rank {
    self = [super init];
    
    if (self) {
        _suit = suit;
        _rank = rank;
        _cardLabel = [NSString stringWithFormat:@"%@%@",suit, rank];
        NSUInteger index = [[FISCard validRanks] indexOfObject:rank] + 1;
        if (index > 10) { index = 10; }
        _cardValue = index;
    }
    return self;
}
-(NSString *)description {
    return [NSString stringWithFormat:@"%@%@",self.suit, self.rank];
}


@end
