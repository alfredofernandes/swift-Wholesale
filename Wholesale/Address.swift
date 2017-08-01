//
//  Address.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Address {
    
    static var numID: Int = 0
    private var addressId: Int
    private var street: String
    private var city: String
    private var province: String
    private var zipCode: String
    private var country: String
    
    init(street: String, city: String, province: String, zipCode: String, country: String) {
        Address.numID += 1
        
        self.addressId = Address.numID
        self.street = street
        self.city = city
        self.province = province
        self.zipCode = zipCode
        self.country = country
    }
    
    public func getAddressId() -> Int {
        return self.addressId
    }
    
    public func getStreet() -> String {
        return self.street
    }
    
    public func setStreet(street: String) {
        self.street = street
    }

    public func getCity() -> String {
        return self.city
    }
    
    public func setCity(city: String) {
        self.city = city
    }
    
    public func getProvince() -> String {
        return self.province
    }
    
    public func setProvince(province: String) {
        self.province = province
    }

    public func getZipCode() -> String {
        return self.zipCode
    }
    
    public func setZipCode(zipCode: String) {
        self.zipCode = zipCode
    }
    
    public func getCountry() -> String {
        return self.country
    }
    
    public func setCountry(country: String) {
        self.country = country
    }
}
