//
//  anyViewButton.m
//  AnyViewButtonTest
//
//  Created by Ingo Böhme on 19.10.13.
//  Copyright (c) 2013 BLABLA AG. All rights reserved.
//

#import "anyViewButton.h"

@interface anyViewButton ()

    @property(nonatomic, strong) UIView *anyView;
    @property(nonatomic, strong) UIImageView *normalView;
    @property(nonatomic) BOOL canceledTouch;  // touch was cancelled
    @property(nonatomic) BOOL activeTouch;    // is currently a touch animation active

@end


@implementation anyViewButton

- (void)setDefaultValues {
    _factorForInset = 0.5;
    _durationForInset = 0.1;
    _durationForRelease = 0.3;
    

}

- (id)init {

    self = [super init];
    if (self) {
        [self setDefaultValues];
    }
    return self;


}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];

        [self setDefaultValues];
        
        // put all IBbuilder elements to the new UIView and set it as anyview
        UIView *newView = [[UIView alloc] initWithFrame:self.bounds];
        for (id subview in self.subviews) {
            [newView addSubview:subview];
        }
        [self setAnyView:newView];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code

        [self setDefaultValues];

        // put all IBbuilder elements to the new UIView and set it as anyview
        [self setAnyView:nil];
    }
    return self;

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_activeTouch)
        return;

    _activeTouch = YES;
    _canceledTouch = NO;
    _normalView = [[UIImageView alloc] initWithImage:[self takeScreenshot:self]];
    [self addSubview:_normalView];
    self.anyView.hidden = YES;
    CGRect bounds = _normalView.bounds;
    CGPoint center = CGPointMake(bounds.size.width / 2, bounds.size.height / 2);
    bounds.size.width = _factorForInset * bounds.size.width;
    bounds.size.height = _factorForInset * bounds.size.height;


    [UIView animateWithDuration:_durationForInset delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _normalView.bounds = bounds;
        _normalView.center = center;

    }                completion:^(BOOL finished) {

    }];


}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    _canceledTouch = YES;
    [self touchesEnded:touches withEvent:event];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);

    [UIView animateWithDuration:_durationForRelease delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{

        _normalView.bounds = self.bounds;
        _normalView.center = center;

    }                completion:^(BOOL finished) {

        self.anyView.hidden = NO;
        [_normalView removeFromSuperview];
        _normalView = nil;
        _activeTouch = NO;

    }];

    if (! _canceledTouch) {
        
        if (_delegate) {
            [_delegate tapAnyViewButtonInside:self];
        }
    }



}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint tappedPt = [[touches anyObject] locationInView:self];
    CGFloat xPos = tappedPt.x;
    CGFloat yPos = tappedPt.y;
    if (xPos < 0 || xPos > self.bounds.size.width || yPos < 0 || yPos > self.bounds.size.height) {
        [self touchesCancelled:touches withEvent:event];
    }
    NSLog(@"NSStringFromCGPoint(tappedPt) = %@", NSStringFromCGPoint(tappedPt));
}

- (void)setAnyView:(UIView *)anyView {
    
    if (anyView==nil) {
        anyView = [[UIView alloc] initWithFrame:self.bounds];
        for (id subview in self.subviews) {
            [anyView addSubview:subview];
        }
    }
    _anyView = anyView;
    _anyView.userInteractionEnabled = NO;
    [self addSubview:_anyView];
}

- (void)finishedAddingSubviews {
  [self setAnyView:nil];
}



- (UIImage *)takeScreenshot:(UIView *)view {
    CGRect rect = [view bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
