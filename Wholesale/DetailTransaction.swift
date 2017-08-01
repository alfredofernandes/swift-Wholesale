//
//  DetailTransaction.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class DetailTransaction {
    
    static var numID:Int = 0
    private var detailId:Int
    private var product:Product
    private var quantity:Int
    private var priceEach:Double
    private var discount:Double
    
    init(product:Product, quantity:Int, priceEach:Double, discount:Double) {
        DetailTransaction.numID += 1
        
        self.detailId = DetailTransaction.numID
        self.product = product
        self.priceEach = priceEach
        self.discount = discount
        self.quantity = quantity
    }
    
    public func getDetailId() -> Int {
        return self.detailId
    }
    
    public func setProduct(_ product:Product) {
        self.product = product
    }
    
    public func getProduct() -> Product {
        return self.product
    }
    
    public func setPriceEach(_ price:Double) {
        self.priceEach = price
    }
    
    public func getPriceEach() -> Double {
        return self.priceEach
    }
    
    public func setDiscount(_ discount:Double) {
        self.discount = discount
    }
    
    public func getDiscount() -> Double {
        return self.discount
    }
    
    public func setQuantity(_ amount:Int) {
        self.quantity = amount
    }
    
    public func getQuantity() -> Int {
        return self.quantity
    }
    
    public func totalPrice() -> Double {
        
        let quantity = Double(self.quantity)
        return (self.priceEach * quantity)
    }
    
    public func totalPriceDiscount() -> Double {
        
        let quantity = Double(self.quantity)
        let discount = (100-self.discount)/100
        
        let priceWithDiscount = (self.priceEach * quantity)*discount
        
        return priceWithDiscount
    }
}
