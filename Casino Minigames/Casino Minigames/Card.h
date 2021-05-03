#ifndef Card_h
#define Card_h

#import <UIKit/UIKit.h>

@interface Card:NSObject{
    NSString* suit;
    NSString* value;
}

@property (nonatomic, readwrite) NSString* suit;
@property (nonatomic, readwrite) NSString* value;

- (int)getValueInt:(NSString*)value;

- (NSString*)getSuit;

- (void)setSuit:(NSString*)input;

- (NSString*)getValue;

- (void)setValue:(NSString*)input;

- (int)compareValues:(Card*)second;

- (int)getFaceValue:(NSString*)stringValue;

+ (NSMutableArray*)createDeck;

+ (NSMutableArray*)shuffleDeckRandom:(NSMutableArray*)deck;

+ (NSString*)getCardImageLink:(Card*)card;

@end

#endif /* Card_h */
