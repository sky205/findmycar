//
//  HomeViewController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/15.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBAction func recordAction(_ sender: AnyObject) {
        let page = self.getController(NewRecordController.classForCoder()) as! NewRecordController;
        self.push(controller: page);
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var recordButton: UIButton!
    
    var versionUpgrader: VersionUpgrader!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.versionUpgrader = VersionUpgrader(delegate: self);
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if !self.versionUpgrader.isFinishUpgrade {
            self.showWaitingView(message: "版本更新中");
            self.versionUpgrader.startVersionUpgrade();
        }
    }


    
}

extension HomeViewController: VersionUpgraderDelegate {
    func versionUpgrade(upgrader: VersionUpgrader, didFinish version: String) {
        self.closeWaitingView();
        print("finish update version\(version)");
    }
}

