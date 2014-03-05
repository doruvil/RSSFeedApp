//
//  DetailViewController.m
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import "DetailViewController.h"
#import "Album.h"
#import "ImageCache.h"
#import "AsyncImageDownloader.h"

@interface DetailViewController ()
{

}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLinkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverArtImageView;
- (void)configureView;
- (IBAction)backButtonAction:(id)sender;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void)setAlbumObjectForController:(Album *)inAlbumObject {
    albumObject = inAlbumObject;
    [self configureView];
}

- (void)configureView
{
    if (albumObject) {
        
        // Update the user interface for the album details
        
        [self.titleLabel setText:[albumObject title]];
        [self.artistNameLabel setText:[albumObject artist]];
        //Convert / Format publication date from XML full date format to dd/MM/yyyy
        [self.pubDateLabel setText:[self convertDateFromFullDateFormat:[albumObject publicationDate]]];
        [self.urlLinkLabel setText:[albumObject linkURL]];
        
        if ([[ImageCache sharedImageCache]doesExist:[albumObject coverArtLink]] == true) {
            [self.coverArtImageView setImage:[[ImageCache sharedImageCache] getImage:[albumObject coverArtLink]]];
        }
        else {
            [self.coverArtImageView setImage:[UIImage imageNamed:@"default_icon.png"]]; // >>> DEFAULT PNG
            [[[AsyncImageDownloader alloc] initWithMediaURL:[albumObject coverArtLink] successBlock:^(UIImage *image)  {
                [self.coverArtImageView setImage:image];
                [[ImageCache sharedImageCache]addImage:image forURL:[albumObject coverArtLink]];
                
            } failBlock:^(NSError *error) {
                //NSLog(@"Failed to download image due to %@!", error);
            }] startDownload];
        }
    } else {
        [self.titleLabel setText:@""];
        [self.artistNameLabel setText:@""];
        [self.pubDateLabel setText:@""];
        [self.urlLinkLabel setText:@""];
    }
}

- (IBAction)backButtonAction:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)convertDateFromFullDateFormat:(NSString *)inDate
{
    
    NSString *dayMonthYear = [inDate substringWithRange:NSMakeRange(5, 11)];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
     [dateFormatter1 setDateFormat:@"dd MMM yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter1 dateFromString:dayMonthYear];
    
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"dd/MM/yyyy"];
    NSString *strDate = [dateFormatter2 stringFromDate:dateFromString];
    return strDate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
