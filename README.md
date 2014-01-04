InAppPurchaseManager
====================

Singleton class for In App Purchases for iOS development (Non-Consumables Only) ARC-Compatible

Usage
=====

*NOTE* StoreKit does not work on the Simulator. You must test on a physical device.

This is a drop in class for projects that have already set up a In App Purchase through iTunes Connect.

1. Change the product ID found in line 35 of InAppPurcahseManager.m
2. In your first view controller, create a new InAppPurchaseManger object and then load the store.  Do not do this in your App Delegate.
'''''
InAppPurchaseManager = [[InAppPurcahseManager alloc] init];
[inAppPurchaseManager loadStore];
'''''
