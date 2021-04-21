#ifndef TexasHoldem_h
#define TexasHoldem_h

#import <UIKit/UIKit.h>

@interface TexasHoldem : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView* playerCard1;
@property (nonatomic, strong) IBOutlet UIImageView* playerCard2;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard1;
@property (nonatomic, strong) IBOutlet UIImageView* dealerCard2;
@property (nonatomic, strong) IBOutlet UIImageView* tableCard1;
@property (nonatomic, strong) IBOutlet UIImageView* tableCard2;
@property (nonatomic, strong) IBOutlet UIImageView* tableCard3;
@property (nonatomic, strong) IBOutlet UIImageView* tableCard4;
@property (nonatomic, strong) IBOutlet UIImageView* tableCard5;

@property (nonatomic, strong) IBOutlet UIButton* raiseButton;
@property (nonatomic, strong) IBOutlet UIButton* callButton;
@property (nonatomic, strong) IBOutlet UIButton* foldButton;

@property (nonatomic, strong) IBOutlet UITextField* raiseText;

@property (nonatomic, strong) IBOutlet UILabel* playerBet;
@property (nonatomic, strong) IBOutlet UILabel* dealerBet;

@end

#endif /* TexasHoldem_h */
