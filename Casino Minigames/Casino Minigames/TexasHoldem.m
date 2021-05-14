#include "Card.h"
#include "Singleton.h"
#include "TexasHoldem.h"

@interface PointObject:NSObject{
    int points;
    Card* kicker;
}

@property (nonatomic, readwrite) int points;
@property (nonatomic, readwrite) Card* kicker;

- (int)getPoints;

- (Card*)getKicker;

@end

@implementation PointObject

@synthesize points;
@synthesize kicker;

- (int)getPoints{
    return points;
}

- (Card*)getKicker{
    return kicker;
}

- (PointObject*)createPointObject:(int)score :(Card*)extra{
    PointObject* result = [[PointObject alloc] init];
    result.points = score;
    result.kicker = extra;
    return result;
}

- (id)init{
    self = [super init];
    points = -1;
    kicker = NULL;
    return self;
}

@end

@interface TexasHoldem ()

@end

@implementation TexasHoldem

NSMutableArray* deck;
NSMutableArray* playerCards;
NSMutableArray* dealerCards;
NSMutableArray* tableCards;
NSMutableArray* turnOrder; //0 -> dealer, 1 -> player

int playerBet;
int dealerBet;
int turnsTaken;
int turnsBeforeDeal;
bool readyToDrawTable;
bool gameInProgress;

- (void)viewDidLoad{
    [super viewDidLoad];
    deck = [Card shuffleDeckRandom: [Card createDeck]];
    playerCards = [[NSMutableArray alloc] init];
    dealerCards = [[NSMutableArray alloc] init];
    turnOrder = [[NSMutableArray alloc] init];
    tableCards = [[NSMutableArray alloc] init];
    [self startRound];
    if([turnOrder[0] intValue] == 0){
        [self dealerTurn];
    }
    _playAgainButton.hidden = TRUE;
    _currentFunds.text = [NSString stringWithFormat:@"%d", [Singleton sharedObject].totalMoney];
}

- (void)playerTurn{
    if(turnsTaken == 0 || dealerBet == 0){
        [_callButton setTitle:@"Check" forState:UIControlStateNormal];
    } else {
        [_callButton setTitle:@"Call" forState:UIControlStateNormal];
    }
    turnsTaken++;
}

