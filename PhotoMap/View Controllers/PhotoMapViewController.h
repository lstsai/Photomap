//
//  PhotoMapViewController.h
//  PhotoMap
//
//  Created by emersonmalca on 7/8/18.
//  Copyright © 2018 Codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface PhotoMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (strong, nonatomic) UIImage *selectedImage;

@end
