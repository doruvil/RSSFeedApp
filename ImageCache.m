#import "ImageCache.h"

@implementation ImageCache

@synthesize imgCache;

#pragma mark - Methods

static ImageCache *sharedImageCache = nil;

+ (ImageCache *)sharedImageCache
{
    @synchronized([ImageCache class])
    {
        if (!sharedImageCache)
            sharedImageCache= [[self alloc] init];
        
        return sharedImageCache;
    }
    
    return nil;
}

+ (id)alloc
{
    @synchronized([ImageCache class])
    {
        NSAssert(sharedImageCache == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedImageCache = [super alloc];
        
        return sharedImageCache;
    }
    
    return nil;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        imgCache = [[NSCache alloc] init];
    }
    
    return self;
}

- (void)addImage:(UIImage *)image forURL:(NSString *)imageURL
{
    [imgCache setObject:image forKey:imageURL];
}

- (UIImage *)getImage:(NSString *)imageURL
{
    return [imgCache objectForKey:imageURL];
}

- (BOOL)doesExist:(NSString *)imageURL
{
    if ([imgCache objectForKey:imageURL] == nil)
    {
        return false;
    }
    return true;
}
@end