- (void)dealerTurn{
    NSMutableArray* curHand = [[NSMutableArray alloc]init];
    for(int i = 0; i < [dealerCards count]; i++){
        [curHand addObject:dealerCards[i]];
    }
    for(int i = 0; i < [tableCards count]; i++){
        [curHand addObject:tableCards[i]];
    }
    PointObject* curPoints = [self getHandPoints:curHand];
    int curIntPoints = [curPoints getPoints];
    switch([curHand count]){
        /*On the first round, check if garbage. If so, 1/3 chance raising, 2/3 chance calling.
         If not garbage, 1/3 chance calling, 2/3 chance raising.*/
        case 2:
            switch(curIntPoints){
                case 0 ... 12:
                    if(dealerBet < 30 && arc4random_uniform(3) < 2){
                        [self dealerCall];
                    } else {
                        [self dealerRaise:arc4random_uniform(5)];
                    }
                    break;
                default:
                    if(dealerBet < 30 && arc4random_uniform(3) < 2){
                        [self dealerRaise:arc4random_uniform(5)];
                    } else {
                        [self dealerCall];
                    }
                    break;
            }
            break;
        /*On the second round, check if garbage. If so, 1/4 chance of folding, 3/4 chance of calling.
         If one or two pair, 2/3 chance calling, 1/3 chance raising.
         If three of a kind, straight, or full house, 1/2 chance calling, 1/2 chance raising.
         If higher, 2/3 chance raising, 1/3 chance calling.
         */
        case 5:
            switch(curIntPoints){
                case 0 ... 12:
                    if(arc4random_uniform(4) < 3 && playerBet < 100){
                        [self dealerCall];
                    } else {
                        [self dealerFold];
                    }
                    break;
                case 13 ... 221:
                    if(arc4random_uniform(4) < 3 && playerBet < 100){
                        [self dealerCall];
                    } else {
                        [self dealerFold];
                    }
                    break;
                case 222 ... 418:
                    if(dealerBet > 140 || arc4random_uniform(3) < 2){
                        [self dealerCall];
                    } else {
                        [self dealerRaise:arc4random_uniform(10)];
                    }
                    break;
                default:
                    if(dealerBet < 180 && arc4random_uniform(3) < 2){
                        [self dealerRaise:arc4random_uniform(7)];
                    } else {
                        [self dealerCall];
                    }
                    break;
            }
            break;
        /*On the third round, check if garbage or one pair. If so, 1/3 chance of folding, 2/3 chance of calling.
         If two pair or three of a kind, 2/3 chance calling, 1/3 chance raising.
         If straight, or full house, 1/2 chance calling, 1/2 chance raising.
         If higher, 2/3 chance raising, 1/3 chance calling.
        */
        case 6:
            switch(curIntPoints){
                case 0 ... 25:
                    if(playerBet < 140 && arc4random_uniform(3) < 2){
                        [self dealerCall];
                    } else {
                        [self dealerFold];
                    }
                    break;
                case 26 ... 234:
                    if(dealerBet > 200 || arc4random_uniform(3) < 2){
                        [self dealerCall];
                    } else {
                        [self dealerRaise:arc4random_uniform(10)];
                    }
                    break;
                case 235 ... 418:
                    if(dealerBet > 240 || arc4random_uniform(2) < 1){
                        [self dealerCall];
                    } else {
                        [self dealerRaise:arc4random_uniform(10)];
                    }
                    break;
                default:
                    if(dealerBet < 280 && arc4random_uniform(3) < 2){
                        [self dealerRaise:arc4random_uniform(7)];
                    } else {
                        [self dealerCall];
                    }
                    break;
            }
            break;
        /*On the fourth round, check if garbage, one pair. If so, 1/3 chance of folding, 2/3 chance of calling.
         If two pair or three of a kind, 2/3 chance calling, 1/3 chance raising.
         If straight, or full house, 1/2 chance calling, 1/2 chance raising.
         If higher, 2/3 chance raising, 1/3 chance calling.
         */
        case 7:
            switch(curIntPoints){
                case 0 ... 25:
                    if(playerBet < 140 && arc4random_uniform(3) < 2){
                        [self dealerCall];
                    } else {
                        [self dealerFold];
                    }
                    break;
                case 26 ... 234:
                    if(dealerBet > 240 || arc4random_uniform(3) < 2){
                        [self dealerCall];
                    } else {
                        [self dealerRaise:arc4random_uniform(10)];
                    }
                    break;
                case 235 ... 418:
                    if(dealerBet > 300 || arc4random_uniform(2) < 1){
                        [self dealerCall];
                    } else {
                        [self dealerRaise:arc4random_uniform(10)];
                    }
                    break;
                default:
                    if(arc4random_uniform(3) < 2){
                        [self dealerRaise:arc4random_uniform(7)];
                    } else {
                        [self dealerCall];
                    }
                    break;
            }
            break;
    }
    turnsTaken++;
    [self endTurn];
}

- (void)dealerRaise:(int)value{
    dealerBet = MAX(playerBet, dealerBet) + value;
    _dealerBet.text = [NSString stringWithFormat:@"%d", dealerBet];
    turnsBeforeDeal = (int)[turnOrder count];
}

- (void)dealerCall{
    dealerBet = playerBet;
    _dealerBet.text = [NSString stringWithFormat:@"%d", dealerBet];
}

- (void)dealerFold{
    [turnOrder removeObjectAtIndex:0];
}

- (void)endTurn{
    if([turnOrder count] == 2){
        NSNumber* buffer = turnOrder[0];
        turnOrder[0] = turnOrder[1];
        turnOrder[1] = buffer;
        turnsBeforeDeal--;
        if(turnsBeforeDeal == 0){
            turnsBeforeDeal = (int)[turnOrder count];
            [self drawTableCard];
        }
        if([turnOrder[0] intValue] == 0){
            [self dealerTurn];
        } else {
            [self playerTurn];
        }
    } else {
        while([tableCards count] != 5){
            [self drawTableCard];
        }
        [self determineWinner];
    }
}

- (void)drawTableCard{
    switch([tableCards count]){
        case 0:
            _tableCard1.hidden = FALSE;
            _tableCard2.hidden = FALSE;
            _tableCard3.hidden = FALSE;
            [tableCards addObject:[self drawCardWithCheck]];
            [tableCards addObject:[self drawCardWithCheck]];
            [tableCards addObject:[self drawCardWithCheck]];
            _tableCard1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:tableCards[0]]]];
            _tableCard2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:tableCards[1]]]];
            _tableCard3.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:tableCards[2]]]];
            break;
        case 3:
            _tableCard4.hidden = FALSE;
            [tableCards addObject:[self drawCardWithCheck]];
            _tableCard4.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:tableCards[3]]]];
            break;
        case 4:
            _tableCard5.hidden = FALSE;
            [tableCards addObject:[self drawCardWithCheck]];
            _tableCard5.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:tableCards[4]]]];
            break;
        case 5:
            [self determineWinner];
            break;
    }
}

