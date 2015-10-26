//
//  JournalPost.m
//  Unit-2-Journal
//
//  Created by Jamaal Sedayao on 10/12/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "JournalPost.h"

@implementation JournalPost

@dynamic postText;
@dynamic postSubject;

// added
@dynamic title;
@dynamic creator; // artist, writer, director
@dynamic dateEntered;
@dynamic starRating;
@dynamic typeOfMedia; // ie book, album, movie, tv
@dynamic imageForMedia;
@dynamic reviewed;

+(NSString *)parseClassName {
    return @"JournalPost";
}

@end
