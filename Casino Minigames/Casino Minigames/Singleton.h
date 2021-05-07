//
//  Singleton.h
//  Casino Minigames
//
//  Created by Brendan Klayman on 5/7/21.
//

#ifndef Singleton_h
#define Singleton_h

#import <Foundation/Foundation.h>

@interface Singleton : NSObject {
}

+ (Singleton*) sharedObject;

@property int totalMoney;

@end

#endif /* Singleton_h */
