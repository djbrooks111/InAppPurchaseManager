InAppPurchaseManager
====================

Singleton class for In App Purchases for iOS development (Non-Consumables Only) ARC-Compatible

Usage
=====

**NOTE** StoreKit does not work on the Simulator. You must test on a physical device.

This is a drop in class for projects that have already set up a In App Purchase through iTunes Connect.

**Change the product ID found in line 35 of InAppPurcahseManager.m**

If you need IAP access across multiple views, look at the example found in the Access Multiple Views folder.  Else, look at the example in the Access Single View folder.

If you plan on have IAP access in just a single view, then the process is very simple!

Single View
===========

*In our FirstView.h file*
- - -
1. Import InAppPurchaseManager.h
2. Create a reference to our Manager

```
// 1. Import our IAP Manager
#import "InappPurchaseManager.h"

@interface FirstView : UIViewController {
    // 2. Create reference to our Manager
    InAppPurchaseManager *inAppPurchaseManager;
}

@end
```

*In our FirstView.m file*
- - -
1. Within our viewDidLoad method, allocate our Manager and initialize it.
2. Have the Manager load our IAP store (i.e. Have the Manager connect to the App Store to retrieve our products)
3. Check to see if the user can make purchases
4. Create a method that will call our Manager to buy a product. This is usually called from a UIButton associated with the view.
5. Create a method that will be called once the purchase is complete. This method is used to unlock features.

```
-(void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. Allocate our Manager and initialize it
    inAppPurchaseManager = [[InAppPurchaseManager alloc] init];
    
    // 2. Load the store
    [inAppPurchaseManager loadStore];
    
    // 3. Can the user make purchases?
    [inAppPurchaseManager canMakePurchases];
}

// 4. Method to buy product
-(IBAction)buyUpgrade {
    [inAppPurchaseManager purchaseProUpgrade];
    
    // Add a notification observer to tell us when the purchase has been completed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(purchaseComplete:) name:kInAppPurchaseManagerTransactionSucceededNotification object:nil];
}

// 5. Method called once purchase is complete
-(void)purchaseComplete:(NSNotification *)notification {
    if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionSucceededNotification]) {
        NSLog(@"Purchase Successful!");
        // Notify user of successful purchase if desired
    }
}
```

Multiple Views
==============

Let's say that you have a two view app with ads in both views, however, the option to buy our IAP to remove those ads is in our second view.  Since we need the same reference to our Manager between those two views, we will use a third file that will be our data storage.  This is also a helpful solution if you need to share data across multiple views or your entire app.

And so, we create our DataStorage file. Since our Manager's reference is in our DataStorage class, we will import that file into the views we need our Manager for.

*In our DataStorage.h*
- - -
1. Import our Manager
2. Create an extern reference to our Manager

```
#import <Foundation/Foundation.h>
// 1. Import our Manager
#import "InAppPurchaseManager.h"

// 2. Create an extern reference to our Manager
extern InAppPurchaseManager *inAppPurchaseManager;

@interface DataStorage : NSObject

@end
```

*In our DataStorage.m*
- - -
1. Declare our Manager

```
#import "DataStorage.h"

@implementation DataStorage

// 1. Declare our Manager
InAppPurchaseManager *inAppPurchaseManager;

@end
```

Now, we can work with our two views that need the Manager.

*In our FirstView.h*
- - -
1. Follow the same process as before, however, we now import DataStorage instead of our Manager

```
#import <UIKit/UIKit.h>
// 1. DataStorage import, not Manager
#import "DataStorage.h"

@interface FirstView : UIViewController
    // We are not creating a Manager reference since our reference is already within DataStorage
@end
```

*In our FirstView.m*
- - -

```
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Loading of the store
    inAppPurchaseManager = [[InAppPurchaseManager alloc] init];
    [inAppPurchaseManager loadStore];
    
    // Checking if user can make purchases
    [inAppPurchaseManager canMakePurchases];
    
    // Now we can use our IAP
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isProUpgradePurchased"]) {
        // Product has been purchased
        // Show premium options
    } else {
        // Product has not been purcahsed
        // Show free options
    }
}
```

*In Our SecondView.h*
- - -
1. Only need to import our DataStorage

```
#import <UIKit/UIKit.h>
// 1. DataStorage
#import "DataStorage.h"

@interface SecondView : UIViewController

@end
```

*In our SecondView.m*
- - -
1. We only need the purchase methods here since our Manager has already been allocated in our FirstView

```
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
```

And that is it! Now just test your IAP and off you go!
