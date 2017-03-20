//
//  WaitingViewController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/15.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    var message: String = "";
    var executeNumric: Int = 0;
    var timer: Timer?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func startShowMessage() {
        let selector = #selector(self.setMessageString)
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: selector, userInfo: nil, repeats: true);
    }
    
    func setMessageString() {
        var showString = self.message;
        for _ in 0..<executeNumric {
            showString += ".";
        }
        self.textLabel.text = showString;
        self.executeNumric = self.executeNumric >= 3 ? 0 : self.executeNumric+1;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.timer?.invalidate();
        self.timer = nil;
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
