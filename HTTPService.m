//
//  HTTPService.m
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import "HTTPService.h"
#import "XMLParser.h"

@interface HTTPService () {
    
    NSMutableData *_responseData;
    NSString *urlToCall;
}
@end

@implementation HTTPService
@synthesize listArray;

- (id)init
{
    self = [super init];
    if (self) {
        urlToCall = @"http://itunes.apple.com/WebObjects/MZStore.woa/wpa/MRSS/newreleases/limit=5/rss.xml";
        return self;
    }
    return nil;
}

- (void)executeRequest
{
    if (!urlToCall || [urlToCall length] == 0) {
        return;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlToCall]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:20];
    
    [request setHTTPMethod: @"GET"];
    NSURLConnection *urlObject = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(@"URL Object description: %@",urlObject.description);
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:_responseData];
    XMLParser *theXMLToModelParser = [[XMLParser alloc]initParser];
    //[theXMLToModelParser setHttpRequestDelegate:self.httpRequestResponseDelegate];
    [xmlParser setDelegate:theXMLToModelParser];
    
    BOOL isParsingSuccessful = [xmlParser parse];
    if (isParsingSuccessful) {
        NSLog(@"The parsing was succesfull! Amount:");
    } else {
        NSLog(@"The parse was NOT successfull");
    }

    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
