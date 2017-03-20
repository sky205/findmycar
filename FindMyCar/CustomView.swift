//
//  CustomView.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/20.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

class CustomView: UIView {

    var nibName: String = "";
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.xibSetup();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder);
        
        self.xibSetup();
    }
    
    
    
    
    func xibSetup() {
        let view = self.loadView();
        view.frame = self.bounds;
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, .flexibleHeight];
        self.addSubview(view);
    }
    
    func loadView() -> UIView {
        let bundle = Bundle(for: self.classForCoder);
        let nib = UINib(nibName: self.nibName, bundle: bundle);
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView;
        return view;
    }
    

}
