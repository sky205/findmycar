//
//  ImagePickerCol.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/10.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

@objc protocol ImagePickerColDataDelegate {
    @objc optional func imagePickerCol(_ index: IndexPath, checked: Bool);
}

class ImagePickerCol: BaseCol {
    
    @IBAction func checkAction(_ sender: AnyObject) {
        self.checkView.isHidden = !self.checkView.isHidden;
        self.delegate?.imagePickerCol?(self.indexPath, checked: !self.checkView.isHidden);
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkView: UIView!
    
    weak var delegate: ImagePickerColDataDelegate?
    
    override func setContent(_ info: Any) {
        if let data = info as? ImagePickerColData {
            self.imageView.image = data.image;
            self.checkView.isHidden = !data.checked;
            self.delegate = data.delegate;
        }
    }
    
}

class ImagePickerColData {
    
    var image: UIImage?;
    var checked: Bool = false;
    weak var delegate: ImagePickerColDataDelegate?
    
    init(image: UIImage?, delegate: ImagePickerColDataDelegate?, checked: Bool = false) {
        self.image = image;
        self.checked = checked;
    }
    
}
