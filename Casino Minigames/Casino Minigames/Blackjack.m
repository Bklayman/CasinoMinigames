#include "Blackjack.h"
#include "Card.h"
#include "Singleton.h"

@interface Blackjack ()

@end

@implementation Blackjack

NSMutableArray* playerCardsBlackjack;
NSMutableArray* dealerCardsBlackjack;
NSMutableArray* deckBlackjack;
bool roundInProgress;
int betAmount;

- (void)viewDidLoad{
    [super viewDidLoad];
    playerCardsBlackjack = [[NSMutableArray alloc] init];
    dealerCardsBlackjack = [[NSMutableArray alloc] init];
    deckBlackjack = [Card shuffleDeckRandom:[Card createDeck]];
    _fundsAmount.text = [NSString stringWithFormat:@"%d", [Singleton sharedObject].totalMoney];
}

- (void)startRound{
    [self getPlayerCardImage:0].hidden = FALSE;
    [self getPlayerCardImage:1].hidden = FALSE;
    [self getDealerCardImage:0].hidden = FALSE;
    [self getDealerCardImage:1].hidden = FALSE;
    for(int i = 0; i < 6; i++){
        [self getPlayerCardImage:(i+2)].hidden = TRUE;
        [self getDealerCardImage:(i+2)].hidden = TRUE;
    }
    [playerCardsBlackjack addObject:[self drawCardWithCheck]];
    [playerCardsBlackjack addObject:[self drawCardWithCheck]];
    [dealerCardsBlackjack addObject:[self drawCardWithCheck]];
    [dealerCardsBlackjack addObject:[self drawCardWithCheck]];
    [self setCardImage:0 :playerCardsBlackjack[0]];
    [self setCardImage:1 :playerCardsBlackjack[1]];
    _dealerCard1.image = [UIImage imageNamed:@"red_back"];
    _dealerCard2.image = [UIImage imageNamed:@"red_back"];
    roundInProgress = TRUE;
}

- (IBAction)playAgainButtonPressed:(id)sender{
    _betButton.hidden = FALSE;
    _betText.hidden = FALSE;
    _playAgainButton.hidden = TRUE;
}

- (IBAction)betButtonPressed:(id)sender{
    NSString* betText = _betText.text;
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:betText options:0 range:NSMakeRange(0, [betText length])];
    if(numberOfMatches == 0){
        return; //betText is not a valid integer
    }
    betAmount = [betText intValue];
    _betAmount.text = _betText.text;
    _betText.hidden = TRUE;
    _betButton.hidden = TRUE;
    _betText.text = @"";
    [self startRound];
}

- (IBAction)hitButtonPressed:(id)sender{
    if(!roundInProgress){
        return;
    }
    [playerCardsBlackjack addObject:[self drawCardWithCheck]];
    [self setCardImage:((int)[playerCardsBlackjack count] - 1) :playerCardsBlackjack[[playerCardsBlackjack count] - 1]];
    [self getPlayerCardImage:(int)[playerCardsBlackjack count] - 1].hidden = FALSE;
    int points = [self getHandValue:playerCardsBlackjack];
    if(points > 21 || points < 0){
        [self dealerTurn];
    }
}

- (IBAction)standButtonPressed:(id)sender{
    if(!roundInProgress){
        return;
    }
    [self dealerTurn];
}

- (void)dealerTurn{
    [self setCardImage:8 :dealerCardsBlackjack[0]];
    [self setCardImage:9 :dealerCardsBlackjack[1]];
    while([self getHandValue:dealerCardsBlackjack] < 16){
        [self dealerHit];
    }
    [self determineWinner];
}

- (void)dealerHit{
    [dealerCardsBlackjack addObject:[self drawCardWithCheck]];
    [self setCardImage:((int)[dealerCardsBlackjack count] + 7) :dealerCardsBlackjack[(int)[dealerCardsBlackjack count] - 1]];
    [self getDealerCardImage:(int)[dealerCardsBlackjack count] - 1].hidden = FALSE;
}

