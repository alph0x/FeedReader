//
//  ViewController.m
//  FeedReader
//
//  Created by Alfredo E. Pérez L. on 4/11/15.
//  Copyright (c) 2015 Alfredo E. Pérez L. All rights reserved.
//

#import "ViewController.h"
#import "GameTableViewCell.h"
#import "GameDetailsViewController.h"

@interface ViewController () {
    
    IBOutlet UITableView *gamesTable;
    NSXMLParser *parser;
    NSMutableArray *feed;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *description;
    NSMutableString *launchDate;
    NSMutableString *link;
    NSString *element;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Alloc variables
    feed = [[NSMutableArray alloc] init];
    
    //RSS URL
    NSURL *url = [NSURL URLWithString:@"http://webassets.scea.com/pscomauth/groups/public/documents/webasset/rss/playstation/Games_PS3.rss"];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    //Parse XML
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    //Set Table
    [gamesTable setDelegate:self];
    [gamesTable setDataSource:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [gamesTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feed.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"game" forIndexPath:indexPath];
    cell.gameTitle.text = [[feed objectAtIndex:indexPath.row] objectForKey: @"title"];
    NSString *shortDescription = [[feed objectAtIndex:indexPath.row] objectForKey: @"description"];
    if (shortDescription.length > 135) {
        shortDescription = [shortDescription substringToIndex:130];
    }
    
    NSString *releaseDate = [[feed objectAtIndex:indexPath.row] objectForKey: @"launchDate"];
    releaseDate = [releaseDate substringWithRange:NSMakeRange(8, 8)];
    cell.gameLaunchDate.text = [NSString stringWithFormat:@"Published date: %@", releaseDate];
    cell.gameDescription.text = [[NSString stringWithFormat:@"%@...",shortDescription] capitalizedString];
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item = [[NSMutableDictionary alloc] init];
        title = [[NSMutableString alloc] init];
        link = [[NSMutableString alloc] init];
        description = [[NSMutableString alloc] init];
        launchDate  = [[NSMutableString alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        [item setObject:description forKey:@"description"];
        [item setObject:launchDate forKey:@"launchDate"];
        [feed addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    } else if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    } else if ([element isEqualToString:@"pubDate"]) {
        [launchDate appendString:string];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [gamesTable reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [gamesTable indexPathForSelectedRow];
        NSString *string = [feed[indexPath.row] objectForKey: @"link"];
        GameDetailsViewController *gameDetails = [segue destinationViewController];
        [gameDetails setUrl:string];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
