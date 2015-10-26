//
//  WishListTableViewController.m
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/10/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "WishListTableViewController.h"
#import "WishListTableViewCell.h"
#import <Parse/Parse.h>
#import "JournalPost.h"
#import "WatchedWishListViewController.h"

@interface WishListTableViewController ()

@property (nonatomic) NSString *objectID;

@end

@implementation WishListTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.allJournalPosts == nil) {
        self.allJournalPosts = [[NSMutableArray alloc] init];
    }
    
    // set up custom cell .xib
    UINib *nib = [UINib nibWithNibName:@"WishListTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"WishListTableViewCellIdentifier"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 35.0;
    [self.tableView setTableFooterView:[UIView new]]; // hide extra lines in empty tableview cells
    
    [self pullEntriesFromParse];
}
- (void)viewDidAppear:(BOOL)animated {
    
    [self pullEntriesFromParse];
}

- (void)pullEntriesFromParse {
    
    PFQuery *query = [PFQuery queryWithClassName:@"JournalPost"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [self.allJournalPosts removeAllObjects]; // clear to prevent doubles
        
        // create a for loop and iterate through the objects array and push only the posts that are marked with True to "self.allJournalPosts"
        for (JournalPost *object in objects) {
            if (!object.reviewed) {
                
                [self.allJournalPosts insertObject:object atIndex:0];

                //[self.allJournalPosts addObject:object];
                
            }
        }
        // self.allJournalPosts = objects; // pull all images from Parse
        
       // NSLog(@"info fetched from parse: %@", self.allJournalPosts); // test it!
        
        [self.tableView reloadData]; // reload tableView
    }];
}

//#pragma  mark - swipe gestures
//
//- (void)setUpSwipeGestures
//{
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(userSwipedLeft:)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:swipeLeft];
//}
//
//- (void)userSwipedLeft:(UISwipeGestureRecognizer*)swipe
//{
//    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
//
//        [self performSegueWithIdentifier:@"pushToHomeList" sender:self];
//
//        //[self dismissViewControllerAnimated:YES completion:nil];
//    }
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.allJournalPosts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WishListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WishListTableViewCellIdentifier" forIndexPath:indexPath];
    
    JournalPost *thisEntry = self.allJournalPosts[indexPath.row];
  
    cell.titleLabel.text = thisEntry.title;
    cell.authorArtistDirectorLabel.text = thisEntry.creator;
    
    NSString *imageString = thisEntry.imageForMedia;
    NSURL *imageURL = [NSURL URLWithString:imageString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    cell.artworkImage.image = image;
    
    // format table view lines
    cell.preservesSuperviewLayoutMargins = false;
  //  cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

#pragma mark - didSelectRowAtIndexPath

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get the data that we're going to pass
    JournalPost *post = self.allJournalPosts[indexPath.row];
    
    // declare where we're sending the data
    WatchedWishListViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WishListJournalEntry"];
    
    // pass the data
    detailViewController.journalPostDetail = post;
    
    // present the view controller
    [self.navigationController pushViewController:detailViewController animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete cell from Parse
        PFQuery *object = [self.allJournalPosts objectAtIndex:indexPath.row];
        [object delete:nil];
        
        // then remove the reference from the table view
        [self.allJournalPosts removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // reload table view with new data
        [self.tableView reloadData];
        
    }
}
         
#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //identifier: moveFromWishToJournalEntry
    
    if ([[segue identifier] isEqualToString:@"moveFromWishToJournalEntry"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
        WatchedWishListViewController *viewController = segue.destinationViewController;
        JournalPost *thisPost = self.allJournalPosts[selectedIndexPath.row];
        
        viewController.journalPostDetail = thisPost;
    }
}

@end
