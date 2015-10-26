//
//  iTunesSearchResult.m
//  Unit-2-Journal
//
//  Created by Jamaal Sedayao on 10/11/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "iTunesSearchResult.h"

@implementation iTunesSearchResult

@dynamic artistName;
@dynamic artworkURL;
@dynamic albumOrMovieName;
@dynamic addedDate;
@dynamic mediaType;

+(NSString *)parseClassName {
    return @"iTunesSearchResult";
}



@end
