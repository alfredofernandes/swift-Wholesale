//
//  Transaction.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Transaction {
    
    enum StatusTransaction {
        case Pending
        case Canceled
        case Closed
        case Delivered
    }
    
    enum TypeTransaction {
        case Purchase
        case Sale
    }
    
    static var numID: Int = 0
    private var orderId:Int
    private var orderDate:Date
    private var requiredDate:Date?
    private var shippedDate:Date?
    private var status:StatusTransaction
    private var payment:Bool
    private var discount:Double
    private var details:[DetailTransaction]
    private var type:TypeTransaction
    
    init(type:TypeTransaction) {
        Transaction.numID += 1
        
        self.orderId = Transaction.numID
        self.orderDate = Date()
        self.requiredDate = nil
        self.shippedDate = nil
        
        self.status = StatusTransaction.Pending
        self.type = type
        
        self.payment = false
        self.discount = 0.0
        self.details = []
    }
    
    public func getOrderId() -> Int {
        return self.orderId
    }
    
    public func getOrderDate() -> Date {
        return self.orderDate
    }
    
    public func setRequiredDate(_ date:Date) {
        self.requiredDate = date
    }
    
    public func getRequiredDate() -> Date {
        return self.requiredDate!
    }
    
    public func setShippedDate(_ date:Date) {
        self.shippedDate = date
    }
    
    public func getShippedDate() -> Date {
        return self.shippedDate!
    }
    
    public func setStatus(_ status:StatusTransaction) {
        self.status = status
    }
    
    public func getStatus() -> StatusTransaction {
        return self.status
    }
    
    public func setType(_ type:TypeTransaction) {
        self.type = type
    }
    
    public func getType() -> TypeTransaction {
        return self.type
    }
    
    public func setPayment(_ payment:Bool) {
        self.payment = payment
    }
    
    public func getPayment() -> Bool {
        return self.payment
    }
    
    public func getDetails() -> [DetailTransaction] {
        return self.details
    }
    
    public func addDetail(_ detail:DetailTransaction) {
        let exist = self.checkDetailExist(detail)
        
        if exist == -1 {
            self.details.append(detail)

        } else {
            if self.removeDetail(detail) {
                self.details.append(detail)
            }
        }
    }
    
    public func removeDetailByProduct(_ product:Product) -> Bool {
        let exist = self.checkDetailExistByProduct(product)
        
        if exist != -1 {
            self.details.remove(at: exist)
            return true
        }
        return false
    }
    
    public func removeDetail(_ detail:DetailTransaction) -> Bool {
        let exist = self.checkDetailExist(detail)
        
        if exist != -1 {
            self.details.remove(at: exist)
            return true
        }
        return false
    }
    
    public func checkDetailExist(_ detail:DetailTransaction) -> Int {
        var exist = -1
        
        for position in 0..<self.details.count {
            let det = self.details[position]
            
            if det.getDetailId() == detail.getDetailId() {
                exist = position
            }
        }
        return exist
    }
    
    public func checkDetailExistByProduct(_ product:Product) -> Int {
        var exist = -1
        
        for position in 0..<self.details.count {
            let det = self.details[position]
            
            if det.getProduct().getProductId() == product.getProductId() {
                exist = position
            }
        }
        return exist
    }
    
    public func totalPayment() -> Double {
        var total = 0.0
        
        for detail in details {
            let price = detail.totalPrice()
            total += price
        }
        return total
    }
    
    public func totalPaymentWithDiscount() -> Double {
        var total = 0.0
        
        for detail in details {
            let price = detail.totalPriceDiscount()
            total += price
        }
        return total
    }
    
    public func generateShippedDate() {
        self.shippedDate =  Calendar.current.date(byAdding: .day, value: 10, to: self.orderDate)!
    }
}
