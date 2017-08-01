//
//  Category.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Category {
    
    static var numID: Int = 0
    private var name: String
    private var categoryId: Int
    
    init(name:String) {
        Category.numID += 1
        
        self.categoryId = Category.numID
        self.name = name
    }
    
    public func getCategoryId() -> Int {
        return self.categoryId
    }
    
    public func getName() -> String {
        return self.name
    }

    public func setName(_ name:String) {
        self.name = name
    }
}
