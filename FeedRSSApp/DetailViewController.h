//
//  DetailViewController.h
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Album;
@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
{
    Album *albumObject;
}
//@property (strong, nonatomic) Album *albumObject;

- (void)setAlbumObjectForController:(Album *)inAlbumObject;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
