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

- (NSString*)getvalue;

- (void)setValue:(NSString*)input;

@end

#endif /* Card_h */
