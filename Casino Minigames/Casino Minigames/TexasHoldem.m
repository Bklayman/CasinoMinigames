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

- (int)getHandPoints:(NSMutableArray*)hand{
    //TODO
    return -1;
}

@end
