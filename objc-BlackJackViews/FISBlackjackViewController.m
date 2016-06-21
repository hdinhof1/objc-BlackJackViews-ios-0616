//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Henry Dinhofer on 6/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController()

@property (weak, nonatomic) IBOutlet UILabel *winner;
@property (weak, nonatomic) IBOutlet UILabel *houseScore;
@property (weak, nonatomic) IBOutlet UILabel *houseStayed;
@property (weak, nonatomic) IBOutlet UILabel *houseCard1;
@property (weak, nonatomic) IBOutlet UILabel *houseCard2;
@property (weak, nonatomic) IBOutlet UILabel *houseCard3;
@property (weak, nonatomic) IBOutlet UILabel *houseCard4;
@property (weak, nonatomic) IBOutlet UILabel *houseCard5;
@property (weak, nonatomic) IBOutlet UILabel *houseBlackjack;
@property (weak, nonatomic) IBOutlet UILabel *houseWins;
@property (weak, nonatomic) IBOutlet UILabel *houseBust;
@property (weak, nonatomic) IBOutlet UILabel *houseLosses;


@property (weak, nonatomic) IBOutlet UILabel *playerScore;
@property (weak, nonatomic) IBOutlet UILabel *playerStayed;
@property (weak, nonatomic) IBOutlet UILabel *playerCard1;
@property (weak, nonatomic) IBOutlet UILabel *playerCard2;
@property (weak, nonatomic) IBOutlet UILabel *playerCard3;
@property (weak, nonatomic) IBOutlet UILabel *playerCard4;
@property (weak, nonatomic) IBOutlet UILabel *playerCard5;
@property (weak, nonatomic) IBOutlet UILabel *playerBust;
@property (weak, nonatomic) IBOutlet UILabel *playerBlackjack;
@property (weak, nonatomic) IBOutlet UILabel *playerWins;
@property (weak, nonatomic) IBOutlet UILabel *playerLosses;


@property (weak, nonatomic) IBOutlet UIButton *deal;
@property (weak, nonatomic) IBOutlet UIButton *hit;
@property (weak, nonatomic) IBOutlet UIButton *stay;



@end


@implementation FISBlackjackViewController

-(void)viewDidLoad {
    self.game = [[FISBlackjackGame alloc] init];
    
    [self.game.deck shuffleRemainingCards];
    
    [self resetLabelsAndGame];

    
//    self.winner.hidden = self.houseCard1.hidden = self.houseCard2.hidden = self.houseCard3.hidden = self.houseCard4.hidden = self.houseCard5.hidden = self.houseStayed.hidden = self.houseBust.hidden = self.houseBlackjack.hidden = self.houseScore.hidden
//        = YES;
//    
//    self.playerCard1.hidden = self.playerCard2.hidden = self.playerCard3.hidden = self.playerCard4.hidden = self.playerCard5.hidden = self.playerStayed.hidden = self.playerBust.hidden = self.playerBlackjack.hidden = self.houseScore.hidden
//        = YES;
//    
//    
//    self.playerScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.player.handscore];
//    self.houseScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.house.handscore];
    
    
}

- (IBAction)startGameTapped:(id)sender {
    [self resetLabelsAndGame];
    [self.game dealNewRound];
    
    self.playerCard1.hidden = self.playerCard2.hidden = self.playerScore.hidden = NO;
    self.playerCard1.text = [self.game.player.cardsInHand[0] description];
    self.playerCard2.text = [self.game.player.cardsInHand[1] description];
    self.playerScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.player.handscore];
    
    self.houseCard1.hidden = self.houseCard2.hidden = self.houseScore.hidden = NO;
    self.houseCard1.text = [self.game.house.cardsInHand[0] description];
    self.houseCard2.text = [self.game.house.cardsInHand[1] description];
    self.houseScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.house.handscore];
    
    self.deal.enabled = NO;
    self.hit.enabled  = self.stay.enabled = YES;
    
    if (self.game.house.handscore == 21) {
        [self.game incrementWinsAndLossesForHouseWins:YES];
//        self.winner.hidden = NO;
        self.houseBlackjack.hidden = NO;
        self.deal.enabled = YES;
//        self.stay.enabled = YES;
        
    }
    else if (self.game.player.handscore == 21) {
        [self.game incrementWinsAndLossesForHouseWins:NO];
//        self.winner.hidden = NO;
        self.playerBlackjack.hidden = NO;
        self.deal.enabled = YES;
//        self.stay.enabled = YES;
    }
    
//    if (self.winner.hidden == NO) {
//        [self resetLabelsAndGame];
//        [self.game dealNewRound];
//    }
    
    NSLog(@"%@", self.game.player);
    NSLog(@"%@", self.game.house);
    
    
}
- (IBAction)hitButtonTapped:(id)sender {
    
    if (self.game.player.stayed == 0) {
        [self.game processPlayerTurn];
        [self updateCardLabelsAndScore];
        NSLog(@"%@", self.game.player);
    }
    self.playerScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.player.handscore];
    
    if (self.game.player.busted == 0) {
        [self.game processHouseTurn];
        [self updateCardLabelsAndScore];
        NSLog(@"%@", self.game.house);
    }
    self.houseScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.house.handscore];
