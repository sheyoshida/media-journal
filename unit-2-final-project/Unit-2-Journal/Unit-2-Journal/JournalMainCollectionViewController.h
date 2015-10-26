//
//  JournalMainCollectionViewController.h
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/10/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JournalPost.h"
#import "CreateJournalEntryViewController.h"



@interface JournalMainCollectionViewController : UICollectionViewController
{
    NSMutableArray *collectionImages;
}

@property (nonatomic) NSMutableArray *allJournalPosts;
@property (nonatomic) JournalPost *journalPostToAdd;
@property (nonatomic) JournalPost *journalPostToPass;

@end
