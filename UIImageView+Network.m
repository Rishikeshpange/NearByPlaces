//
//  UIImageView+Network.m
//  NearByApp
//
//  Created by Rishikesh Pange on 3/8/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "UIImageView+Network.h"
#import "CacheNB.h"
#import <objc/runtime.h>

static char URL_KEY;


@implementation UIImageView(Network)

@dynamic imageURL;

- (void) loadImageFromURL:(NSURL*)url placeholderImage:(UIImage*)placeholder cachingKey:(NSString*)key {
	self.imageURL = url;
	self.image = placeholder;
	
	NSData *cachedData = [CacheNB objectForKey:key];
	if (cachedData) {   
 	   self.imageURL   = nil;
 	   self.image      = [UIImage imageWithData:cachedData];
	   return;
	}

	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
	dispatch_async(queue, ^{
		NSData *data = [NSData dataWithContentsOfURL:url];
		
		UIImage *imageFromData = [UIImage imageWithData:data];
		
		[CacheNB setObject:data forKey:key];

		if (imageFromData) {
			if ([self.imageURL.absoluteString isEqualToString:url.absoluteString]) {
				dispatch_sync(dispatch_get_main_queue(), ^{
					self.image = imageFromData;
				});
			} else {

			}
		}
		self.imageURL = nil;
	});
}

- (void) setImageURL:(NSURL *)newImageURL {
	objc_setAssociatedObject(self, &URL_KEY, newImageURL, OBJC_ASSOCIATION_COPY);
}

- (NSURL*) imageURL {
	return objc_getAssociatedObject(self, &URL_KEY);
}

@end
