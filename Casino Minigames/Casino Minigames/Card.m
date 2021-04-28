#include "Card.h"

@interface Card ()

@end

@implementation Card

@synthesize suit;
@synthesize value;

- (NSString*)getSuit{
    return suit;
}

- (void)setSuit:(NSString*)input{
    suit = input;
}

- (NSString*)getValue{
    return value;
}

- (void)setValue:(NSString*)input{
    value = input;
}

- (int)getValueInt:(NSString *)value{
    if([value isEqualToString:@"2"]){
        return 2;
    } else if([value isEqualToString:@"3"]){
        return 3;
    } else if([value isEqualToString:@"4"]){
        return 4;
    } else if([value isEqualToString:@"5"]){
        return 5;
    } else if([value isEqualToString:@"6"]){
        return 6;
    } else if([value isEqualToString:@"7"]){
        return 7;
    } else if([value isEqualToString:@"8"]){
        return 8;
    } else if([value isEqualToString:@"9"]){
        return 9;
    } else if([value isEqualToString:@"10"] || [value isEqualToString:@"Jack"] || [value isEqualToString:@"Queen"] || [value isEqualToString:@"King"]){
        return 10;
    } else if([value isEqualToString:@"Ace"]){
        return 1;
    }
    return -1;
}

+ (NSMutableArray*)createDeck{
    NSMutableArray* deck = [[NSMutableArray alloc] init];
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 13; j++){
            Card* curCard = [[Card alloc] init];
            curCard.suit = [curCard getSuit:i];
            curCard.value = [curCard getValue:j];
            [deck addObject:curCard];
        }
    }
    return deck;
}

+ (NSMutableArray*)shuffleDeckRandom:(NSMutableArray*)deck{
    for(int i = 0; i < 100; i++){
        int card1 = arc4random_uniform((unsigned int)[deck count]);
        int card2 = arc4random_uniform((unsigned int)[deck count]);
        while(card1 == card2){
            card2 = arc4random_uniform((unsigned int)[deck count]);
        }
        Card* takeCard2 = deck[card2];
        deck[card2] = deck[card1];
        deck[card1] = takeCard2;
    }
    return deck;
}

- (NSString*)getSuit:(int)index{
    switch(index){
        case 0:
            return @"Hearts";
        case 1:
            return @"Diamonds";
        case 2:
            return @"Spades";
        case 3:
            return @"Clubs";
        default:
            return @"";
    }
}

- (NSString*)getValue:(int)index{
    switch(index){
        case 0:
            return @"2";
        case 1:
            return @"3";
        case 2:
            return @"4";
        case 3:
            return @"5";
        case 4:
            return @"6";
        case 5:
            return @"7";
        case 6:
            return @"8";
        case 7:
            return @"9";
        case 8:
            return @"10";
        case 9:
            return @"Jack";
        case 10:
            return @"Queen";
        case 11:
            return @"King";
        case 12:
            return @"Ace";
        default:
            return @"";
    }
}

+ (NSString*)getCardImageLink:(Card*)card{
    NSString* suitAdd = @"";
    if([card.suit isEqualToString:@"Hearts"]){
        suitAdd = @"H.png";
    } else if([card.suit isEqualToString:@"Diamonds"]){
        suitAdd = @"D.png";
    } else if([card.suit isEqualToString:@"Spades"]){
        suitAdd = @"S.png";
    } else {
        suitAdd = @"C.png";
    }
    NSString* valueAdd = @"";
    if([card.value isEqualToString:@"2"] || [card.value isEqualToString:@"3"] || [card.value isEqualToString:@"4"] || [card.value isEqualToString:@"5"] || [card.value isEqualToString:@"6"] || [card.value isEqualToString:@"7"] || [card.value isEqualToString:@"8"] || [card.value isEqualToString:@"9"] || [card.value isEqualToString:@"10"]){
        valueAdd = card.value;
    } else if([card.value isEqualToString:@"Jack"]){
        valueAdd = @"J";
    } else if([card.value isEqualToString:@"Queen"]){
        valueAdd = @"Q";
    } else if([card.value isEqualToString:@"King"]){
        valueAdd = @"K";
    } else {
        valueAdd = @"A";
    }
    return [NSString stringWithFormat:@"%@%@", valueAdd, suitAdd];
}

- (id)init{
    self = [super init];
    suit = @"";
    value = @"";
    return self;
}

- (int)compareValues:(Card*)second{
    int value1 = -1;
    int value2 = -1;
    NSString* stringValue1 = [self getValue];
    NSString* stringValue2 = [second getValue];
    value1 = [self getFaceValue:stringValue1];
    value2 = [self getFaceValue:stringValue2];
    if(value1 == -1){
        value1 = [stringValue1 intValue];
    }
    if(value2 == -1){
        value2 = [stringValue2 intValue];
    }
    return (value2 - value1);
}

- (int)getFaceValue:(NSString*)stringValue{
    if([stringValue isEqualToString:@"Jack"]){
        return 11;
    } else if([stringValue isEqualToString:@"Queen"]){
        return 12;
    } else if([stringValue isEqualToString:@"King"]){
        return 13;
    } else if([stringValue isEqualToString:@"Ace"]){
        return 14;
    }
    return -1;
}

@end
