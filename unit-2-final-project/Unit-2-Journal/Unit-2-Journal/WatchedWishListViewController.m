//
//  WatchedWishListViewController.m
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/20/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "WatchedWishListViewController.h"
#import "pop/POP.h"
#import "JournalPost.h"
#import <Parse/Parse.h>

@interface WatchedWishListViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mediaImageView;
@property (weak, nonatomic) IBOutlet UILabel *mediaTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mediaCreatorLabel;

@property (weak, nonatomic) IBOutlet UIButton *starOne;
@property (weak, nonatomic) IBOutlet UIButton *starTwo;
@property (weak, nonatomic) IBOutlet UIButton *starThree;
@property (weak, nonatomic) IBOutlet UIButton *starFour;
@property (weak, nonatomic) IBOutlet UIButton *starFive;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (nonatomic) NSMutableArray *journalPostArray;

@property (strong, nonatomic) NSNumber *rating; // for parse
@property (nonatomic) JournalPost *journalPost;
@property (nonatomic) NSString *mediaType;


@end

@implementation WatchedWishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.journalPostArray = [[NSMutableArray alloc] init];
    
    self.mediaTitleLabel.text = self.journalPostDetail.title;
    self.mediaCreatorLabel.text = self.journalPostDetail.creator;
    self.doneButton.hidden = YES;
    
    NSURL *artworkURL = [NSURL URLWithString:self.journalPostDetail.imageForMedia];
    NSData *artworkData = [NSData dataWithContentsOfURL:artworkURL];
    UIImage *artworkImage = [UIImage imageWithData:artworkData];
    self.mediaImageView.image = artworkImage;
    
    self.mediaType = self.journalPostDetail.typeOfMedia;
    
    // NSLog(@"journal post detail: %@", self.journalPostDetail); // test it
    
    //round image corners
    self.mediaImageView.clipsToBounds = YES;
    self.mediaImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.mediaImageView.layer.borderWidth = 2.0;
    self.mediaImageView.layer.cornerRadius = 25.0;
    
    //manage textview
    self.textView.delegate = self;
    self.textView.text = @"Write your thoughts here...";
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    
    self.textView.text = @"";
    self.doneButton.hidden = NO;
}

#pragma mark - buttons

- (IBAction)doneButtonTapped:(id)sender {
    
    self.doneButton.hidden = YES;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (IBAction)logToJournalButtonTapped:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"JournalPost"];
    [query whereKey:@"title" equalTo:self.journalPostDetail.title];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    
        NSLog(@"%@", objects);
        
        JournalPost *existingPost = [objects firstObject];
        existingPost[@"postText"] = self.textView.text;
        existingPost[@"starRating"] = self.rating;
        existingPost[@"dateEntered"] = [NSDate date];
        existingPost[@"reviewed"] = [NSNumber numberWithBool:YES];
        
        [existingPost saveEventually]; // save entry
    }];
    
    
    
//    JournalPost *myJournalPost = [[JournalPost alloc]init];
//    
//    myJournalPost[@"postText"] = self.textView.text;
//    myJournalPost[@"starRating"] = self.rating;
//    myJournalPost[@"title"] = self.journalPostDetail.title;
//    myJournalPost[@"creator"] = self.journalPostDetail.creator;
//    myJournalPost[@"dateEntered"] = [NSDate date];
//    myJournalPost[@"typeOfMedia"] = self.mediaType;
//    myJournalPost[@"imageForMedia"] = self.journalPostDetail.imageForMedia;
//    myJournalPost[@"reviewed"] = [NSNumber numberWithBool:YES];
//
//    NSLog(@"my Journal post %@", myJournalPost);
//    
//    [myJournalPost saveEventually]; // save entry
    
    [self.navigationController popToRootViewControllerAnimated:YES]; // pop back to root controller
    
    [self.tabBarController setSelectedIndex:2]; // send to correct tab
    
    // NOTE: this saves new entry, but does not remove existing wishlist entry...
    
}

#pragma mark - stars

- (IBAction)starOneTapped:(id)sender {
    
    [self resetStars];
    [self oneStarRating];
    [self startAnimation];
}
- (IBAction)starTwoTapped:(id)sender {
    
    [self resetStars];
    [self twoStarRating];
    [self startAnimation];
}
- (IBAction)starThreeTapped:(id)sender {
    [self resetStars];
    [self threeStarRating];
    [self startAnimation];
}

- (IBAction)starFourTapped:(id)sender {
    
    [self resetStars];
    [self fourStarRating];
    [self startAnimation];
}

- (IBAction)starFiveTapped:(id)sender {
    
    [self resetStars];
    [self fiveStarRating];
    [self startAnimation];
}

- (void)oneStarRating {
    
    self.rating = @1; // assign rating for parse
    [self.starOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)twoStarRating {
    
    self.rating = @2; // assign rating for parse
    [self.starOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)threeStarRating {
    
    self.rating = @3; // assign rating for parse
    [self.starOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starThree setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)fourStarRating {
    
    self.rating = @4; // assign rating for parse
    [self.starOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starThree setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starFour setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)fiveStarRating {
    
    self.rating = @5; // assign rating for parse
    [self.starOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starThree setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starFour setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starFive setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)resetStars {
    
    [self.starOne setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starTwo setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starThree setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starFour setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starFive setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
}

#pragma mark - animate

- (void)startAnimation {
    
    POPSpringAnimation *spin = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    spin.fromValue = @(M_PI / 4);
    spin.toValue = @(5);
    spin.springBounciness = 5;
    spin.velocity = @(1);
    
    [self.starOne.layer pop_addAnimation:spin forKey:nil];
    [self.starTwo.layer pop_addAnimation:spin forKey:nil];
    [self.starThree.layer pop_addAnimation:spin forKey:nil];
    [self.starFour.layer pop_addAnimation:spin forKey:nil];
    [self.starFive.layer pop_addAnimation:spin forKey:nil];
}

@end
