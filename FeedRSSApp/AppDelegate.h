//
//  AppDelegate.h
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTTPProtocol;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray *listOfAlbums;
@property (strong,nonatomic) id <HTTPProtocol> httpRequestDelegate;
@property (assign) BOOL UIUpdated;
@end
