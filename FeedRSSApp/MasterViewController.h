//
//  MasterViewController.h
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPProtocol.h"
#import "AppDelegate.h"

@class DetailViewController;
//@protocol HTTPProtocol;


@interface MasterViewController : UITableViewController <HTTPProtocol,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *arrayOfAlbums;
    AppDelegate *app;
    
}
@property (strong, nonatomic) DetailViewController *detailViewController;

@end
