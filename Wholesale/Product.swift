//
//  Product.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Product {
    
    static var numID: Int = 0
    private var productId: Int
    private var name: String
    private var description: String
    private var category: Category
    
    init(name: String, description: String, category: Category) {
        Product.numID += 1
        
        self.productId = Product.numID
        self.name = name
        self.description = description
        self.category = category
    }
    
    public func getProductId() -> Int {
        return self.productId
    }
    
    public func setName(_ name: String) {
        self.name = name
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func setDescription(_ description: String) {
        self.description = description
    }
    
    public func getDescription() -> String {
        return self.description
    }
    
    public func setCategory(_ category: Category) {
        self.category = category
    }
    
    public func getCategory() -> Category {
        return self.category
    }
}
