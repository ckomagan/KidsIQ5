//
//  LeaderBoardController.h
//  KidsIQ5
//
//  Created by Chan Komagan on 9/21/12.
//  Copyright (c) 2012 Chan Komagan. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface LeaderBoardController : UIViewController <UITableViewDelegate, UITextFieldDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *leaderList;
    NSMutableData *responseData;
    
}

@property (nonatomic, retain) NSMutableData *responseData;

-(IBAction)dismissView;
-(IBAction)loginScreen;

@end
