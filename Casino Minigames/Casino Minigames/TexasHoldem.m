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

- (PointObject)createPointObject:(int)score :(Card*)extra{
    PointObject* result = [[PointObject alloc] init];
    result.points = score;
    result.kicker = extra;
    return result;
}

- (id)init{
    self = [super init];
    points = -1;
    kicker = null;
    return self;
}

@end

@implementation PointObject

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
