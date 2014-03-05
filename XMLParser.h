//
//  XMLParser.h
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterViewController.h"
#import "Album.h"



@interface XMLParser : NSObject <NSXMLParserDelegate>
{
    Album *theAlbum;
    NSMutableString *currentElementValue;
    //NSMutableArray *listOfAlbums;
    AppDelegate *app;
}

- (id)initParser;

@end
