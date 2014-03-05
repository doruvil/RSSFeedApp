//
//  XMLParser.m
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import "XMLParser.h"
#import "NSString+TrimLeadingSpaces.h"

@implementation XMLParser

- (id)initParser {
    if (self == [super init]) {
        app = [[UIApplication sharedApplication]delegate];
    }
    return self;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {
//    /[app setUIUpdated:FALSE];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"channel"]) {
        app.listOfAlbums = [[NSMutableArray alloc]init];
    } else if ([elementName isEqualToString:@"item"]) {
        theAlbum = [[Album alloc]init];
        theAlbum.linkURL = [attributeDict objectForKey:@"link"];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        [currentElementValue appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"channel"]) {
        return;
    }
    if ([elementName isEqualToString:@"item"]) {
        [app.listOfAlbums addObject:theAlbum];
        theAlbum = nil;
    } else {
        if (theAlbum) {
            if ([elementName isEqualToString:@"title"]) {
                [theAlbum setTitle:[[currentElementValue stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingLeadingWhitespace]];
            }
            if ([elementName isEqualToString:@"link"]) {
                [theAlbum setLinkURL:[[currentElementValue stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingLeadingWhitespace]];
            }
            if ([elementName isEqualToString:@"itms:artist"]) {
                [theAlbum setArtist:[[currentElementValue stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingLeadingWhitespace]];
            }
            if ([elementName isEqualToString:@"pubDate"]) {
                [theAlbum setPublicationDate:[[currentElementValue stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingLeadingWhitespace]];
            }
            if ([elementName isEqualToString:@"itms:coverArt"]) {
                [theAlbum setCoverArtLink:[[currentElementValue stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByTrimmingLeadingWhitespace]];
            }
        }
    }
    currentElementValue = nil;
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //NSLog(@"The amount from the list is: %d",[listOfAlbums count]);
    if (app.httpRequestDelegate) {
        [app.httpRequestDelegate updateUserInterfaceUsingArray:app.listOfAlbums];
        [app setUIUpdated:FALSE];
    }
}

@end
