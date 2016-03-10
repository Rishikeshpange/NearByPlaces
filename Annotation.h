//
//  Annotation.h
//  NearByApp
//
//  Created by Rishikesh Pange on 3/7/16.
//  Copyright © 2016 TTL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;
@end