#include "Card.h"
#include "Blackjack.h"

@interface Blackjack ()

@end

@implementation Blackjack

- (void)viewDidLoad{
    [super viewDidLoad];
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

- (UIImageView*)getPlayerCardImage:(int)index{
    switch(index){
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
    }
    return NULL;
}

- (NSMutableArray*)getHandValue:(NSMutableArray*)hand{
    return [self handValueHelper:0 :hand :0];
}

@end
