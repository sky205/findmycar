//
//  BaseCell.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/9.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {
    
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContent(_ data: Any) {
        
    }
    
    func setCellImage(_ image: UIImage) {
        
    }
    

}


class CellData {
    
    var identifier: String;
    var data: Any;
    
    init(identifier: String, data: Any) {
        self.identifier = identifier;
        self.data = data;
    }
    
}
