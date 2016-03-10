//
//  Annotation.m
//  NearByApp
//
//  Created by Rishikesh Pange on 3/7/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
@synthesize coordinate;

- (NSString *)subtitle{
    return nil;
}

- (NSString *)title{
    return nil;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    return self;
}

@end
