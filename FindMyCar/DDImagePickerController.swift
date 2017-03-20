//
//  DDImagePickerController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/10.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit
import Photos

class DDImagePickerController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedList: [Int] = [Int]();
    
    var result: PHFetchResult<PHAsset>?
    var manager: PHImageManager?;
    
    var fastOption: PHImageRequestOptions!
    var cells: [[CellData]] = [[CellData]]();
    
    var smallSize: CGSize!
    var targetSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cells.append([CellData]());
        
        self.smallSize = CGSize(width: 80, height: 80);
        self.targetSize = CGSize(width: 800, height: 800);
        self.initialCollection();
        
        let width = (self.view.frame.width-8)/3;
        let colSize = CGSize(width: width, height: width);
        self.initialCollection(size: colSize);
        self.collectionView.register(UINib(nibName: "ImagePickerCol", bundle: nil), forCellWithReuseIdentifier: "cell");
        
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.requestImagePermission();
    }
    
    func initialCollection(size: CGSize = CGSize(width: 80, height: 80)) {
        
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = size;
        layout.minimumLineSpacing = 2;
        layout.minimumInteritemSpacing = 2;
        
        self.collectionView.collectionViewLayout = layout;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
    }
    
    func requestImagePermission() {
        let status = PHPhotoLibrary.authorizationStatus();
        switch(status) {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ [unowned self] (status) in
                self.requestImagePermission();
            })
            
        case .denied:
            self.showMessage("Error!", message: "you didn't accept FindMyCar access your photo");
            
        default:
            self.createImageResult();
            self.readData();
        }
    }
    
    func createImageResult() {
        self.result = PHAsset.fetchAssets(with: .image, options: nil);
        self.manager = PHImageManager.default();
        self.fastOption = PHImageRequestOptions();
        self.fastOption.deliveryMode = .fastFormat;
        self.fastOption.isSynchronous = true;
        self.fastOption.resizeMode = .fast;
        
    }
    
    
    func readData() {
        if let count = self.result?.count {
            for _ in 0..<count {
                let data = ImagePickerColData(image: nil, delegate: self);
                let cellData = CellData(identifier: "cell", data: data);
                self.cells[0].append(cellData);
            }
        }
        self.showView();
    }
    
    func showView() {
        self.collectionView.reloadData();
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.cells.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells[section].count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.cells[indexPath.section][indexPath.row];
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellData.identifier, for: indexPath) as! BaseCol;
        cell.indexPath = indexPath;
        cell.setContent(cellData.data);
        
        if let data = cellData.data as? ImagePickerColData {
            if data.image == nil {
                let asset = self.result![indexPath.row];
                self.manager?.requestImage(for: asset, targetSize: self.smallSize, contentMode: PHImageContentMode.aspectFill, options: self.fastOption, resultHandler: { (image, info) in
                    data.image = image;
                    if cell.indexPath == indexPath {
                        cell.setContent(data);
                    }
                })
            }
        }
        
        return cell;
    }
    
    
    
}


extension DDImagePickerController: ImagePickerColDataDelegate {
    
    func imagePickerCol(_ index: IndexPath, checked: Bool) {
        (self.cells[index.section][index.row].data as? ImagePickerColData)?.checked = checked;
    }
    
}












