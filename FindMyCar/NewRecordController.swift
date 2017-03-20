//
//  NewRecordController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/15.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit
import MapKit


class NewRecordController: BaseViewController {
    
    
    var photoImage: UIImage?;
    var location: CLLocation?
    
    var locationManger: CLLocationManager?
    var isWaitForLocaiton = false;
    var isWaitForImage = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.locationManger = CLLocationManager();
        self.locationManger?.delegate = self;
        self.locationManger?.distanceFilter = 10;
        
        // Do any additional setup after loading the view.
    }

    
    func saveNewRecord() {
        if self.location == nil {
            self.isWaitForLocaiton = true;
            return;
        }
        
        
        
    }
    
}

extension NewRecordController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations[0];
    }
}


extension NewRecordController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { 
            self.goBack();
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.photoImage = image;
            self.saveNewRecord();
        }
    }
    
}

