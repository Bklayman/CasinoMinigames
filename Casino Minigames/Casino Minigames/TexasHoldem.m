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
}

/* Points Guide
 Kicker shows kicker card, this determines when the points are tied between two players.
 Points displays how powerful a hand is. The higher points total will win. Fully explained ranges below:
 0-12: Garbage. Points show the highest card in the hand. 0-3 should not be possible.
 13-25: One Pair. Points show which value the pair contains.
 26-157: Two Pair. 12 increments of 11. Each increment shows the higher value pair, value within the increment shows lower value pair. Half of the points should be impossible, as they reverse which is higher. Example: 101 = pairs of 10 and 2.
 158-170: Three of a Kind. Points show which value the trio are.
 171-183: Straight. Points show the highest card in the straight. 171-174 should not be possible.
 184: Flush.
 185-317: Full House: Same point distribution as two pair, except higher pair and lower pair are replaced by three set and two set respectively. Example: 300: 3 Queens + 2 Fives.
 318-330: Four of a Kind. Points show which value the four cards are.
 331-343: Straight Flush. Points show the high card in the flush. 331-334 should not be possible.
 344: Royal Flush.
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
    
    
    [result setPoints:-1];
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
    if([set1 count] == 4){
        int value = -1;
        NSString* stringValue = [set1[0] getValue];
        value = [set1[0] getFaceValue:stringValue];
        if(value == -1){
            value = [stringValue intValue];
        }
        return (318 + value - 2);
    } else if([set1 count] == 3){
        if([set2 count] == 2){
            int value1 = -1;
            NSString* stringValue1 = [set1[0] getValue];
            value1 = [set1[0] getFaceValue:stringValue1];
            if(value1 == -1){
                value1 = [stringValue1 intValue];
            }
            int value2 = -1;
            NSString* stringValue2 = [set2[0] getValue];
            value2 = [set2[0] getFaceValue:stringValue2];
            if(value2 == -1){
                value2 = [stringValue2 intValue];
            }
            int addValue = (value1 - 2) * 12 + value2 - 2;
            return (185 + addValue);
        } else {
            int value = -1;
            NSString* stringValue = [set1[0] getValue];
            value = [set1[0] getFaceValue:stringValue];
            if(value == -1){
                value = [stringValue intValue];
            }
            return (158 + value - 2);
        }
    } else if([set1 count] == 2){
        if([set2 count] == 2){
            int value1 = -1;
            NSString* stringValue1 = [set1[0] getValue];
            value1 = [set1[0] getFaceValue:stringValue1];
            if(value1 == -1){
                value1 = [stringValue1 intValue];
            }
            int value2 = -1;
            NSString* stringValue2 = [set2[0] getValue];
            value2 = [set2[0] getFaceValue:stringValue2];
            if(value2 == -1){
                value2 = [stringValue2 intValue];
            }
            int addValue = (value1 - 2) * 12 + value2 - 2;
            return(26 + addValue);
        } else {
            int value = -1;
            NSString* stringValue = [set1[0] getValue];
            value = [set1[0] getFaceValue:stringValue];
            if(value == -1){
                value = [stringValue intValue];
            }
            return (13 + value - 2);
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
        }
        if(flushCount == 5){
            straightFlush = true;
            finalCard = largestSuit[i + 1];
        }
    }
    if(!straightFlush){
        return 184;
    } else if ([[finalCard getValue] isEqualToString:@"Ace"]){
        return 344;
    } else {
        int value = -1;
        NSString* stringValue = [finalCard getValue];
        value = [finalCard getFaceValue:stringValue];
        if(value == -1){
            value = [stringValue intValue];
        }
        return (331 + value - 2);
    }
}

@end
