//
//  MKMapView+ZoomLevel.h
//  ios
//
//  Created by lololol on 9/Nov/14.
//  Copyright (c) 2014 Appendectomy Project. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end
