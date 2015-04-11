//
//  GameDetailsViewController.h
//  FeedReader
//
//  Created by Alfredo E. Pérez L. on 4/11/15.
//  Copyright (c) 2015 Alfredo E. Pérez L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (copy, nonatomic) NSString *url;
@end
