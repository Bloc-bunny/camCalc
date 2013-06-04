//
//  SlideGPOScreenVC.m
//  Blocpad
//
//  Created by Hugh Lang on 3/19/13.
//
//

#import "SlideResultsTableVC.h"
#import "NSString+NumberFormat.h"

@interface SlideResultsTableVC ()

@end

@implementation SlideResultsTableVC

@synthesize q1VialCountInput, q2VialCountInput, q3VialCountInput;
@synthesize _popoverVC;
@synthesize _keypadVC;


@synthesize q1Label, q2Label, q3Label, q1CACost, q2CACost, q3CACost, q1VolumeRebate, q2VolumeRebate, q3VolumeRebate, q1GrowthRebate, q2GrowthRebate, q3GrowthRebate, q1CelgeneRebatePct, q2CelgeneRebatePct, q3CelgeneRebatePct, q1CelgeneRebateAmt, q2CelgeneRebateAmt, q3CelgeneRebateAmt, q1TotalGPOPct, q2TotalGPOPct, q3TotalGPOPct, q1CombinedPct, q2CombinedPct, q3CombinedPct, q1CombinedAmt, q2CombinedAmt, q3CombinedAmt, q1NetCost, q2NetCost, q3NetCost, q1NetVialPrice, q2NetVialPrice, q3NetVialPrice;

@synthesize totalVialCount, totalCACost, totalCelgeneRebate, totalCombinedRebate, totalNetCost, avgNetVialPrice;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"%s", __FUNCTION__);
    [super viewDidLoad];
    
    [DataModel sharedInstance].q1Savings = [[SavingsData alloc] init];
    [DataModel sharedInstance].q1Savings.index = 1;
    [DataModel sharedInstance].q1Savings.qtrname = @"2013Q2";
    
    [DataModel sharedInstance].q2Savings = [[SavingsData alloc] init];
    [DataModel sharedInstance].q2Savings.index = 2;
    [DataModel sharedInstance].q2Savings.qtrname = @"2013Q3";
    
    [DataModel sharedInstance].q3Savings = [[SavingsData alloc] init];
    [DataModel sharedInstance].q3Savings.index = 3;
    [DataModel sharedInstance].q3Savings.qtrname = @"2013Q4";
    [DataModel sharedInstance].totalSavings = [[SavingsData alloc] init];
    
    [self reset];
    [self update:0];
    
    // Prevent default keyboard from appearing
    UIView* dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.q1VialCountInput.inputView = dummyView;
    self.q2VialCountInput.inputView = dummyView;
    self.q3VialCountInput.inputView = dummyView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePopoverNotificationHandler:)     name:@"closePopoverNotification"            object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)closePopoverNotificationHandler:(NSNotification*)notification
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    
    if (_popoverVC != nil) {
        [_popoverVC dismissPopoverAnimated:YES];
    }
    
}

#pragma mark - UITextField methods

-(BOOL) textFieldShouldBeginEditing:(UITextField*)textField {
    NSLog(@"%s", __FUNCTION__);
    _field = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%s", __FUNCTION__);
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    NSLog(@"%s", __FUNCTION__);
    
    _field = textField;
    textField.placeholder = nil;
    
//    switch (textField.tag) {
//        case kTagGPORebate:
//            
//            // Remove percent sign
//            
//            break;
//            
//        case kTagEstVialCount:
//            
//            break;
//            
//    }
    
    _keypadVC = [[KeypadViewController alloc] init];
    _keypadVC.delegate = self;
    
    _popoverVC = [[UIPopoverController alloc]
                  initWithContentViewController:_keypadVC];
    _popoverVC.delegate = self;
    CGSize popoverSize = CGSizeMake(380, 340);
    [_popoverVC setPopoverContentSize:popoverSize];
    
    [_popoverVC presentPopoverFromRect:textField.bounds inView:textField
              permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
    [_field selectAll:self];
    [UIMenuController sharedMenuController].menuVisible = NO;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"%s", __FUNCTION__);
    //#ifdef kDEBUG
    //    // NSLog(@"%s tag=%i", __FUNCTION__, textField.tag);
    //#endif
//    switch (textField.tag) {
//        case kTagGPORebate:
//            if (textField.text.length == 0) {
//                textField.placeholder = @"default";
//            }
//            break;
//            
//        case kTagEstVialCount:
//            if (textField.text.length == 0) {
//                textField.placeholder = @"default";
//            } else {
//                
//                
//            }
//            break;
//            
//    }
    [textField resignFirstResponder];
    [textField endEditing:YES];

    [self update:0];
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"%s", __FUNCTION__);
    [_popoverVC dismissPopoverAnimated:YES];
    [self update:0];
    //    switch (textField.tag) {
