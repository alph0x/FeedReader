//
//  GameDetailsViewController.m
//  FeedReader
//
//  Created by Alfredo E. Pérez L. on 4/11/15.
//  Copyright (c) 2015 Alfredo E. Pérez L. All rights reserved.
//

#import "GameDetailsViewController.h"

@interface GameDetailsViewController ()

@end

@implementation GameDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    NSURL *myURL = [NSURL URLWithString: [self.url stringByAddingPercentEscapesUsingEncoding:
                                          NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [self leftBarButtonWithTitle:@"BACK" andSelector:@selector(goBack)];
    [self setTitle:@"Game Details"];
}

-(UIBarButtonItem *)leftBarButtonWithTitle:(NSString *)title andSelector:(SEL)selector
{
    UIBarButtonItem *lb=[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    [lb setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"HelveticaNeue-Thin" size:12.], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    return lb;
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
