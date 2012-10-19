//
//  LeaderBoardDetailController.h
//  KidsIQ5
//
//  Created by Chan Komagan on 10/15/12.
//  Copyright (c) 2012 Chan Komagan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardDetailController : UIViewController
{
    IBOutlet UILabel *nameLabel, *scoreLabel, *fCountLabel, *mCountLabel, *sCountLabel;
    IBOutlet UIProgressView *fCountView, *mCountView, *sCountView;
}
@property (nonatomic, retain) NSString *name, *scoreDetail;
@property int fCount, mCount, sCount, fTCount, mTCount, sTCount;

-(IBAction)dismissView;

@end
