#include "Card.h"
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

- (void)viewDidLoad{
    [super viewDidLoad];
    [self pointCalculatorTest];
}

- (void)pointCalculatorTest{
    NSMutableArray* hand = [[NSMutableArray alloc]init];
    PointObject* result;
    //Royal Flush
    [hand addObject:[self getCard:@"Ace" :@"Hearts"]];
    [hand addObject:[self getCard:@"King" :@"Hearts"]];
    [hand addObject:[self getCard:@"Queen" :@"Hearts"]];
    [hand addObject:[self getCard:@"Jack" :@"Hearts"]];
    [hand addObject:[self getCard:@"10" :@"Hearts"]];
    [hand addObject:[self getCard:@"3" :@"Clubs"]];
    [hand addObject:[self getCard:@"7" :@"Spades"]];
    result = [self getHandPoints:hand];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 440 Ace Hearts");
    //Straight Flush
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"7" :@"Clubs"]];
    [hand addObject:[self getCard:@"6" :@"Clubs"]];
    [hand addObject:[self getCard:@"5" :@"Clubs"]];
    [hand addObject:[self getCard:@"4" :@"Clubs"]];
    [hand addObject:[self getCard:@"3" :@"Clubs"]];
    [hand addObject:[self getCard:@"Jack" :@"Diamonds"]];
    [hand addObject:[self getCard:@"4" :@"Hearts"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 432 7 Clubs");
    //Four of a Kind
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"9" :@"Clubs"]];
    [hand addObject:[self getCard:@"9" :@"Diamonds"]];
    [hand addObject:[self getCard:@"9" :@"Hearts"]];
    [hand addObject:[self getCard:@"9" :@"Spades"]];
    [hand addObject:[self getCard:@"6" :@"Spades"]];
    [hand addObject:[self getCard:@"King" :@"Diamonds"]];
    [hand addObject:[self getCard:@"8" :@"Diamonds"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 422 King Diamonds");
    //Full House
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"Queen" :@"Spades"]];
    [hand addObject:[self getCard:@"Queen" :@"Hearts"]];
    [hand addObject:[self getCard:@"Queen" :@"Diamonds"]];
    [hand addObject:[self getCard:@"5" :@"Hearts"]];
    [hand addObject:[self getCard:@"5" :@"Clubs"]];
    [hand addObject:[self getCard:@"4" :@"Clubs"]];
    [hand addObject:[self getCard:@"10" :@"Diamonds"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 380 Queen Spades/Hearts/Diamonds");
    //Straight
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"6" :@"Spades"]];
    [hand addObject:[self getCard:@"7" :@"Hearts"]];
    [hand addObject:[self getCard:@"8" :@"Spades"]];
    [hand addObject:[self getCard:@"9" :@"Clubs"]];
    [hand addObject:[self getCard:@"10" :@"Diamonds"]];
    [hand addObject:[self getCard:@"Ace" :@"Spades"]];
    [hand addObject:[self getCard:@"3" :@"Clubs"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 241 Ace Spades");
    //Three of a Kind
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"8" :@"Spades"]];
    [hand addObject:[self getCard:@"8" :@"Hearts"]];
    [hand addObject:[self getCard:@"8" :@"Clubs"]];
    [hand addObject:[self getCard:@"7" :@"Diamonds"]];
    [hand addObject:[self getCard:@"6" :@"Hearts"]];
    [hand addObject:[self getCard:@"10" :@"Diamonds"]];
    [hand addObject:[self getCard:@"2" :@"Spades"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 227 10 Diamonds");
    //Two Pair
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"Jack" :@"Diamonds"]];
    [hand addObject:[self getCard:@"Jack" :@"Hearts"]];
    [hand addObject:[self getCard:@"7" :@"Spades"]];
    [hand addObject:[self getCard:@"7" :@"Clubs"]];
    [hand addObject:[self getCard:@"9" :@"Hearts"]];
    [hand addObject:[self getCard:@"King" :@"Clubs"]];
    [hand addObject:[self getCard:@"4" :@"Clubs"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 148 King Clubs");
    //One Pair
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"3" :@"Diamonds"]];
    [hand addObject:[self getCard:@"3" :@"Spades"]];
    [hand addObject:[self getCard:@"2" :@"Diamonds"]];
    [hand addObject:[self getCard:@"5" :@"Hearts"]];
    [hand addObject:[self getCard:@"6" :@"Spades"]];
    [hand addObject:[self getCard:@"King" :@"Spades"]];
    [hand addObject:[self getCard:@"Ace" :@"Hearts"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 14 Ace Hearts");
    //Garbage
    [hand removeAllObjects];
    [hand addObject:[self getCard:@"Jack" :@"Hearts"]];
    [hand addObject:[self getCard:@"9" :@"Clubs"]];
    [hand addObject:[self getCard:@"8" :@"Clubs"]];
    [hand addObject:[self getCard:@"3" :@"Diamonds"]];
    [hand addObject:[self getCard:@"6" :@"Hearts"]];
    [hand addObject:[self getCard:@"King" :@"Spades"]];
    [hand addObject:[self getCard:@"2" :@"Diamonds"]];
    NSLog(@"%d %@ %@", [result getPoints], [[result getKicker] getValue], [[result getKicker] getSuit]);
    NSLog(@"Actual: 11 King Spades");
}

- (Card*)getCard:(NSString*)value :(NSString*)suit{
    Card* result = [[Card alloc] init];
    [result setSuit:suit];
    [result setValue:value];
    return result;
}

/* Points Guide
 Kicker shows kicker card, this determines when the points are tied between two players.
 Points displays how powerful a hand is. The higher points total will win. Fully explained ranges below:
 0-12: Garbage. Points show the highest card in the hand. 0-3 should not be possible.
 13-25: One Pair. Points show which value the pair contains.
 26-221: Two Pair. 13 increments of 13. Each increment shows the higher value pair, value within the increment shows lower value pair. Half of the points should be impossible, as they reverse which is higher. Example: 101 = pairs of 10 and 2.
 221-233: Three of a Kind. Points show which value the trio are.
 233-245: Straight. Points show the highest card in the straight. 171-174 should not be possible.
 246: Flush.
 247-415: Full House: Same point distribution as two pair, except higher pair and lower pair are replaced by three set and two set respectively. Example: 300: 3 Queens + 2 Fives.
 415-427: Four of a Kind. Points show which value the four cards are.
 427-439: Straight Flush. Points show the high card in the flush. 331-334 should not be possible.
 440: Royal Flush.
 */

- (PointObject*)getHandPoints:(NSMutableArray*)hand{
    PointObject* result = [[PointObject alloc] init];
    [result setKicker:hand[[hand count] - 1]];
    hand = [self sortHand:hand];
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
    int highestCardValue = [self getValuePoints:hand[[hand count] - 1]];
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
    for(int i = 0; i < [hand count]; i++){
        if([hand[i] compareValues:hand[i + 1]] == 1){
            ordered++;
        } else if([hand[i] compareValues:hand[i + 1]] != 0){
            ordered = 1;
        }
        if(ordered == 5){
            int lastStraightCardValue = [self getValuePoints:hand[i + 1]];
            return (233 + lastStraightCardValue - 2);
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
                    set2 = set1;
                    set1 = currentCheck;
                } else if([currentCheck count] > [set2 count]){
                    set2 = currentCheck;
                }
                [currentCheck removeAllObjects];
            }
        }
    }
    if([currentCheck count] > 0){
        if([currentCheck count] > [set1 count]){
            set2 = set1;
            set1 = currentCheck;
        } else if([currentCheck count] > [set2 count]){
            set2 = currentCheck;
        }
    }
    int firstSet1CardValue = [self getValuePoints:set1[0]];
    if([set1 count] == 4){
        return (415 + firstSet1CardValue - 2);
    } else if([set1 count] == 3){
        if([set2 count] == 2){
            int firstSet2CardValue = [self getValuePoints:set2[0]];
            int addValue = (firstSet1CardValue - 2) * 12 + firstSet2CardValue - 2;
            return (247 + addValue);
        } else {
            return (221 + firstSet1CardValue - 2);
        }
    } else if([set1 count] == 2){
        if([set2 count] == 2){
            int firstSet2CardValue = [self getValuePoints:set2[0]];
            int addValue = (firstSet1CardValue - 2) * 12 + firstSet2CardValue - 2;
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
        return 246;
    } else if ([[finalCard getValue] isEqualToString:@"Ace"]){
        return 440;
    } else {
        int finalCardValue = [self getValuePoints:finalCard];
        return (427 + finalCardValue - 2);
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

@end
