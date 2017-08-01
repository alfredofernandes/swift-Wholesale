//
//  Stock.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Stock {
    
    static var numID: Int = 0
    private var stockId: Int
    private var quantity: Int
    private var priceEach: Double
    private var product: Product
    
    init(product: Product, quantity: Int, priceEach: Double) {
        Stock.numID += 1
        
        self.stockId = Stock.numID
        self.quantity = quantity
        self.priceEach = priceEach
        self.product = product
    }
    
    public func getStockId() -> Int {
        return self.stockId
    }
    
    public func setQuantity(_ quantity: Int) {
        self.quantity = quantity
    }
    
    public func getQuantity() -> Int {
        return self.quantity
    }
    
    public func setPriceEach(_ priceEach: Double) {
        self.priceEach = priceEach
    }
    
    public func getPriceEach() -> Double {
        return self.priceEach
    }
    
    public func setProduct(_ product:Product) {
        self.product = product
    }
    
    public func getProduct() -> Product {
        return self.product
    }
    
    public func addQuantity(_ amount: Int) {
        self.quantity = quantity + amount
    }
    
    public func removeQuantity(_ amount: Int) {
        self.quantity = quantity - amount
    }
    
    public func checkQuantity(_ amount: Int) -> Bool {
        if (self.quantity - amount) > 0 {
            return true
        }
        return false
    }
}
