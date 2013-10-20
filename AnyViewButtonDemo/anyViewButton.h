//
//  anyViewButton.h
//  AnyViewButtonTest
//
//  Created by Ingo Böhme on 19.10.13.
//  Copyright (c) 2013 BLABLA AG. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol anyViewButtonDelegate <NSObject>
@required 

@optional
    - (void)tapAnyViewButtonInside:(id)sender;
@end




@interface anyViewButton : UIControl<anyViewButtonDelegate>

    @property (nonatomic, strong) id <anyViewButtonDelegate> delegate;

    @property(nonatomic) float factorForInset; // factor from 0.xx to 1.0 for the press animation
    @property(nonatomic) float durationForInset; // duration in seconds for the press animation
    @property(nonatomic) float durationForRelease; // duration in seconds for the release animation

    -(void) setAnyView: (UIView *) anyView; // setting the view that is displayed (and animated) on the button



@end
