#include "Card.h"
#include "Blackjack.h"

@interface Blackjack ()

@end

@implementation Blackjack

NSMutableArray* playerCardsBlackjack;
NSMutableArray* dealerCardsBlackjack;
NSMutableArray* deckBlackjack;

- (void)viewDidLoad{
    [super viewDidLoad];
    playerCardsBlackjack = [[NSMutableArray alloc] init];
    dealerCardsBlackjack = [[NSMutableArray alloc] init];
    deckBlackjack = [Card shuffleDeckRandom:[Card createDeck]];
    [self startRound];
}

- (void)startRound{
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
}

- (IBAction)hitButtonPressed:(id)sender{
    //TODO
}

- (IBAction)standButtonPressed:(id)sender{
    //TODO
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
            curValue+= [hand[curValue] getValueInt:curValueName];
        }
        curIndex++;
    }
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