//    }else if (self.game.player.stayed) {  //might be just if statement
//        while ([self.game.house shouldHit]) {
//            [self.game processHouseTurn];
//        }
//    }
    
    
}
- (IBAction)stayButtonTapped:(id)sender {
    self.game.player.stayed = YES;
    
    self.hit.enabled = NO;
    self.playerStayed.hidden = NO;
    
    
    //stay should reenable the deal button if the deal did not produce a winner
    
    //houses turn
    while ([self.game.house shouldHit] == YES) {
        [self.game processHouseTurn];
        [self updateCardLabelsAndScore];
    }
    self.houseStayed.hidden = NO;
    
    
    //practice with ternary conditionals
    // [self.game houseWins] ? [self.game incrementWinsAndLossesForHouseWins:YES] : [self.game incrementWinsAndLossesForHouseWins:NO];
    if ([self.game houseWins]) {
        [self.game incrementWinsAndLossesForHouseWins:YES];
        NSLog(@"HouseWins! With hand %@", self.game.house);
        self.houseScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.house.handscore];
    }else {
        [self.game incrementWinsAndLossesForHouseWins:NO];
        self.playerScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.player.handscore];
        NSLog(@"PlayerWins! You go you %@", self.game.player);
    }


    //if isWinner
//    if ( (self.game.player.stayed && self.game.player.blackjack && self.game.player.cardsInHand.count == 2) ||
//        ( self.game.house.stayed  && self.game.house.blackjack  && self.game.house.cardsInHand.count == 2) ) {
//               self.stay.enabled = YES;
//
//    }
    
    self.winner.hidden = NO;
    self.deal.enabled = YES;
    

}

// will update all the card info for both house and player
-(void)updateCardLabelsAndScore {
    NSUInteger houseCount = self.game.house.cardsInHand.count;
    NSUInteger playerCount = self.game.player.cardsInHand.count;
    if (playerCount == 3) {
        self.playerCard3.hidden = NO;
        self.playerCard3.text = [self.game.player.cardsInHand[2] description];
    }else if (playerCount == 4) {
        self.playerCard4.hidden = NO;
        self.playerCard4.text = [self.game.player.cardsInHand[3] description];
    }else if (playerCount == 5) {
        self.playerCard4.hidden = NO;
        self.playerCard5.text = [self.game.player.cardsInHand[4] description];
    }
    
    if (houseCount == 3) {
        self.houseCard3.hidden = NO;
        self.houseCard3.text = [self.game.house.cardsInHand[2] description];
    }else if (houseCount == 4) {
        self.houseCard4.hidden = NO;
        self.houseCard4.text = [self.game.house.cardsInHand[3] description];
    }else if (houseCount == 5) {
        self.houseCard5.hidden = NO;
        self.houseCard5.text = [self.game.house.cardsInHand[4] description];
    }
    
    
    self.playerScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.player.handscore];
    self.houseScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.house.handscore];
    
    if (self.game.player.busted) { self.playerBust.hidden = NO; }
    if (self.game.house.busted)  { self.houseBust.hidden  = NO; }

}
-(void)resetLabelsAndGame {
    self.winner.hidden = self.houseCard1.hidden = self.houseCard2.hidden = self.houseCard3.hidden = self.houseCard4.hidden = self.houseCard5.hidden = self.houseStayed.hidden = self.houseBust.hidden = self.houseBlackjack.hidden = self.houseScore.hidden
    = YES;
    
    self.playerCard1.hidden = self.playerCard2.hidden = self.playerCard3.hidden = self.playerCard4.hidden = self.playerCard5.hidden = self.playerStayed.hidden = self.playerBust.hidden = self.playerBlackjack.hidden = self.houseScore.hidden
    = YES;
    
    
    self.playerScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.player.handscore];
    self.houseScore.text = [[NSString alloc] initWithFormat:@"Score: %lu", (unsigned long)self.game.house.handscore];
    
    self.playerWins.text = [[NSString alloc] initWithFormat:@"Wins %lu", (unsigned long)self.game.player.wins ];
    self.playerLosses.text = [[NSString alloc] initWithFormat:@"Losses %lu", (unsigned long)self.game.player.losses ];
    
    self.houseWins.text = [[NSString alloc] initWithFormat:@"Wins %lu", (unsigned long)self.game.house.wins ];
    self.houseLosses.text = [[NSString alloc] initWithFormat:@"Losses %lu", (unsigned long)self.game.house.losses ];
    
    
    [self.game.deck resetDeck];

}
@end
