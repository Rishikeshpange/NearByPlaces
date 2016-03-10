//
//  Place.h
//  NearByApp
//
//  Created by Rishikesh Pange on 09/03/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Place : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Place+CoreDataProperties.h"


@interface Place_NSObject : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *rating;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *address;
@property(nonatomic,retain)NSString* placeType;
@property(nonatomic,retain)NSString* location;
@property(nonatomic,retain)NSString* placeId;
@end