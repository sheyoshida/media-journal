//
//  CreateJournalEntryViewController.m
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/10/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "CreateJournalEntryViewController.h"
#import "JournalPost.h"
#import "TabBarViewController.h"
#import "JournalMainCollectionViewController.h"
#import <pop/POP.h>
#import <Parse/Parse.h>

@interface CreateJournalEntryViewController () <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *movieOrAlbumNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *doneEditingButton;

@property (strong, nonatomic) IBOutlet UIButton *starButtonOne;
@property (strong, nonatomic) IBOutlet UIButton *starButtonTwo;
@property (strong, nonatomic) IBOutlet UIButton *starButtonThree;
@property (strong, nonatomic) IBOutlet UIButton *starButtonFour;
@property (strong, nonatomic) IBOutlet UIButton *starButtonFive;
@property (strong, nonatomic) NSNumber *rating;

@property (nonatomic) JournalPost *journalPost;
@property (nonatomic) NSMutableArray *journalPostArray;

@end

@implementation CreateJournalEntryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.journalPostArray = [[NSMutableArray alloc]init];
    
    //  NSLog(@"Data has been passed: %@",self.postSearchResult);
    
    self.doneEditingButton.hidden = YES;
    
    //manage textview
    self.textView.delegate = self;
    self.textView.text = @"Write your thoughts here...";
    self.textView.textColor = [UIColor grayColor];
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.cornerRadius = 5.0f;
    self.textView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //populate journal header
    self.movieOrAlbumNameLabel.text = self.postSearchResult.albumOrMovieName;
    self.artistNameLabel.text = self.postSearchResult.artistName;
    NSURL *artworkURL = [NSURL URLWithString:self.postSearchResult.artworkURL];
    NSData *artworkData = [NSData dataWithContentsOfURL:artworkURL];
    UIImage *artworkImage = [UIImage imageWithData:artworkData];
    self.artworkImageView.image = artworkImage;
    
    //round image corners
    self.artworkImageView.clipsToBounds = YES;
    self.artworkImageView.layer.borderColor = [UIColor blackColor].CGColor;
    self.artworkImageView.layer.borderWidth = 2.0;
    self.artworkImageView.layer.cornerRadius = 25.0;
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    
    self.textView.text = @"";
    
    self.textView.textColor = [UIColor whiteColor];
    
    self.doneEditingButton.hidden = NO;
}

- (IBAction)doneEditingTapped:(id)sender {
    
    self.doneEditingButton.hidden = YES;
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - star rating

- (IBAction)oneStarTapped:(id)sender {
    
    [self resetStars];
    [self oneStarRating];
    [self startAnimation];
}

- (IBAction)twoStarTapped:(id)sender {
    
    [self resetStars];
    [self twoStarRating];
    [self startAnimation];
}

- (IBAction)threeStarTapped:(id)sender {
    
    [self resetStars];
    [self threeStarRating];
    [self startAnimation];
}

- (IBAction)fourStarTapped:(id)sender {
    
    [self resetStars];
    [self fourStarRating];
    [self startAnimation];
}
- (IBAction)fiveStarTapped:(id)sender {
    
    [self resetStars];
    [self fiveStarRating];
    [self startAnimation];
}

- (void)resetStars {
    
    [self.starButtonOne setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starButtonTwo setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starButtonThree setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starButtonFour setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
    [self.starButtonFive setBackgroundImage:[UIImage imageNamed:@"rating_star2.png"] forState:UIControlStateNormal];
}

- (void)oneStarRating {
    
    self.rating = @1; // assign rating for parse
    [self.starButtonOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)twoStarRating {
    
    self.rating = @2; // assign rating for parse
    [self.starButtonOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)threeStarRating {
    
    self.rating = @3; // assign rating for parse
    [self.starButtonOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonThree setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)fourStarRating {
    
    self.rating = @4; // assign rating for parse
    [self.starButtonOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonThree setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonFour setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

- (void)fiveStarRating {
    self.rating = @5; // assign rating for parse
    [self.starButtonOne setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonTwo setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonThree setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonFour setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
    [self.starButtonFive setBackgroundImage:[UIImage imageNamed:@"rating_star_filled2.png"] forState:UIControlStateNormal];
}

#pragma mark - animate all

- (void)startAnimation {
    
    POPSpringAnimation *spin = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    
    spin.fromValue = @(M_PI / 4);
    spin.toValue = @(5);
    spin.springBounciness = 5;
    spin.velocity = @(1);
    
    [self.starButtonOne.layer pop_addAnimation:spin forKey:nil];
    [self.starButtonTwo.layer pop_addAnimation:spin forKey:nil];
    [self.starButtonThree.layer pop_addAnimation:spin forKey:nil];
    [self.starButtonFour.layer pop_addAnimation:spin forKey:nil];
    [self.starButtonFive.layer pop_addAnimation:spin forKey:nil];
}

#pragma mark - save items

- (IBAction)logToJournalButtonTapped:(id)sender {
    
    JournalPost *journalPost = [[JournalPost alloc]init];
    
    journalPost.postText = self.textView.text;
    journalPost.postSubject = self.postSearchResult;
    
    self.journalPost = journalPost;
    
    [self.journalPostArray addObject:self.journalPost];
    
    // NSLog(@"Journal Post: %@",self.journalPost);
    
    [self.navigationController popToRootViewControllerAnimated:YES]; // pop back to root controller
    
    [self.tabBarController setSelectedIndex:2]; // send to correct tab
    
    //  NSLog(@"my journal text is: %@", self.textView.text);
    
    // when we log the journal entry, SAVE it all to Parse
    JournalPost *myJournalPost = [[JournalPost alloc] init]; // most of this is a repeat of above.

    if ([self.textView.text isEqualToString:@"Write your thoughts here..."]){
        self.textView.text = @"";
    }
    
    myJournalPost[@"postText"] = self.textView.text;
    myJournalPost[@"starRating"] = self.rating;
    myJournalPost[@"title"] = self.postSearchResult.albumOrMovieName;
    myJournalPost[@"creator"] = self.postSearchResult.artistName;
    myJournalPost[@"dateEntered"] = [NSDate date];
    myJournalPost[@"typeOfMedia"] = self.postSearchResult.mediaType;
    myJournalPost[@"imageForMedia"] = self.postSearchResult.artworkURL;
    myJournalPost[@"reviewed"] = [NSNumber numberWithBool:YES];
    
    [myJournalPost saveEventually]; // save your entry, even if offline
}

@end
