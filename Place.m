//
//  Place.m
//  NearByApp
//
//  Created by Rishikesh Pange on 09/03/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "Place.h"

@implementation Place

// Insert code here to add functionality to your managed object subclass

@end

@implementation Place_NSObject

@synthesize name;
@synthesize rating;
@synthesize imageUrl;
@synthesize address;
@synthesize placeType;
@synthesize location;

-(BOOL)isEqual:(id)object
{
    if (self.placeId == [(Place_NSObject*)object placeId])
    {
        return  true;
    }
    return  false;
}
@end