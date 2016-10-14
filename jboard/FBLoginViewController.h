//
//  FBLoginViewController.h
//  jboard
//
//  Created by Luis Ezcurdia on 10/14/16.
//  Copyright © 2016 Luis Ezcurdia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface FBLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end