- (void)determineWinner{
    gameInProgress = FALSE;
    _dealerCard1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:dealerCards[0]]]];
    _dealerCard2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:dealerCards[1]]]];
    [Singleton sharedObject].totalMoney-= playerBet;
    if([turnOrder count] == 2){
        for(int i = 0; i < [tableCards count]; i++){
            [playerCards addObject:tableCards[i]];
            [dealerCards addObject:tableCards[i]];
        }
        PointObject* playerPoints = [self getHandPoints:playerCards];
        PointObject* dealerPoints = [self getHandPoints:dealerCards];
        if([playerPoints getPoints] > [dealerPoints getPoints] || ([playerPoints getPoints] > [dealerPoints getPoints] && [[playerPoints getKicker] compareValues:[dealerPoints getKicker]] < 0)){
            [Singleton sharedObject].totalMoney+= (playerBet + dealerBet);
        }
    } else { //For any folds
        if([turnOrder[0] intValue] == 1){
            [Singleton sharedObject].totalMoney+= playerBet + dealerBet;
        }
    }
    _currentFunds.text = [NSString stringWithFormat:@"%d", [Singleton sharedObject].totalMoney];
    _playAgainButton.hidden = FALSE;
}

- (IBAction)playAgainPressed:(id)sender{
    _playAgainButton.hidden = TRUE;
    [self startRound];
}

- (IBAction)callButtonPressed:(id)sender{
    if(!gameInProgress){
        return;
    }
    playerBet = dealerBet;
    _playerBet.text = [NSString stringWithFormat:@"%d", playerBet];
    [self endTurn];
}

- (IBAction)raiseButtonPressed:(id)sender{
    if(!gameInProgress){
        return;
    }
    NSString* raiseText = _raiseText.text;
    _raiseText.text = @"";
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:raiseText options:0 range:NSMakeRange(0, [raiseText length])];
    if(numberOfMatches == 0){
        return; //raiseText is not a valid integer
    }
    if([raiseText intValue] + playerBet > dealerBet){
        playerBet += [raiseText intValue];
        _playerBet.text = [NSString stringWithFormat:@"%d", playerBet];
        turnsBeforeDeal = (int)[turnOrder count];
        [self endTurn];
    }
}

- (IBAction)foldButtonPressed:(id)sender{
    if(!gameInProgress){
        return;
    }
    [turnOrder removeObjectAtIndex:0];
    [self endTurn];
}

- (void)startRound{
    gameInProgress = TRUE;
    NSMutableArray* tempDeck = deck;
    [playerCards removeAllObjects];
    [dealerCards removeAllObjects];
    [tableCards removeAllObjects];
    [turnOrder removeAllObjects];
    _dealerCard1.image = [UIImage imageNamed:@"red_back.png"];
    _dealerCard2.image = [UIImage imageNamed:@"red_back.png"];
    [playerCards addObject:[self drawCardWithCheck]];
    [playerCards addObject:[self drawCardWithCheck]];
    [dealerCards addObject:[self drawCardWithCheck]];
    [dealerCards addObject:[self drawCardWithCheck]];
    _playerCard1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:playerCards[0]]]];
    _playerCard2.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [Card getCardImageLink:playerCards[1]]]];
    _tableCard1.hidden = TRUE;
    _tableCard2.hidden = TRUE;
    _tableCard3.hidden = TRUE;
    _tableCard4.hidden = TRUE;
    _tableCard5.hidden = TRUE;
    playerBet = 0;
    _playerBet.text = [NSString stringWithFormat:@"%d", playerBet];
    dealerBet = 0;
    _dealerBet.text = [NSString stringWithFormat:@"%d", dealerBet];
    turnsTaken = 0;
    readyToDrawTable = false;
    if(arc4random_uniform(2) == 0){
        [turnOrder addObject:[NSNumber numberWithInt:0]];
        [turnOrder addObject:[NSNumber numberWithInt:1]];
    } else {
        [turnOrder addObject:[NSNumber numberWithInt:1]];
        [turnOrder addObject:[NSNumber numberWithInt:0]];
    }
    turnsBeforeDeal = (int)[turnOrder count];
    deck = tempDeck;
}

