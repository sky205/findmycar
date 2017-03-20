//
//  BaseCollectionViewController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/20.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

class BaseCollectionViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var cacheImages: ImageDictionary = ImageDictionary(MAX_CACHE_NUMRIC: 100);
    var cells: [[CellData]] = [[CellData]]();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.cells.count;
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cells[section].count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = self.getCellData(at: indexPath)!;
        let col = collectionView.dequeueReusableCell(withReuseIdentifier: cellData.identifier, for: indexPath) as! BaseCol;
        col.indexPath = indexPath;
        col.setContent(cellData.data);
        
        self.requireImageOfCell(index: indexPath) { (response) in
            switch response {
            case let image as UIImage:
                col.setCellImage(image);
                
            case let string as String:
                DDConnect(url: string).responseForImage(complete: { [unowned self] (image, error) in
                    if let image = image {
                        self.cacheImages[string] = image;
                        self.delay(1, action: { 
                            if col.indexPath == indexPath {
                                col.setCellImage(image);
                            }
                        })
                    }
                });
                
            default:
                break;
            }
        }
        
        return col;
    }
    
    func requireImageOfCell(index: IndexPath, complete: (Any?) -> Void) {
        complete(nil);
    }
    
    
}

//MARK: cell managemnet
extension BaseCollectionViewController {
    
    @discardableResult func addSection() -> Int {
        self.cells.append([CellData]());
        return self.cells.count-1;
    }
    
    func addRowDataOfSection(_ section: Int, data: CellData) {
        self.cells[section].append(data);
    }
    
    func getCellData(at index: IndexPath) -> CellData? {
        if self.cells.count > index.section {
            if self.cells[index.section].count > index.row {
                return self.cells[index.section][index.row];
            }
        }
        return nil;
    }
    
    
}


