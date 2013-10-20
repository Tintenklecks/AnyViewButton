//
//  ViewController.h
//  AnyViewButtonDemo
//
//  Created by Ingo Böhme on 20.10.13.
//  Copyright (c) 2013 IBMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "anyViewButton.h"                         //Step1: Import header file

@interface ViewController : UIViewController<anyViewButtonDelegate> // Step 2: add the interaction delegate

@end
