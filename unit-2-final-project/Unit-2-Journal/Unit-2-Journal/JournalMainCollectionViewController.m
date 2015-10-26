//
//  JournalMainCollectionViewController.m
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/10/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "JournalMainCollectionViewController.h"
#import <Parse/Parse.h>
#import "ViewCompletedEntryViewController.h"
#import "JournalHeaderView.h"

@interface JournalMainCollectionViewController ()

//<UICollectionViewDelegateFlowLayout>

@end

@implementation JournalMainCollectionViewController

- (void) viewDidAppear:(BOOL)animated {
    
    [self runQuery];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (self.allJournalPosts == nil){
        self.allJournalPosts = [[NSMutableArray alloc]init];
    } else {
        nil;
    }
    
    //  NSLog(@"Current Journal Post: %@", self.journalPostToAdd);
    
    if (self.journalPostToAdd != nil){
        [self. allJournalPosts addObject:self.journalPostToAdd];
    }
    
    // NSLog(@"All Journal Posts: %@", self.allJournalPosts);
    
    self.collectionView.alwaysBounceVertical = YES;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.headerReferenceSize = CGSizeMake(0, 150.0);
    
    // set up custom cell .xib
    UINib *nib = [UINib nibWithNibName:@"JournalHeaderView" bundle:nil];
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self runQuery]; // run Parse query to fetch saved data
}

#pragma mark - fetch saved data from Parse

- (void)runQuery {
    
    // __weak typeof(self) weakSelf = self; // prevent memory leakage?
    
    PFQuery *query = [PFQuery queryWithClassName:@"JournalPost"];
    [query whereKey:@"reviewed" equalTo:[NSNumber numberWithBool:YES]];
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        // create a for loop and iterate through the objects array and push only the posts that are marked with True to "self.allJournalPosts"
        
        [self.allJournalPosts removeAllObjects]; // clear to prevent doubles
        
        for (JournalPost *object in objects) {
//            if (object.reviewed) {
                [self.allJournalPosts addObject:object];
//                [self.allJournalPosts insertObject:object atIndex:0];
//            }
        }
        
        // NSLog(@"info fetched from parse: %@", self.allJournalPosts); // test it!
        
        [self.collectionView reloadData]; // reload tableView
    }];
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        
//        JournalHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        
////        NSString *title = [[NSString alloc]initWithFormat:@"Recipe Group #%i", indexPath.section + 1];
////        headerView.title.text = title;
////        UIImage *headerImage = [UIImage imageNamed:@"header_banner.png"];
////        headerView.backgroundImage.image = headerImage;
//        
//        reusableview = headerView;
//    }
//    return reusableview; 
//}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1; // change to months
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allJournalPosts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    PFObject *post = self.allJournalPosts[indexPath.row]; // pulling out parse data here
    
    
    PFFile *file = post[@"imageForMedia"]; // this returns urls for each image
    
    
    NSString *fileString = [NSString stringWithFormat:@"%@",file];
    NSURL *fileURL = [NSURL URLWithString:fileString];
    NSData *fileData = [NSData dataWithContentsOfURL:fileURL];
    UIImage *fileImage = [UIImage imageWithData:fileData];
    
    UIImageView *collectionImageView = (UIImageView *)[cell viewWithTag:100];
    
    //collectionImageView.image = [UIImage imageNamed:[collectionImages objectAtIndex:indexPath.row]];
    
    JournalPost *thisResult = self.allJournalPosts[indexPath.row];
    iTunesSearchResult *iTunes = thisResult.postSubject;
    
    NSString *imageString = iTunes.artworkURL;
    NSURL *imageURL = [NSURL URLWithString:imageString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    // UIImage *image = [UIImage imageWithData:imageData];
    
    collectionImageView.image = fileImage;
    
    // round corners
    cell.layer.borderWidth = 2.0;
    cell.layer.borderColor = [UIColor blackColor].CGColor;
    cell.layer.cornerRadius = 30.0;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        JournalHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        // configure outlets for .xib here if necessary
        
        return headerView;
    }
    return nil;
}

#pragma mark Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"ViewCompletedEntrySegue"]){
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathForCell:sender];
        ViewCompletedEntryViewController *viewController = segue.destinationViewController;
        JournalPost *thisPost = self.allJournalPosts[selectedIndexPath.row];
        viewController.journalPostDetail = thisPost;
    }
}

@end
