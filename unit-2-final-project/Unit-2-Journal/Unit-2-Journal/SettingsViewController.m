//
//  SettingsViewController.m
//  Unit-2-Journal
//
//  Created by Jamaal Sedayao on 10/19/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "SettingsViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc]init];
    loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}


@end
