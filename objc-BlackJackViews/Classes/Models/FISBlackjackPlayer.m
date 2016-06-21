//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Henry Dinhofer on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@implementation FISBlackjackPlayer

//tried out [NSMutableArray new] and didnt include in header -(instancetype)init;
- (instancetype)init
{
    return [self initWithName:@""];
}


-(instancetype)initWithName:(NSString *)name {
    self = [super init];
    
    if (self) {
        _name = name;
        _cardsInHand = [NSMutableArray new];
        _handscore = 0;
        _wins = 0;
        _losses = 0;
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
    }
    
    return self;
}
-(NSString *)description {
    NSMutableString *name = [[NSMutableString alloc] init];
    NSMutableString *cardsInHandStr = [[NSMutableString alloc] init];

    for (FISCard *card in self.cardsInHand) {
        [cardsInHandStr appendFormat:@"%@ ",card];
    }
    
    [name appendFormat:@"FISBlackjackPlayer:\n\t"
     "name: %@\n\t"
     "cards: %@\n\t"
     "handscore: %lu\n\t"
     "ace in hand: %d\n\t"
     "stayed: %d\n\t"
     "blackjack: %d\n\t"
     "busted: %d\n\t"
     "wins: %lu\n\t"
     "losses: %lu\n\t",
     self.name,cardsInHandStr,self.handscore,self.aceInHand,self.stayed,self.blackjack,self.busted,self.wins,self.losses];
    return name;
}


-(void)resetForNewGame {
    [self.cardsInHand removeAllObjects];
    self.handscore = self.aceInHand = self.stayed = self.blackjack = self.busted = 0;
    
    
}
-(void)acceptCard:(FISCard *)card {
    [self.cardsInHand addObject:card];
    
    if ([card.rank isEqualToString:@"A"]) {
        self.aceInHand = YES;
        if (self.handscore < 11) {
            self.handscore += 11;
        } else {
            self.handscore += 1;
        }
    } else {
        self.handscore += card.cardValue;
    }
    [self shouldHit];
    if (self.handscore == 21) { self.blackjack = YES; }
    if (self.handscore > 21 ) { self.busted = YES; }
}

-(BOOL)shouldHit {
    BOOL shouldHit = YES;
    if (self.handscore > 17) {
        self.stayed = YES;
        shouldHit = NO;
    }
    
    return shouldHit;
}
@end
