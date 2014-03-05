//
//  HTTPService.h
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol HTTPProtocol;

@interface HTTPService : NSObject
{

}
@property(strong, nonatomic) NSMutableArray *listArray;
//@property (strong,nonatomic) id <HTTPProtocol> httpRequestResponseDelegate;

- (void)executeRequest;
@end