- (Card*)drawCardWithCheck{
    if([deck count] == 0){
        deck = [Card shuffleDeckRandom: [Card createDeck]];
        [self removeUsedCards:playerCards];
        [self removeUsedCards:dealerCards];
        [self removeUsedCards:tableCards];
    }
    Card* result = deck[0];
    [deck removeObjectAtIndex:0];
    return result;
}

- (void)removeUsedCards:(NSMutableArray*)hand{
    for(int i = 0; i < [hand count]; i++){
        for(int j = 0; j < [deck count]; j++){
            if([[hand[i] getSuit] isEqualToString:[deck[j] getSuit]] && [[hand[i] getValue] isEqualToString:[deck[j] getValue]]){
                [deck removeObjectAtIndex:j];
                break;
            }
        }
    }
}


/* Points Guide
 Kicker shows kicker card, this determines when the points are tied between two players.
 Points displays how powerful a hand is. The higher points total will win. Fully explained ranges below:
 0-12: Garbage. Points show the highest card in the hand. 0-3 should not be possible.
 13-25: One Pair. Points show which value the pair contains.
 26-221: Two Pair. 13 increments of 13. Each increment shows the higher value pair, value within the increment shows lower value pair. Half of the points should be impossible, as they reverse which is higher. Example: 101 = pairs of 10 and 2.
 222-234: Three of a Kind. Points show which value the trio are.
 235-247: Straight. Points show the highest card in the straight. 171-174 should not be possible.
 249: Flush.
 250-418: Full House: Same point distribution as two pair, except higher pair and lower pair are replaced by three set and two set respectively. Example: 300: 3 Queens + 2 Fives.
 419-431: Four of a Kind. Points show which value the four cards are.
 432-444: Straight Flush. Points show the high card in the flush. 331-334 should not be possible.
 445: Royal Flush.
 */

- (PointObject*)getHandPoints:(NSMutableArray*)hand{
    PointObject* result = [[PointObject alloc] init];
    hand = [self sortHand:hand];
    [result setKicker:hand[[hand count] - 1]];
    int flushPoints = [self checkForFlush:hand];
    if(flushPoints != -1){ //Flush, straight flush, or royal flush
        [result setPoints:flushPoints];
        return result;
    }
    int equalValuePoints = [self checkForEqualValues:hand]; //Check for 4 of a kind, 3 of a kind, full house, 2 pair, and pair
    if(equalValuePoints > 184){ //Four of a kind or full house
        [result setPoints:equalValuePoints];
        return result;
    }
    int straightPoints = [self checkForStraight:hand];
    if(straightPoints > 170){ //Straight
        [result setPoints:straightPoints];
        return result;
    }
    if(equalValuePoints > 12){ //Three of a kind, Two pair, or One pair
        [result setPoints:equalValuePoints];
        return result;
    }
    int highestCardValue = [self getValuePoints:hand[[hand count] - 1]] - 2;
    [result setPoints:highestCardValue]; //Garbage
    return result;
}

- (NSMutableArray*)sortHand:(NSMutableArray*)hand{
    for(int i = 0; i < [hand count] - 1; i++){
        for(int j = i + 1; j < [hand count]; j++){
            if([hand[i] getValue] > [hand[j] getValue]){
                Card* saveCard = hand[i];
                hand[i] = hand[j];
                hand[j] = saveCard;
            }
        }
    }
    return hand;
}

- (int)checkForStraight:(NSMutableArray*)hand{
    int ordered = 1;
    for(int i = 0; i < [hand count] - 1; i++){
        if([hand[i] compareValues:hand[i + 1]] == 1){
            ordered++;
        } else if([hand[i] compareValues:hand[i + 1]] != 0){
            ordered = 1;
        }
        if(ordered == 5){
            int lastStraightCardValue = [self getValuePoints:hand[i + 1]];
            return (235 + lastStraightCardValue - 2);
        }
    }
    return -1;
}

