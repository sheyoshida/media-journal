//
//  SearchAPITableViewCell.h
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/12/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchAPITableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorArtistDirectorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImage;

@end