//        case kTagGPORebate:
//            return YES;
//            break;
//            
//        case kTagEstVialCount:
//            return YES;
//            break;
//            
//            
//    }
    return YES;
}

// IGNORE THIS METHOD. ONLY WORKS FOR NATIVE KEYBOARD INPUT
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //    NSLog(@"%s %@ %@", __FUNCTION__, textField.text, string);
    //    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([string isEqualToString:@"."] && contains(textField.text, @".")) {
        return NO;
    }
    return YES;
}


#pragma mark -- UIPopover delegate methods

//---called when the user clicks outside the popover view---
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    
    NSLog(@"popover about to be dismissed");
    return YES;
}

//---called when the popover view is dismissed---
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    NSLog(@"popover dismissed");
    
    [_field resignFirstResponder];

    [self update:0];
    
}

#pragma mark - calculator delegate

- (void)keyHandler:(CalculatorKeys)key
{
    NSLog(@"%s %i", __FUNCTION__, key);
    
    switch (key) {
        case CalculatorKeysBack:
            [_field deleteBackward];
            break;
            
        case CalculatorKeysDecimal:
            // Do nothing
            break;
        case CalculatorKeysEnter:
            [_field resignFirstResponder];
            [_popoverVC dismissPopoverAnimated:YES];
            break;
        default:
            [_field insertText:[NSString stringWithFormat:@"%i", key]];
            break;
    }
    
    
}


#pragma mark -- calc methods
- (void) reset {
    NSString *fmt = @"%i";
    q1VialCountInput.text = [NSString stringWithFormat:fmt,
                             [DataModel sharedInstance].contract.estVialCount];
    q2VialCountInput.text = [NSString stringWithFormat:fmt,
                             [DataModel sharedInstance].contract.estVialCount];
    q3VialCountInput.text = [NSString stringWithFormat:fmt,
                             [DataModel sharedInstance].contract.estVialCount];
    
    [self update:0];
    
}
- (void) update:(int)rownum {
    NSLog(@"%s", __FUNCTION__);
    NSString *text;
    
    // Update Q1 row data
    text = q1VialCountInput.text;
    [[DataModel sharedInstance].q1Savings recalculate:text.intValue withContract:[DataModel sharedInstance].contract];
    
    q1CACost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q1Savings.cacost decimals:0];
    q1VolumeRebate.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].q1Savings.volumeRebate];
    q1GrowthRebate.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q1Savings.growthRebate minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
    q1CelgeneRebatePct.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q1Savings.celgeneRebatePct minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
    
    q1CelgeneRebateAmt.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q1Savings.celgeneRebateAmt decimals:0];
    q1TotalGPOPct.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].contract.gpoRebate];
//    q1CombinedPct.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].q1Savings.combinedRebatePct];
    q1CombinedPct.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q1Savings.combinedRebatePct minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
    q1CombinedAmt.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q1Savings.combinedRebateAmt decimals:0];
    q1NetCost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q1Savings.netCost decimals:0];
    q1NetVialPrice.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q1Savings.netPricePerVial decimals:2];
    
    // Update Q2 row data
    text = q2VialCountInput.text;
    [[DataModel sharedInstance].q2Savings recalculate:text.intValue withContract:[DataModel sharedInstance].contract];
    
    q2CACost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q2Savings.cacost decimals:0];
    q2VolumeRebate.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].q2Savings.volumeRebate];
    q2GrowthRebate.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q2Savings.growthRebate minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
    q2CelgeneRebatePct.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q2Savings.celgeneRebatePct minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
    q2CelgeneRebateAmt.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q2Savings.celgeneRebateAmt decimals:0];
    q2TotalGPOPct.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].contract.gpoRebate];
//    q2CombinedPct.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].q2Savings.combinedRebatePct];
    q2CombinedPct.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q2Savings.combinedRebatePct minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
    q2CombinedAmt.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q2Savings.combinedRebateAmt decimals:0];
    q2NetCost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q2Savings.netCost decimals:0];
    q2NetVialPrice.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q2Savings.netPricePerVial decimals:2];
    
    // Update Q3 row data
    text = q3VialCountInput.text;
    /*
     
     */
    int q2vialcount = [DataModel sharedInstance].q2Savings.vialCount;
