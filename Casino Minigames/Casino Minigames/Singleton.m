//
//  Singleton.m
//  Casino Minigames
//
//  Created by Brendan Klayman on 5/7/21.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@implementation Singleton

+ (Singleton*)sharedObject{
    static Singleton *sharedClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClass = [[self alloc] init];
    });
    return sharedClass;
}

- (id)init{
    if(self = [super init]){
        self.totalMoney = 0;
    }
    return self;
}

@end
