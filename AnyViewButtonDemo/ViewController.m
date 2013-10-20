//
//  ViewController.m
//  AnyViewButtonDemo
//
//  Created by Ingo Böhme on 20.10.13.
//  Copyright (c) 2013 IBMobile. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property(nonatomic,strong) UILabel *theLabel;
@property(nonatomic) NSInteger numberOfClicks;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// One AnyViewButton is created with IB. The second one is now created here with two left aligned labels
    
    anyViewButton *avButton = [[anyViewButton alloc] initWithFrame:CGRectMake(10, 200, 240, 100)];
    [self.view addSubview:avButton];
    
    //
    avButton.delegate = self; // now the click calls the STEP 3 below
    avButton.factorForInset = 0.9;
    avButton.durationForInset = 0.4;
    avButton.durationForInset = 0.1;
    
    
    _theLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 220, 20)];
    _theLabel.text = @"This is the first Button Label";
    [avButton addSubview:_theLabel];
    _theLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 180, 20)];
    _theLabel.text = @"Klick me please";
    _theLabel.font = [UIFont systemFontOfSize:10];
    [avButton addSubview:_theLabel];
    [avButton finishedAddingSubviews]; // the last subview is set ;-)
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Step 3: Add the delegate method of the anyViewButton class, that is called, when the button is tapped and
-(void) tapAnyViewButtonInside:(id)sender {
    
    _numberOfClicks++;
    _theLabel.text = [NSString stringWithFormat:@"clicked %ld times", (long)_numberOfClicks];
    NSLog(@"You tapped the anyViewButton %@" , sender);
}
@end
