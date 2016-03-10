//
//  CacheNB.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/8/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheNB : NSObject

+ (void) resetCache;

+ (void) setObject:(NSData*)data forKey:(NSString*)key;
+ (id) objectForKey:(NSString*)key;


@end
