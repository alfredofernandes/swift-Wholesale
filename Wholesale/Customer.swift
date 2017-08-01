//
//  Customer.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Customer {
    
    static var numID: Int = 0
    private var customerId: Int
    private var name: String
    private var address: Address
    private var active:Bool
    
    init(name: String, address: Address) {
        Customer.numID += 1
        
        self.customerId = Customer.numID
        self.name = name
        self.address = address
        self.active = true
    }
    
    public func getCustomerId() -> Int {
        return self.customerId
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
    
    public func setActive(_ bool:Bool) {
        self.active = bool
    }
    
    public func getActive() -> Bool {
        return self.active
    }
}
