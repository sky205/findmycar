//
//  BorderView.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/15.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

@IBDesignable class BorderView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth;
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            self.layer.borderColor = borderColor.cgColor;
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.masksToBounds = false;
            self.layer.cornerRadius = cornerRadius;
        }
    }
    
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame);
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder);
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
