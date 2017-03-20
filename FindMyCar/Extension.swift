//
//  Extension.swift
//  FindMyCar
//
//  Created by DogSu on 2017/3/20.
//  Copyright © 2017年 DogSu. All rights reserved.
//

import Foundation


extension String {
    
    var data: Data? {
        return self.data(using: .utf8);
    }
    
    func replace(target: String, with: String) -> String {
       return self.replacingOccurrences(of: target, with: with);
    }

}

extension Data {
    var string: String? {
        return String(data: self, encoding: String.Encoding.utf8);
    }
}
