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
    
    private var versionIdentify: String = "VersionUpgradeRecord";
    private var versionFunc: [String: Selector] = [String: Selector]();
    private var lastVersion: String?
    
    
    var isFinishUpgrade: Bool = true;
    
    init(delegate: VersionUpgraderDelegate?) {
        super.init();
        self.delegate = delegate;
        self.createDBIfNeeded();
    }
    
    func startVersionUpgrade() {
        if let version = self.lastVersion, let index = self.versionList.index(of: version), index < self.versionList.count-1,
           let selector = self.versionFunc[self.versionList[index+1]] {
            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: selector, userInfo: nil, repeats: false);
        }
    }
    
    private func createSelector() {
        let v1_1 = #selector(self.updateForVersion1_1);
        self.versionFunc["1_1"] = v1_1;
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
        var saveList: [String] = [String]();
        if let list = IPHONE.userDefault.array(forKey: self.versionIdentify) as? [String] {
            saveList = list;
        }
        saveList.append(version);
        IPHONE.userDefault.set(saveList, forKey: self.versionIdentify);
        IPHONE.userDefault.synchronize();
        self.lastVersion = version;
    }
    
    private func goLastUpgradeIfNeeded(version: String) {
        self.startVersionUpgrade();
    }
    
    private func getLastUpgradeVersion() -> String? {
        if let list = IPHONE.userDefault.array(forKey: self.versionIdentify) {
            return list.last as? String;
        }
        return nil;
    }
    
    
    func updateForVersion1_1() {
        
    }
    
    
    
    
    
    
    
}
