//
//  KidsIQ5ViewController.m
//  KidsIQ5
//
//  Created by Chan Komagan on 9/17/12.
//  Copyright (c) 2012 Chan Komagan. All rights reserved.
//

#import "KidsIQ5ViewController.h"

@interface KidsIQ5ViewController ()

@end

@implementation KidsIQ5ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
