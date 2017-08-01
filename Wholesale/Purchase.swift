//
//  Purchase.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Purchase: Transaction {
    
    private var buyer:Buyer
    
    init(buyer:Buyer) {
        self.buyer = buyer
        super.init(type: TypeTransaction.Purchase)
    }
    
    public func setBuyer(_ buyer:Buyer) {
        self.buyer = buyer
    }
    
    public func getBuyer() -> Buyer {
        return self.buyer
    }
    
    public func generateOrder(product: Product, quantity: Int, priceEach: Double) {
        
        var exist = false
        for detail in self.getDetails() {
            
            if detail.getProduct().getProductId() == product.getProductId() {
                
                detail.setQuantity(quantity)
                detail.setPriceEach(priceEach)
                detail.setDiscount(0.0)
                
                self.addDetail(detail)
                exist = true
            }
        }
        
        if !exist {
            
            let detail = DetailTransaction(product: product, quantity: quantity, priceEach: priceEach, discount: 0.0)
            self.addDetail(detail)
        }
        
        self.finishOrder()
    }
    
    public func finishOrder() {
        self.generateShippedDate() // get orderDate and add 10 more days
        self.setStatus(Transaction.StatusTransaction.Delivered)
        self.setPayment(true)
    }
}
