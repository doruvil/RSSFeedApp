//
//  NSString+NSString_TrimLeadingSpaces.m
//  FeedRSSApp
//
//  Created by HQDevelopers on 12/13/13.
//  Copyright (c) 2013 HQDevelopers. All rights reserved.
//

#import "NSString+TrimLeadingSpaces.h"

@implementation NSString (TrimLeadingSpaces)
- (NSString *)stringByTrimmingLeadingWhitespace {
    
    NSInteger i = 0;
    while ((i < [self length])
           && [[NSCharacterSet whitespaceCharacterSet] characterIsMember:[self characterAtIndex:i]]) {
        i++;
    }
    return [self substringFromIndex:i];
}

@end
