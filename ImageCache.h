//
//  ImageCache.h
//  LinkedTranlators
//
//  Created by Lion User on 07/10/2013.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCache : NSObject

@property (nonatomic, retain) NSCache *imgCache;


#pragma mark - Methods

+ (ImageCache *)sharedImageCache;
//- (UIImage*) GetImage:(NSString *)imageURL;
//- (BOOL) DoesExist:(NSString *)imageURL;



- (void)addImage:(UIImage *)image forURL:(NSString *)imageURL;
- (UIImage *)getImage:(NSString *)imageURL;
- (BOOL)doesExist:(NSString *)imageURL;
@end