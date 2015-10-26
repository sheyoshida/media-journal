//
//  iTunesSearchResult.h
//  Unit-2-Journal
//
//  Created by Jamaal Sedayao on 10/11/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "PFObject.h"

@interface iTunesSearchResult : PFObject <PFSubclassing>

@property (nonatomic) NSString *artistName;
@property (nonatomic) NSString *albumOrMovieName;
@property (nonatomic) NSString *artworkURL;
@property (nonatomic) NSDate *addedDate;
@property (nonatomic) NSString *mediaType; 


@end
