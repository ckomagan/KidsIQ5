//
//  ResultController.m
//  KidsIQ5
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "ResultController.h"
#import "KidsIQ5ViewController.h"
#import "NameViewController.h"
#import "LeaderBoardController.h"
#import "ASIFormDataRequest.h"

@interface ResultController()
@property (nonatomic, strong) NSString *nsURL;
@end

@implementation ResultController
@synthesize name; 
@synthesize titleText;
@synthesize score;
@synthesize country;
@synthesize maxQuestions;
bool reset = NO;
@synthesize nsURL;
@synthesize responseData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    nameLabel.text =  [@"Hi there " stringByAppendingString:[name stringByAppendingString:@""]];
    titleLabel.text = titleText;
    scoreLabel.text = [@"Your score is: " stringByAppendingString:score];
    [self sendRequest];
}

- (void)sendRequest
{
    nsURL = @"http://www.komagan.com/KidsIQ/leaders.php?format=json&adduser=1";
    self.responseData = [NSMutableData data];
    
    NSURL *url = [NSURL URLWithString:nsURL];
    NSLog(@"%@", name);
    NSLog(@"%@", score);

    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/xml;charset=UTF-8;"];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:score forKey:@"score"];
    [request setPostValue:country forKey:@"country"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"Request failed: %@",[request error]);
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"Submitted form successfully");
    NSLog(@"Response was:");
    NSLog(@"%@",[request responseString]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(IBAction)dismissView {
    
    KidsIQ5ViewController *quiView = [[KidsIQ5ViewController alloc] initWithNibName:@"KidsIQ5ViewController" bundle:nil];
    [self dismissModalViewControllerAnimated:YES];
    quiView.maxQuestions = maxQuestions;
    [self presentModalViewController:quiView animated:false];
}

-(IBAction)loginScreen {
    
    NameViewController *vc = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil]  instantiateViewControllerWithIdentifier:@"NameViewController"];
    vc.maxQuestions = 0;
    [self presentModalViewController:vc animated:false];
    
}

-(IBAction)leaderBoardScreen {
    
    LeaderBoardController *vc = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil]  instantiateViewControllerWithIdentifier:@"LeaderBoardController"];
    [self presentModalViewController:vc animated:false];
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return (orientation != UIDeviceOrientationLandscapeLeft) &&
	(orientation != UIDeviceOrientationLandscapeRight);
}

@end