- (int)checkForEqualValues:(NSMutableArray*)hand{
    NSMutableArray* set1 = [[NSMutableArray alloc] init];
    NSMutableArray* set2 = [[NSMutableArray alloc] init];
    NSMutableArray* currentCheck = [[NSMutableArray alloc] init];
    for(int i = 0; i < [hand count] - 1; i++){
        if([hand[i] compareValues:hand[i + 1]] == 0){
            if([currentCheck count] == 0){
                [currentCheck addObject:hand[i]];
            }
            [currentCheck addObject:hand[i + 1]];
        } else {
            if([currentCheck count] > 0){
                if([currentCheck count] > [set1 count]){
                    set2 = [set1 mutableCopy];
                    set1 = [currentCheck mutableCopy];
                } else if([currentCheck count] > [set2 count]){
                    set2 = [currentCheck mutableCopy];
                }
                [currentCheck removeAllObjects];
            }
        }
    }
    if([currentCheck count] > 0){
        if([currentCheck count] > [set1 count]){
            set2 = [set1 mutableCopy];
            set1 = [currentCheck mutableCopy];
        } else if([currentCheck count] > [set2 count]){
            set2 = [currentCheck mutableCopy];
        }
    }
    if([set1 count] == 0){
        return -1;
    }
    int firstSet1CardValue = [self getValuePoints:set1[0]];
    if([set1 count] == 4){
        return (415 + firstSet1CardValue - 2);
    } else if([set1 count] == 3){
        if([set2 count] == 2){
            int firstSet2CardValue = [self getValuePoints:set2[0]];
            int addValue = (firstSet1CardValue - 2) * 13 + firstSet2CardValue - 2;
            return (250 + addValue);
        } else {
            return (222 + firstSet1CardValue - 2);
        }
    } else if([set1 count] == 2){
        if([set2 count] == 2){
            int firstSet2CardValue = [self getValuePoints:set2[0]];
            if(firstSet2CardValue > firstSet1CardValue){
                int bufferCardValue = firstSet2CardValue;
                firstSet2CardValue = firstSet1CardValue;
                firstSet1CardValue = bufferCardValue;
            }
            int addValue = (firstSet1CardValue - 2) * 13 + firstSet2CardValue - 2;
            return(26 + addValue);
        } else {
            return (13 + firstSet1CardValue - 2);
        }
    }
    return -1;
}

- (int)checkForFlush:(NSMutableArray*)hand{
    NSMutableArray* spades = [[NSMutableArray alloc] init];
    NSMutableArray* clubs = [[NSMutableArray alloc] init];
    NSMutableArray* hearts = [[NSMutableArray alloc] init];
    NSMutableArray* diamonds = [[NSMutableArray alloc] init];
    for(int i = 0; i < [hand count]; i++){
        if([[hand[i] getSuit] isEqualToString:@"Spades"]){
            [spades addObject:hand[i]];
        } else if([[hand[i] getSuit] isEqualToString:@"Clubs"]){
            [clubs addObject:hand[i]];
        } else if([[hand[i] getSuit] isEqualToString:@"Hearts"]){
            [hearts addObject:hand[i]];
        } else if([[hand[i] getSuit] isEqualToString:@"Diamonds"]){
            [diamonds addObject:hand[i]];
        }
    }
    NSMutableArray* largestSuit = [[NSMutableArray alloc] init];
    bool foundFlush = false;
    if([spades count] > 4){
        largestSuit = spades;
        foundFlush = true;
    } else if([clubs count] > 4){
        largestSuit = clubs;
        foundFlush = true;
    } else if([hearts count] > 4){
        largestSuit = hearts;
        foundFlush = true;
    } else if([diamonds count] > 4){
        largestSuit = diamonds;
        foundFlush = true;
    }
    if(!foundFlush){
        return -1;
    }
    bool straightFlush = false;
    Card* finalCard = NULL;
    int flushCount = 1;
    for(int i = 0; i < [largestSuit count] - 1; i++){
        if([largestSuit[i] compareValues:largestSuit[i + 1]] == 1){
            flushCount++;
        } else if([largestSuit[i] compareValues:largestSuit[i + 1]] != 0){
            flushCount = 1;
        }
        if(flushCount == 5){
            straightFlush = true;
            finalCard = largestSuit[i + 1];
        }
    }
    if(!straightFlush){
        return 249;
    } else if ([[finalCard getValue] isEqualToString:@"Ace"]){
        return 445;
    } else {
        int finalCardValue = [self getValuePoints:finalCard];
        return (432 + finalCardValue - 2);
    }
}

- (int)getValuePoints:(Card*)card{
    int value = -1;
    NSString* stringValue = [card getValue];
    value = [card getFaceValue:stringValue];
    if(value == -1){
        value = [stringValue intValue];
    }
    return value;
}

