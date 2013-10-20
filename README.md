AnyViewButton
=============

A UIView descendant UIControl for iOS that can be used to combine multiple controls like labels and images and whatever and that animates the click and gives back a delegate event ... Simple demo (with Interface Builder) included

It´ simple to use. Just include the control´ header file

#import "anyViewButton.h"

create an instance
  anyViewButton *avButton = [[anyViewButton alloc] initWithFrame:CGRectMake(10, 200, 240, 100)];

and add it to your view
  [self.view addSubview:avButton];

then you can add whatever view as subview of avButton (as you would with a normal UIView)

set the factorForInset (depth of the shrinking when pressed) from 1.0 (no shrinking) to 0.00001 (just a pix ;-)
    avButton.factorForInset = 0.9;

And of course the animation duration when pressing and releasing the pressed views... in seconds.
    avButton.durationForInset = 0.4;
    avButton.durationForInset = 0.1;

Then all you have to do is setting the delegate

    avButton.delegate = self; // now the click calls the STEP 3 below

and handle it in the delegate method

// Step 3: Add the delegate method of the anyViewButton class, that is called, when the button is tapped and
-(void) tapAnyViewButtonInside:(id)sender {
    NSLog(@"You tapped the anyViewButton ");
}

That´s it ;-)

![Screen](screenshot.jpg)

