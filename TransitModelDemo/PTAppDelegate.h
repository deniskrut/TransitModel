//
//  PTAppDelegate.h
//  TransitModelDemo
//
//  Created by Denis Krut on 17.12.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTViewController;

@interface PTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PTViewController *viewController;

@end
