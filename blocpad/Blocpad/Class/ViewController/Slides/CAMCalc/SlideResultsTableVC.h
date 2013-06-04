//
//  SlideGPOScreenVC.h
//  Blocpad
//
//  Created by Hugh Lang on 3/19/13.
//
//

#import "HelveticaNeueBdCnTextField.h"
#import "KeypadViewController.h"

#import "HelveticaNeueMdCnLabel.h"
#import "HelveticaNeueBdLabel.h"
#import "SavingsData.h"

@interface SlideResultsTableVC : UIViewController<UIPopoverControllerDelegate, UITextFieldDelegate, KeypadViewControllerDelegate> {
    
    UITextField *_field;
    UIImageView *alertOverlay;
}
@property (nonatomic, retain) UIPopoverController *_popoverVC;
@property (nonatomic, retain) KeypadViewController *_keypadVC;

@property (nonatomic, strong) IBOutlet HelveticaNeueBdCnTextField *q1VialCountInput;
@property (nonatomic, strong) IBOutlet HelveticaNeueBdCnTextField *q2VialCountInput;
@property (nonatomic, strong) IBOutlet HelveticaNeueBdCnTextField *q3VialCountInput;

@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1Label;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2Label;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3Label;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1CACost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2CACost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3CACost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1VolumeRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2VolumeRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3VolumeRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1GrowthRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2GrowthRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3GrowthRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1CelgeneRebatePct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2CelgeneRebatePct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3CelgeneRebatePct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1CelgeneRebateAmt;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2CelgeneRebateAmt;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3CelgeneRebateAmt;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1TotalGPOPct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2TotalGPOPct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3TotalGPOPct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1CombinedPct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2CombinedPct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3CombinedPct;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1CombinedAmt;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2CombinedAmt;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3CombinedAmt;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1NetCost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2NetCost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3NetCost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q1NetVialPrice;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q2NetVialPrice;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *q3NetVialPrice;

@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *totalVialCount;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *totalCACost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *totalCelgeneRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *totalCombinedRebate;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *totalNetCost;
@property (nonatomic, strong) IBOutlet HelveticaNeueMdCnLabel *avgNetVialPrice;

- (void) reset;
- (void) update:(int)rownum;

@end
