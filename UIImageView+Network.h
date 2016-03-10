//
//  UIImage+Network.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/8/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView(Network)

@property (nonatomic, copy) NSURL *imageURL;

- (void) loadImageFromURL:(NSURL*)url placeholderImage:(UIImage*)placeholder cachingKey:(NSString*)key;

@end
