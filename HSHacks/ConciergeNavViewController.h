//
//  ConciergeNavViewController.h
//  HSHacks
//
//  Created by Spencer Yen on 2/19/14.
//  Copyright (c) 2014 hshacks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ConciergeNavViewController : UIViewController <UIActionSheetDelegate>
@property (nonatomic, strong) Firebase* firebase;
@property (nonatomic, strong) NSArray *foodArray;
- (IBAction)shareTwitter:(id)sender;
- (IBAction)shareFacebook:(id)sender;

@end
