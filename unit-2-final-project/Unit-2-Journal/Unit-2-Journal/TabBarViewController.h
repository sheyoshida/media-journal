//
//  TabBarViewController.h
//  Unit-2-Journal
//
//  Created by Shena Yoshida on 10/12/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YALFoldingTabBar.h"

@interface TabBarViewController : UITabBarController

@property (nonatomic, copy) NSArray *leftBarItems;
@property (nonatomic, copy) NSArray *rightBarItems;
@property (nonatomic, strong) UIImage *centerButtonImage;
@property (nonatomic, assign) CGFloat tabBarViewHeight;
@property (nonatomic, strong) YALFoldingTabBar *tabBarView;

@end