//    int q3vialcount = [DataModel sharedInstance].q3Savings.vialCount;
//    double growthRatio = (double) q3vialcount / (double) q2vialcount;
//    int q2growthlimit = q2vialcount * 1.75;
//    NSLog(@"growth limit=%i", q2growthlimit);
//    int rebateEligibleVials = -1;
//    
//    if (q3vialcount > 1000) {
//        if (q2growthlimit > q3vialcount) {
//            rebateEligibleVials = q3vialcount;
//        } else {
//            rebateEligibleVials = q2growthlimit;
//        }
//    } else {
//        rebateEligibleVials = q3vialcount;
//    }

    [[DataModel sharedInstance].q3Savings recalculateWithCap:text.intValue withContract:[DataModel sharedInstance].contract previousVialCount:q2vialcount ];
    UIImage *purpleOverlay = [UIImage imageNamed:@"purple_alert_overlay.png"];
    
    if ([DataModel sharedInstance].q3Savings.showAlert) {
        CGRect overlayFrame = CGRectMake(0, 284, 976, 100);
        if (alertOverlay == nil) {
            alertOverlay = [[UIImageView alloc] initWithImage:purpleOverlay];
        }
        alertOverlay.frame = overlayFrame;
        alertOverlay.alpha = 0.3;
        [self.view addSubview:alertOverlay];
        
    } else {
        if (alertOverlay != nil) {
            [alertOverlay removeFromSuperview];
        }
    }
    q3CACost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q3Savings.cacost decimals:0];
    q3VolumeRebate.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].q3Savings.volumeRebate];
    q3GrowthRebate.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q3Savings.growthRebate minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
    q3CelgeneRebatePct.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q3Savings.celgeneRebatePct minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];

    q3CelgeneRebateAmt.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q3Savings.celgeneRebateAmt decimals:0];
    q3TotalGPOPct.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].contract.gpoRebate];
    q3CombinedPct.text = [NSString formatDoubleWithMaxDecimals:[DataModel sharedInstance].q3Savings.combinedRebatePct minDecimals:1 maxDecimals:4  AndPrefix:(NSString *)nil AndSuffix:@"%"];
//    q3CombinedPct.text = [NSString formatDoubleAsPercent1:[DataModel sharedInstance].q3Savings.combinedRebatePct];
    q3CombinedAmt.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q3Savings.combinedRebateAmt decimals:0];
    q3NetCost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q3Savings.netCost decimals:0];
    q3NetVialPrice.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].q3Savings.netPricePerVial decimals:2];
    
    
    
    // Update Totals row data
    
    [DataModel sharedInstance].totalSavings.vialCount = ([DataModel sharedInstance].q1Savings.vialCount
                                                         + [DataModel sharedInstance].q2Savings.vialCount
                                                         + [DataModel sharedInstance].q3Savings.vialCount);
    totalVialCount.text = [NSString formatDoubleWithCommas:[DataModel sharedInstance].totalSavings.vialCount decimals:0];
    
    [DataModel sharedInstance].totalSavings.cacost = ([DataModel sharedInstance].q1Savings.cacost
                                                      + [DataModel sharedInstance].q2Savings.cacost
                                                      + [DataModel sharedInstance].q3Savings.cacost);
    totalCACost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].totalSavings.cacost decimals:0];
    
    [DataModel sharedInstance].totalSavings.celgeneRebateAmt = ([DataModel sharedInstance].q1Savings.celgeneRebateAmt
                                                                + [DataModel sharedInstance].q2Savings.celgeneRebateAmt
                                                                + [DataModel sharedInstance].q3Savings.celgeneRebateAmt);
    totalCelgeneRebate.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].totalSavings.celgeneRebateAmt decimals:0];
    
    [DataModel sharedInstance].totalSavings.combinedRebateAmt = ([DataModel sharedInstance].q1Savings.combinedRebateAmt
                                                                 + [DataModel sharedInstance].q2Savings.combinedRebateAmt
                                                                 + [DataModel sharedInstance].q3Savings.combinedRebateAmt);
    totalCombinedRebate.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].totalSavings.combinedRebateAmt decimals:0];
    
    [DataModel sharedInstance].totalSavings.netCost = ([DataModel sharedInstance].q1Savings.netCost
                                                       + [DataModel sharedInstance].q2Savings.netCost
                                                       + [DataModel sharedInstance].q3Savings.netCost);
    totalNetCost.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].totalSavings.netCost decimals:0];
    
    [DataModel sharedInstance].totalSavings.netPricePerVial = ([DataModel sharedInstance].q1Savings.netPricePerVial
                                                               + [DataModel sharedInstance].q2Savings.netPricePerVial
                                                               + [DataModel sharedInstance].q3Savings.netPricePerVial)/3;
    avgNetVialPrice.text = [NSString formatDoubleAsCurrency:[DataModel sharedInstance].totalSavings.netPricePerVial decimals:2];
    
}



@end
