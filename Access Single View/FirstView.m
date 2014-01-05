/*
 InAppPurchaseManager > FirstView.m
 
 Created by David Brooks on 12/31/13.
 Copyright (c) 2013 David J Brooks. All rights reserved.
 
 The MIT License (MIT)
 
 Copyright (c) 2013 David J Brooks
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "FirstView.h"

@interface SecondView ()

@end

@implementation SecondView

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Loading of the store
    inAppPurchaseManager = [[InAppPurchaseManager alloc] init];
    [inAppPurchaseManager loadStore];
    
    // Checking if user can make purchases
    [inAppPurchaseManager canMakePurchases];
    
    // Now we can use our IAP
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"]) {
        // Product has been purchased
        // Show premium options
        //
        //
    } else {
        // Product has not been purcahsed
        // Show free options
        //
        //
    }
}

// Method called when button is pressed by user to get upgrade
-(IBAction)buyUpgrade {
    [inAppPurchaseManager purchaseProUpgrade];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseComplete:) name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
}

// Method called after user successfully buys the upgrade
-(void)purchaseComplete:(NSNotification *)notification {
    if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionSucceededNotification]) {
        NSLog(@"Purchase Successful!");
        // Notify user of successful purchase if desired
    }
}

@end
