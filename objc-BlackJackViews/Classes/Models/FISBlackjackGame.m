//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Henry Dinhofer on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame

-(instancetype)init {
    self = [super init];
    if (self) {
        _deck = [[FISCardDeck alloc] init];
        _house = [[FISBlackjackPlayer alloc] initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc] initWithName:@"Player"];
    }
    return self;
}

-(void)playBlackjack {
    [self.deck resetDeck];
    [self dealNewRound];
    for (NSUInteger i = 0; i < 3; i++) {
        [self dealCardToPlayer];
        [self dealCardToHouse];
        if (self.player.busted) {
            break;
        }else if (self.house.busted) {
            break;
        }
    }
    if ([self houseWins]) {
        [self incrementWinsAndLossesForHouseWins:YES];
    }else {
        [self incrementWinsAndLossesForHouseWins:NO];
    }
    
}

-(void)dealNewRound {
    [self.deck resetDeck];
    [self.player resetForNewGame];
    [self.house resetForNewGame];
    FISCard *card = [self.deck drawNextCard];
    FISCard *cardTwo = [self.deck drawNextCard];
    [self.player acceptCard:card];
    [self.player acceptCard:cardTwo];

    card = [self.deck drawNextCard];
    cardTwo = [self.deck drawNextCard];
    [self.house acceptCard:card];
    [self.house acceptCard:cardTwo];
}

-(void)dealCardToPlayer {
    FISCard *card = [self.deck drawNextCard];
    [self.player acceptCard:card];
}

-(void)dealCardToHouse {
    FISCard *card = [self.deck drawNextCard];
    [self.house acceptCard:card];
}

-(void)processPlayerTurn {
    if (self.player.busted == NO && self.player.stayed == NO) {
        [self dealCardToPlayer];
    }
}

-(void)processHouseTurn {
    if (self.house.busted == NO && self.house.stayed == NO) {
        [self dealCardToHouse];
    }
}

-(BOOL)houseWins {
    BOOL houseW = NO;
    if (self.house.blackjack && self.player.blackjack ) {
    }
    else if (self.player.busted)  {
        houseW = YES;
    }
    else if (self.house.handscore >= self.player.handscore &&
             self.house.handscore > 0 &&
             !self.house.busted) {
        houseW = YES;
    }
    
    
    return houseW;
}

-(void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins {
    if (houseWins) {
        self.house.wins++;
        self.player.losses++;
    }else {
        self.player.wins++;
        self.house.losses++;
    }
}


@end
