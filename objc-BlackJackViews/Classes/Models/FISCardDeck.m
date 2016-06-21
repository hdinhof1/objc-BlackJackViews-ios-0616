//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Henry Dinhofer on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

@implementation FISCardDeck

-(instancetype)init {
    self = [super init];
    
    if (self) {
        _remainingCards = [[NSMutableArray alloc] init];
        [self generateCards];
        _dealtCards = [[NSMutableArray alloc] init];
    }
    return self;
}
-(NSString *)description {
    NSMutableString *logString = [NSMutableString stringWithFormat:@"count: %lu\ncards:\n", self.remainingCards.count];
    for (FISCard *card in self.remainingCards) {
        [logString appendFormat:@"%@ ",card.cardLabel];
    }
    
    return logString;
}

-(FISCard *)drawNextCard {
    FISCard *nextCardPicked = [[FISCard alloc] init];
    if (self.remainingCards.count == 0) {
        nextCardPicked = nil;
        NSLog(@"Deck is empty you cannot pick another card!");
    }else {
        nextCardPicked = self.remainingCards[0];
        [self.remainingCards removeObjectAtIndex:0];
        [self.dealtCards addObject:nextCardPicked];
    }
    
    return nextCardPicked;
}

-(void)resetDeck {
    [self gatherDealtCards];
    [self shuffleRemainingCards];
}

-(void)gatherDealtCards {
    
    [self.remainingCards addObjectsFromArray:self.dealtCards]; // helpful method
    [self.dealtCards removeAllObjects];
//    for (FISCard *card in self.remainingCards) { //should be self.dealtcards but fails all tests
//        [self.dealtCards addObject:card];
//        [self.remainingCards removeObject:card];
//    }
}

-(void)shuffleRemainingCards {
    // I would want to empty the remaining cards array because I can now just add each new "randomly picked" card
    NSMutableArray *pickUpDeck = [self.remainingCards mutableCopy];
    [self.remainingCards removeAllObjects];
    
    NSUInteger pickUpDeckCount = pickUpDeck.count;
    for (NSUInteger i =0; i<pickUpDeckCount; i++) {  //
        NSUInteger randomInt = arc4random_uniform((uint32_t)pickUpDeck.count);
        FISCard *randomCard = pickUpDeck[randomInt];
        [self.remainingCards addObject:randomCard];
        [pickUpDeck removeObject:randomCard];
    }
}
-(void) generateCards {
    NSUInteger suit = 0;
    NSUInteger rank = 0;
    for(NSUInteger i= 0; i < 52; i++) {
        if (i % 13 == 0 && i != 0) {
            suit++;
            rank = 0;
        }
        FISCard *card = [[FISCard alloc] initWithSuit:[[FISCard validSuits] objectAtIndex:suit]  rank:[[FISCard validRanks] objectAtIndex:rank]];
        rank++;
     //   NSLog(@"Adding card: %@", card); Did it without two for loops :)
        [_remainingCards addObject:card];
    }
}


@end
