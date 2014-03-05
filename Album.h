//
//  Album.h
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject
{

}
@property (strong, nonatomic) NSString *linkURL;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSString *publicationDate;
@property (strong, nonatomic) NSString *coverArtLink;

@end