-(void)determineWinner{
    roundInProgress = FALSE;
    int playerPoints = [self getHandValue:playerCardsBlackjack];
    int dealerPoints = [self getHandValue:dealerCardsBlackjack];
    if(playerPoints < 22 && playerPoints > dealerPoints){
        [Singleton sharedObject].totalMoney+= betAmount;
    } else {
        [Singleton sharedObject].totalMoney-= betAmount;
    }
    _fundsAmount.text = [NSString stringWithFormat:@"%d", [Singleton sharedObject].totalMoney];
    _playAgainButton.hidden = FALSE;
}

- (NSMutableArray*)handValueHelper:(int)curValue :(NSMutableArray*)hand :(int)curIndex{//Returns array of point totals
    NSMutableArray* result = [[NSMutableArray alloc] init];
    while(curIndex < [hand count]){
        Card* curCard = hand[curIndex];
        NSString* curValueName = curCard.value;
        if([curValueName isEqualToString:@"Ace"]){
            NSMutableArray* add1 = [self handValueHelper:(curValue + 1) :hand :(curIndex + 1)];
            NSMutableArray* add11 = [self handValueHelper:(curValue + 11) :hand :(curIndex + 1)];
            for(int i = 0; i < [add1 count]; i++){
                [result addObject:add1[i]];
            }
            for(int i = 0; i < [add11 count]; i++){
                [result addObject:add11[i]];
            }
            break;
        } else {
            curValue+= [hand[curIndex] getValueInt:curValueName];
        }
        curIndex++;
    }
    [result addObject:[NSNumber numberWithInt:curValue]];
    for(int i = 0; i < [result count]; i++){
        if([result[i] intValue] > 21){
            [result removeObjectAtIndex:i];
            i--;
        }
    }
    return result;
}

- (void)setCardImage:(int)index :(Card*)card{ //index: 0-7 -> Player, 8-15 -> Dealer
    UIImageView* image;
    if(index < 8){
        image = [self getPlayerCardImage:index];
    } else {
        image = [self getDealerCardImage:(index - 8)];
    }
    image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:card]]];
}

- (UIImageView*)getDealerCardImage:(int)index{
    switch(index){
        case 0:
            return _dealerCard1;
            break;
        case 1:
            return _dealerCard2;
            break;
        case 2:
            return _dealerCard3;
            break;
        case 3:
            return _dealerCard4;
            break;
        case 4:
            return _dealerCard5;
            break;
        case 5:
            return _dealerCard6;
            break;
        case 6:
            return _dealerCard7;
            break;
        case 7:
            return _dealerCard8;
            break;
    }
    return NULL;
}

- (UIImageView*)getPlayerCardImage:(int)index{
    switch(index){
        case 0:
            return _playerCard1;
            break;
        case 1:
            return _playerCard2;
            break;
        case 2:
            return _playerCard3;
            break;
        case 3:
            return _playerCard4;
            break;
        case 4:
            return _playerCard5;
            break;
        case 5:
            return _playerCard6;
            break;
        case 6:
            return _playerCard7;
            break;
        case 7:
            return _playerCard8;
            break;
    }
    return NULL;
}

- (int)getHandValue:(NSMutableArray*)hand{
    NSMutableArray* totals = [self handValueHelper:0 :hand :0];
    int bestScore = -1;
    for(int i = 0; i < [totals count]; i++){
        if([totals[i] intValue] < 22 && [totals[i] intValue] > bestScore){
            bestScore = [totals[i] intValue];
        }
    }
    return bestScore;
}
 
- (Card*)drawCardWithCheck{
    if([deckBlackjack count] == 0){
        deckBlackjack = [Card shuffleDeckRandom: [Card createDeck]];
        [self removeUsedCards:playerCardsBlackjack];
        [self removeUsedCards:dealerCardsBlackjack];
    }
    Card* result = deckBlackjack[0];
    [deckBlackjack removeObjectAtIndex:0];
    return result;
}

- (void)removeUsedCards:(NSMutableArray*)hand{
    for(int i = 0; i < [hand count]; i++){
        for(int j = 0; j < [deckBlackjack count]; j++){
            if([[hand[i] getSuit] isEqualToString:[deckBlackjack[j] getSuit]] && [[hand[i] getValue] isEqualToString:[deckBlackjack[j] getValue]]){
                [deckBlackjack removeObjectAtIndex:j];
                break;
            }
        }
    }
}

@end
