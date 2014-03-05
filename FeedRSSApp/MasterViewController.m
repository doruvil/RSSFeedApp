//
//  MasterViewController.m
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "Album.h"

@interface MasterViewController () {
  
}

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    app = [[UIApplication sharedApplication]delegate];
    [super awakeFromNib];
}
- (void)updateUserInterfaceUsingArray:(NSMutableArray *)inResultArray {
    arrayOfAlbums = [inResultArray mutableCopy];
    [self.tableView reloadData];
    app.UIUpdated = TRUE;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [app setHttpRequestDelegate:self];
    if ([app.listOfAlbums count] != 0 && !app.UIUpdated) {
        [self updateUserInterfaceUsingArray:app.listOfAlbums];
    }
    
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayOfAlbums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Album *albumObject = [arrayOfAlbums objectAtIndex:indexPath.row];
    
    //NSLog(@"Album:  %@ \n",[albumObject title]);
    cell.textLabel.text = [albumObject title];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrayOfAlbums removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Album *albumObject = [arrayOfAlbums objectAtIndex:indexPath.row];
        [self.detailViewController setAlbumObjectForController:albumObject];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Album *albumObject = [arrayOfAlbums objectAtIndex:indexPath.row];
        [[segue destinationViewController] setAlbumObjectForController:albumObject];
    }
}

@end
