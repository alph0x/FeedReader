//
//  GameTableViewCell.h
//  FeedReader
//
//  Created by Alfredo E. Pérez L. on 4/11/15.
//  Copyright (c) 2015 Alfredo E. Pérez L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *gameTitle;
@property (strong, nonatomic) IBOutlet UILabel *gameDescription;
@property (strong, nonatomic) IBOutlet UILabel *gameLaunchDate;

@end
