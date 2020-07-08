//
//  PhotoMapViewController.m
//  PhotoMap
//
//  Created by emersonmalca on 7/8/18.
//  Copyright © 2018 Codepath. All rights reserved.
//

#import "PhotoMapViewController.h"
#import "LocationsViewController.h"
@interface PhotoMapViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate, MKMapViewDelegate>

@end

@implementation PhotoMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MKCoordinateRegion sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667), MKCoordinateSpanMake(0.1, 0.1));
    [self.mapView setRegion:sfRegion animated:false];
    self.mapView.delegate=self;
}
- (IBAction)didTapCamera:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"No Camera");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    self.selectedImage=editedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"tagSegue" sender:nil];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"tagSegue"])
    {
        LocationsViewController *locVC= (LocationsViewController *)segue.destinationViewController;
        locVC.delegate=self;
        NSLog(@"Here in segue");
    }
}

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber*)longitude{
    
    [self.navigationController popToViewController:self animated:YES];
    CLLocationCoordinate2D coord= CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
    
    //create a new pin
    MKPointAnnotation *annotation = [MKPointAnnotation new];
    annotation.coordinate = coord;
    annotation.title = @"Picture!";
    [self.mapView addAnnotation:annotation];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //get all the pins
    MKPinAnnotationView *annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    //drop a pin initally
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        annotationView.canShowCallout = true;
        annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
    }
    //add images to pin
    UIImageView *imageView = (UIImageView*)annotationView.leftCalloutAccessoryView;
    imageView.image = [UIImage imageNamed:@"camera"];

    return annotationView;
}

@end
