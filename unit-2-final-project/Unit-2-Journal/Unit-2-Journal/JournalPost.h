//
//  JournalPost.h
//  Unit-2-Journal
//
//  Created by Jamaal Sedayao on 10/12/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <Parse/Parse.h>
#import "iTunesSearchResult.h"

@interface JournalPost : PFObject <PFSubclassing>

@property (nonatomic) NSString *postText;
@property (nonatomic) iTunesSearchResult *postSubject;

// added
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *creator; // artist, writer, director
@property (nonatomic) NSDate *dateEntered;
@property (nonatomic) NSNumber *starRating;
@property (nonatomic) NSString *typeOfMedia; // ie book, album, movie, tv
@property (nonatomic) NSString *imageForMedia;
@property (nonatomic) BOOL reviewed;

@end
