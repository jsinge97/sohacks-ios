//
//  ConciergeNavViewController.m
//  HSHacks
//
//  Created by Spencer Yen on 2/19/14.
//  Copyright (c) 2014 hshacks.com. All rights reserved.
//

#import "ConciergeNavViewController.h"
#import <Social/Social.h>
#define kFirechatNS @"https://sohacksfood.firebaseio.com/"

@interface ConciergeNavViewController ()

@end

@implementation ConciergeNavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.firebase = [[Firebase alloc] initWithUrl:kFirechatNS];
    [self.firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot.value == [NSNull null]) {
            NSLog(@"wat");
        } else {
            self.foodArray = [[NSArray alloc]initWithArray:snapshot.value];
            
            NSLog(@"snapshot value: %@", snapshot.value);
        }
    }];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shareFacebook:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *composeController = [SLComposeViewController
                                                      composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [composeController setInitialText:@"SoHacks is #stacked!"];
        //Post actual selfie?
        //[composeController addImage:postImage.image];
        [self presentViewController:composeController
                           animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"Looks like you don't have a Facebook account linked to this device." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
}

- (IBAction)shareTwitter:(id)sender {
    
    UIActionSheet *foodActionSheet = [[UIActionSheet alloc] init];
    foodActionSheet.delegate = self;
    
    for (int i = 0; i < self.foodArray.count; i++) {
        [foodActionSheet addButtonWithTitle:[self.foodArray objectAtIndex:i]];
    }
    [foodActionSheet addButtonWithTitle:@"Cancel"];

    [foodActionSheet showFromTabBar:self.tabBarController.tabBar];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (![title isEqualToString:@"Cancel"]) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            NSString *message = [NSString stringWithFormat:@"I want some %@ at table ___! @sohacks #sohacks",title];
            [tweetSheet setInitialText:message];
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Oops" message: @"Looks like you don't have a Twitter account linked to this device." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

@end
