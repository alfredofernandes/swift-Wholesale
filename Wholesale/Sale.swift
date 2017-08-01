//
//  Sale.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Sale: Transaction {
    
    private var customer:Customer
    
    init(customer:Customer) {
        self.customer = customer
        super.init(type: TypeTransaction.Sale)
    }
    
    public func setCustomer(_ customer:Customer) {
        self.customer = customer
    }
    
    public func getCustomer() -> Customer {
        return self.customer
    }
    
    public func orderDetail(product: Product, quantity: Int, priceEach: Double, discount: Double) {
        
        var exist = false
        for detail in self.getDetails() {
            
            if detail.getProduct().getProductId() == product.getProductId() {
                
                detail.setQuantity(quantity)
                detail.setPriceEach(priceEach)
                detail.setDiscount(discount)
                
                self.addDetail(detail)
                exist = true
            }
        }
        
        if !exist {
            
            let detail = DetailTransaction(product: product, quantity: quantity, priceEach: priceEach, discount: discount)
            
            self.addDetail(detail)
        }
    }
    
    public func finishOrder() {
        self.generateShippedDate() // get orderDate and add 10 more days
        self.setStatus(Transaction.StatusTransaction.Closed)
        
        print("Total without discounts: $\(totalPayment()) \nTotal with discounts: $\(totalPaymentWithDiscount()) \nYou save: $\(totalPayment() - totalPaymentWithDiscount())")
    }
    
    public func payOrder() {
        self.setPayment(true)
        self.setStatus(Transaction.StatusTransaction.Delivered)
    }
}
