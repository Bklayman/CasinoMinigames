#ifndef Blackjack_h
#define Blackjack_h

#import <UIKit/UIKit.h>

@interface Blackjack : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView* playerCard1;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard2;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard3;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard4;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard5;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard6;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard7;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard8;

@property (nonatomic, strong) IBOutlet UIImageView* dealerCard1;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard2;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard3;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard4;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard5;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard6;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard7;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard8;

@property (nonatomic, strong) IBOutlet UIButton* betButton;
@property (nonatomic, strong) IBOutlet UIButton* playAgainButton;

@property (nonatomic, strong) IBOutlet UITextField* betText;

@property (nonatomic, strong) IBOutlet UILabel* betAmount;
@property (nonatomic, strong) IBOutlet UILabel* fundsAmount;

@end

#endif
