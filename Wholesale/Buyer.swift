//
//  Buyer.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Buyer {
    
    static var numID: Int = 0
    private var buyerId: Int
    private var name: String
    private var address: Address
    private var products: [[String:AnyObject]]
    private var active:Bool
    
    init(name: String, address: Address, products:[[String:AnyObject]]) {
        Buyer.numID += 1
        
        self.buyerId = Buyer.numID
        self.name = name
        self.address = address
        self.products = products
        self.active = true
    }
    
    public func getBuyerId() -> Int {
        return self.buyerId
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func setName(name: String) {
        self.name = name
    }
    
    public func getAddress() -> Address {
        return self.address
    }
    
    public func setAddress(address: Address) {
        self.address = address
    }
    
    public func checkProduct(product: Product) -> Double {
        for dictionary in self.products {
            let prod = dictionary["product"] as! Product
            let price = dictionary["price"] as! Double
            
            if prod.getProductId() == product.getProductId() {
                return price
            }
        }
        return 0.0
    }
    
    public func setActive(_ bool:Bool) {
        self.active = bool
    }
    
    public func getActive() -> Bool {
        return self.active
    }
}
