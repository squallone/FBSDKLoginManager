//
//  ViewController.m
//  Testing FB
//
//  Created by Abdiel Soto on 6/19/15.
//  Copyright (c) 2015 Abdiel Soto. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([FBSDKAccessToken currentAccessToken]) {
        NSLog(@"Logged");
        // User is logged in, do work such as go to next view controller.
    }else{
        NSLog(@"Not Logged");
    }
}
- (IBAction)didTapLoginButton:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email", @"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            NSLog(@"Process Error");
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"Handle cancellations");

        } else if ([result.declinedPermissions containsObject:@"public_profile"]) {
            // TODO: do not request permissions again immediately. Consider providing a NUX
            // describing  why the app want this permission.
        }else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                NSLog(@"Do work");
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", result);
                     }
                 }];
            }
        }
    }];
}

/* ViewDid Appear */

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