- (void)pointCalculatorTest{
    NSMutableArray* hand = [[NSMutableArray alloc]init];
    PointObject* result;
    //Royal Flush
    [hand addObject:[Card getCard:@"Ace" :@"Hearts"]];
    [hand addObject:[Card getCard:@"King" :@"Hearts"]];
    [hand addObject:[Card getCard:@"Queen" :@"Hearts"]];
    [hand addObject:[Card getCard:@"Jack" :@"Hearts"]];
    [hand addObject:[Card getCard:@"10" :@"Hearts"]];
    [hand addObject:[Card getCard:@"3" :@"Clubs"]];
    [hand addObject:[Card getCard:@"7" :@"Spades"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 445 Ace Hearts");
    //Straight Flush
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"7" :@"Clubs"]];
    [hand addObject:[Card getCard:@"6" :@"Clubs"]];
    [hand addObject:[Card getCard:@"5" :@"Clubs"]];
    [hand addObject:[Card getCard:@"4" :@"Clubs"]];
    [hand addObject:[Card getCard:@"3" :@"Clubs"]];
    [hand addObject:[Card getCard:@"Jack" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"4" :@"Hearts"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 437 Jack Diamonds");
    //Four of a Kind
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"9" :@"Clubs"]];
    [hand addObject:[Card getCard:@"9" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"9" :@"Hearts"]];
    [hand addObject:[Card getCard:@"9" :@"Spades"]];
    [hand addObject:[Card getCard:@"6" :@"Spades"]];
    [hand addObject:[Card getCard:@"King" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"8" :@"Diamonds"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 426 King Diamonds");
    //Full House
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"Queen" :@"Spades"]];
    [hand addObject:[Card getCard:@"Queen" :@"Hearts"]];
    [hand addObject:[Card getCard:@"Queen" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"5" :@"Hearts"]];
    [hand addObject:[Card getCard:@"5" :@"Clubs"]];
    [hand addObject:[Card getCard:@"4" :@"Clubs"]];
    [hand addObject:[Card getCard:@"10" :@"Diamonds"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 383 Queen Spades/Hearts/Diamonds");
    //Straight
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"6" :@"Spades"]];
    [hand addObject:[Card getCard:@"7" :@"Hearts"]];
    [hand addObject:[Card getCard:@"8" :@"Spades"]];
    [hand addObject:[Card getCard:@"9" :@"Clubs"]];
    [hand addObject:[Card getCard:@"10" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"Ace" :@"Spades"]];
    [hand addObject:[Card getCard:@"3" :@"Clubs"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 243 Ace Spades");
    //Three of a Kind
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"8" :@"Spades"]];
    [hand addObject:[Card getCard:@"8" :@"Hearts"]];
    [hand addObject:[Card getCard:@"8" :@"Clubs"]];
    [hand addObject:[Card getCard:@"7" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"6" :@"Hearts"]];
    [hand addObject:[Card getCard:@"10" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"2" :@"Spades"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 228 10 Diamonds");
    //Two Pair
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"Jack" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"Jack" :@"Hearts"]];
    [hand addObject:[Card getCard:@"7" :@"Spades"]];
    [hand addObject:[Card getCard:@"7" :@"Clubs"]];
    [hand addObject:[Card getCard:@"9" :@"Hearts"]];
    [hand addObject:[Card getCard:@"King" :@"Clubs"]];
    [hand addObject:[Card getCard:@"4" :@"Clubs"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 148 King Clubs");
    //One Pair
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"3" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"3" :@"Spades"]];
    [hand addObject:[Card getCard:@"2" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"5" :@"Hearts"]];
    [hand addObject:[Card getCard:@"6" :@"Spades"]];
    [hand addObject:[Card getCard:@"King" :@"Spades"]];
    [hand addObject:[Card getCard:@"Ace" :@"Hearts"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 14 Ace Hearts");
    //Garbage
    [hand removeAllObjects];
    [hand addObject:[Card getCard:@"Jack" :@"Hearts"]];
    [hand addObject:[Card getCard:@"9" :@"Clubs"]];
    [hand addObject:[Card getCard:@"8" :@"Clubs"]];
    [hand addObject:[Card getCard:@"3" :@"Diamonds"]];
    [hand addObject:[Card getCard:@"6" :@"Hearts"]];
    [hand addObject:[Card getCard:@"King" :@"Spades"]];
    [hand addObject:[Card getCard:@"2" :@"Diamonds"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 11 King Spades");
}

@end
