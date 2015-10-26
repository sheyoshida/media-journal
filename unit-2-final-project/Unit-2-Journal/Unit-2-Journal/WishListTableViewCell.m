//
//  WishListTableViewCell.m
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/21/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "WishListTableViewCell.h"
#import <Pop/POP.h>

@implementation WishListTableViewCell

- (void)awakeFromNib {
    
    // round corners
    self.artworkImage.clipsToBounds = YES;
    self.artworkImage.layer.borderColor = [UIColor blackColor].CGColor;
    self.artworkImage.layer.borderWidth = 2.0;
    self.artworkImage.layer.cornerRadius = 25.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// animate custom cells
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];
    
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.1;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        [self.titleLabel pop_addAnimation:scaleAnimation forKey:nil];
        [self.authorArtistDirectorLabel pop_addAnimation:scaleAnimation forKey:nil];
        [self.artworkImage pop_addAnimation:scaleAnimation forKey:nil];
        
    } else {
        POPSpringAnimation *sprintAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        sprintAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
        sprintAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        sprintAnimation.springBounciness = 20.f;
        [self.titleLabel pop_addAnimation:sprintAnimation forKey:nil];
        [self.authorArtistDirectorLabel pop_addAnimation:sprintAnimation forKey:nil];
        [self.artworkImage pop_addAnimation:sprintAnimation forKey:nil];
    }
}

@end

