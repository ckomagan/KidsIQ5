//
//  LeaderBoardController.m
//  KidsIQ5
//
//  Created by Chan Komagan on 8/20/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "LeaderBoardController.h"
#import "NameViewController.h"
#import "ASIFormDataRequest.h"

@interface LeaderBoardController()
@property (nonatomic, strong) NSString *nsURL;
@end;

@implementation LeaderBoardController

NSArray *tableData;
NSIndexPath *currentSelection;
@synthesize nsURL;
@synthesize responseData;
NSDictionary *res;
UITableViewCell *cell;
NSString *name, *score, *country;

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
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [leaderList setDelegate:self];
    [leaderList setDataSource:self];
    
    [self receiveData];
    
}

-(void)receiveData
{
    nsURL = @"http://www.komagan.com/KidsIQ/leaders.php?format=json&getleaders=1";
    self.responseData = [NSMutableData data];
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: nsURL]];
    [[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
    NSError *myError = nil;
    res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    for(NSDictionary *res1 in res) {
        name = [res1 objectForKey:@"name"];
        NSLog(@"name = %@", name);
        
        score = [res1 objectForKey:@"score"];
        country = [res1 objectForKey:@"country"];
    }
    NSString *space = @"             ";
    NSString *row = [name stringByAppendingString:[space stringByAppendingString:[score stringByAppendingString:[space stringByAppendingString:country]]]];
    
    tableData = [NSArray arrayWithObjects: row, nil];
    [leaderList reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //NSLog(@"didFailWithError");
    //NSLog(@"Connection failed: %@", [error description]);
    self.responseData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"connectionDidFinishLoading");
    //NSLog(@"Succeeded! Received %d bytes of data",[self.responseData length]);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(IBAction)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    cell = [leaderList dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    id path = @"http://wholefoodsmarketcooking.com/images/foodpickle/wholefoods_user_icon.png?1343251919";
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData: data];
    cell.textLabel.font = [UIFont boldSystemFontOfSize: 15.0];
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    [cell.imageView setImage:img];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    currentSelection = indexPath;
    [self performSegueWithIdentifier:@"offerDetailsPage" sender:self];
}

-(IBAction)loginScreen {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil]  instantiateViewControllerWithIdentifier:@"NameViewController"];
    [self presentModalViewController:vc animated:false];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return (orientation != UIDeviceOrientationLandscapeLeft) &&
	(orientation != UIDeviceOrientationLandscapeRight);
}

@end
