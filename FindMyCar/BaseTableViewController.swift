//
//  BaseTableViewController.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/9.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var cells: [[CellData]] = [[CellData]]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    //MARK: UITableView Settings
    func initialSetting(rowHeight: CGFloat = 44) {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = rowHeight;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    
    
    
    //MARK: CELL MANAGEMENT FUNC
    
    func addSection() -> Int {
        self.cells.append([CellData]());
        return self.cells.count-1;
    }
    
    func addRowData(_ section: Int, cellData: CellData) -> Int {
        if self.cells.count > section {
            self.cells[section].append(cellData);
            return self.cells[section].count-1;
        } else {
            return -1;
        }
    }
    
    func getCellData(_ indexPath: IndexPath) -> CellData? {
        if self.cells.count > indexPath.section {
            if self.cells[indexPath.section].count > indexPath.row {
                return self.cells[indexPath.section][indexPath.row];
            }
        }
        return nil
    }
    
    func getCellData(_ section: Int, row: Int) -> CellData? {
        let index = IndexPath(row: row, section: section);
        return self.getCellData(index);
    }
    
    func requestImagePathForTableView(_ indexPath: IndexPath) -> String? {
        return nil;
    }
    
    func regiser(_ nibName: String, identify: String?, table: UITableView? = nil ) {
        let identifier = identify ?? nibName;
        let tableView = table ?? self.tableView;
        tableView?.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier);
    }
    
    
    //MARK: UITableViewDelegate & UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells[section].count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.getCellData(indexPath)!;
        let cell = tableView.dequeueReusableCell(withIdentifier: cellData.identifier, for: indexPath) as! BaseCell;
        cell.indexPath = indexPath;
        cell.setContent(cellData.data);
        if let imageUrl = self.requestImagePathForTableView(indexPath) {
            DDConnect(url: imageUrl).responseForImage(complete: { (image, error) in
                if let image = image {
                    self.delay(1, action: { 
                        if cell.indexPath == indexPath {
                            cell.setCellImage(image);
                        }
                    })
                }
            });
        }
        return cell;
    }
}



class ImageDictionary {
    
    private var paths: [String];
    private var images: [UIImage];
    var MAX_CACHE_NUMRIC: Int;
    
    var count: Int{
        return self.paths.count;
    }
    
    subscript (path: String) -> UIImage?{
        
        get{
            if let index = self.paths.index(of: path) {
                return self.images[index];
            } else {
                return nil;
            }
        }
        
        set(newValue) {
            if let image = newValue {
                if self.paths.count >= self.MAX_CACHE_NUMRIC {
                    self.paths.removeFirst();
                    self.images.removeFirst();
                }
                self.paths.append(path);
                self.images.append(image);
            }
        }
        
    }
    
    init(MAX_CACHE_NUMRIC: Int){
        self.MAX_CACHE_NUMRIC = MAX_CACHE_NUMRIC;
        self.paths = [String]();
        self.images = [UIImage]();
    }
    
    
}







