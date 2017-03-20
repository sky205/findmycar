//
//  VersionUpgrader.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/15.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import Foundation

@objc protocol VersionUpgraderDelegate {
    @objc optional func versionUpgrade(upgrader: VersionUpgrader, didFinish version: String);
}

class VersionUpgrader: NSObject {
    
    weak var delegate: VersionUpgraderDelegate?
    
    private var versionList = [
        "1_1"
    ];
    
    private var versionFunc = [
        "": ""
    ];
    
    var isFinishUpgrade: Bool = true;
    
    init(delegate: VersionUpgraderDelegate?) {
        super.init();
        self.delegate = delegate;
        self.createDBIfNeeded();
    }
    
    func startVersionUpgrade() {
        
    }
    
    private func createDBIfNeeded() {
        let manager = FileManager.default;
        let root = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
        let directory = root[0];
        let dbPath = directory.appending("/mycar.db");
        if !manager.fileExists(atPath: dbPath) {
            do {
                let copyPath = Bundle.main.path(forResource: "mycar", ofType: "db")!;
                try manager.copyItem(atPath: copyPath, toPath: dbPath);
            } catch {
                print("carete db file error");
            }
            
        }
    }
    
    private func finishedUpgrade(for version: String) {
        
    }
    
    private func getLastUpgradeVersion() -> String? {
        return nil;
    }
    
    
    func updateForVersion1_1() {
        
    }
    
    
    
    
    
    
    
}
