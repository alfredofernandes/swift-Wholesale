//
//  Wholesale.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Wholesale {
    
    private var stocks:[Stock]
    private var buyers:[Buyer]
    private var customers:[Customer]
    
    private var historyTransactions:[Transaction]
    
    private let alertOrderNotExist = "Your order doesn't exist, please create a new order!"
    
    init(stocks:[Stock], buyers:[Buyer], customers:[Customer]) {
        self.stocks = stocks
        self.buyers = buyers
        self.customers = customers
        
        self.historyTransactions = []
    }
    
    public func addStock(product: Product, quantity: Int, priceEach: Double) {
        
        let exist = self.checkProductStock(product)
        
        if exist == -1 {
            let stock = Stock(product: product, quantity: quantity, priceEach: priceEach)
            self.stocks.append(stock)
        }
    }
    
    public func addCustomer(_ customer:Customer) {
        if !self.checkCustomerExist(customer) {
            self.customers.append(customer)
        }
    }
    
    public func addBuyer(_ buyer:Buyer) {
        if !self.checkBuyerExist(buyer) {
            self.buyers.append(buyer)
        }
    }
    
    public func getStock() -> [Stock] {
        return self.stocks
    }
    
    public func getBuyers() -> [Buyer] {
        return self.buyers
    }
    
    public func getCustomers() -> [Customer] {
        return self.customers
    }
    
    public func getHistoryTransactions() -> [Transaction]{
        return self.historyTransactions
    }
    
    
    //MARK: ORDER PURCHASE
    
    public func orderPurchase(product: Product, quantity: Int) {
        
        for buyer in self.buyers {
            
            let price = buyer.checkProduct(product: product)
            if  price > 0.0 {
                
                let purchase = Purchase(buyer: buyer)
                purchase.generateOrder(product: product, quantity: quantity, priceEach: price)
                
                self.updateStock(product, quantity: quantity, increment: true)
                
                self.historyTransactions.append(purchase)
            }
        }
    }
    
    //MARK: ORDER SALE
    
    public func orderSale(customer:Customer) -> Int {

        self.addCustomer(customer)
        
        let sale = Sale(customer: customer)
        self.historyTransactions.append(sale)
        
        return sale.getOrderId()
    }
    
    public func addProductInOrderSale(product:Product, quantity:Int, orderNumber:Int) {
        let sale = self.getOrderSale(orderNumber)
        if sale != nil {
            
            let productInStock = self.getProductInStock(product)
            if productInStock != nil {
                
                if productInStock!.checkQuantity(quantity) {
                    
                    let price = productInStock!.getPriceEach()
                    let discount = self.generateDiscount(quantity)
                    
                    sale!.orderDetail(product: product, quantity: quantity, priceEach: price, discount: discount)
                    self.updateOrderSale(sale!)
                    
                    print("Product added successfully!")
                    
                } else {
                
                    print("Sorry! We don't have this quantity.")
                    self.orderPurchase(product: product, quantity: quantity)
                    self.addProductInOrderSale(product: product, quantity: quantity, orderNumber: orderNumber)
                }
                
            } else {
                print("Sorry! We don't have this product.")
            }
            
        } else {
             print(alertOrderNotExist)
        }
    }
    
    public func removeProductInOrderSale(product:Product, orderNumber:Int)  {
        let sale = self.getOrderSale(orderNumber)
        
        if sale != nil {
            
            if sale!.removeDetailByProduct(product) {
                print("Product removed successfully!")
                
            } else {
                print("Error! Please try again.")
            }
            
        } else {
            print(alertOrderNotExist)
        }
    }
    
    public func finishOrderSale(orderNumber:Int) {
        let sale = self.getOrderSale(orderNumber)
        
        if sale != nil {
            
            for detail in sale!.getDetails() {
                self.updateStock(detail.getProduct(), quantity: detail.getQuantity(), increment: false)
            }
            sale!.finishOrder()
            
        } else {
            print(alertOrderNotExist)
        }
    }
    
    public func payOrderSale(orderNumber:Int) {
        
        let sale = self.getOrderSale(orderNumber)
        
        if sale != nil {
            
            sale!.payOrder()
            self.updateOrderSale(sale!)
            print("Your order is paid!")
            
        } else {
            print(alertOrderNotExist)
        }
    }
    
    public func cancelOrderSale(orderNumber:Int) {
        
        let sale = self.getOrderSale(orderNumber)
        
        if sale != nil {
            
            sale!.setStatus(Transaction.StatusTransaction.Canceled)
            self.updateOrderSale(sale!)
            
        } else {
            print(alertOrderNotExist)
        }

    }
    
    
    // ORDER SALE IN HISTORY
    
    private func updateOrderSale(_ sale:Sale) {
        
        for position in 0..<self.historyTransactions.count {
            let history = self.historyTransactions[position]
            
            if let historySale = history as? Sale {
                
                if historySale.getOrderId() == sale.getOrderId() {
                    self.historyTransactions.remove(at: position)
                    self.historyTransactions.append(historySale)
                }
            }
        }
    }
    
    private func getOrderSale(_ numberOrder:Int) -> Sale? {
        for history in self.historyTransactions {
            
            if let historySale = history as? Sale {
                if historySale.getOrderId() == numberOrder {
                    return historySale
                }
            }
        }
        return nil
    }
    
    //MARK: BUYER
    
    private func checkBuyerExist(_ buyer:Buyer) -> Bool {
        for buy in self.buyers {
            if buy.getBuyerId() == buyer.getBuyerId() {
                return true
            }
        }
        return false
    }
    
    //MARK: CUSTOMER
    
    private func checkCustomerExist(_ customer:Customer) -> Bool {
        for cust in self.customers {
            if cust.getCustomerId() == customer.getCustomerId() {
                return true
            }
        }
        return false
    }
    
    //STOCK
    
    private func getProductInStock(_ product:Product) -> Stock? {
        let exist = checkProductStock(product)
        
        if exist != -1 {
            return self.stocks[exist]
        }
        return nil
    }
    
    private func updateStock(_ product:Product, quantity:Int, increment:Bool) {
        
        for stock in self.stocks {
            if stock.getProduct().getProductId() == product.getProductId() {
                if increment {
                    stock.addQuantity(quantity)
                } else {
                    stock.removeQuantity(quantity)
                }
            }
        }
    }
    
    private func checkProductStock(_ product:Product) -> Int {
        var position = -1
        
        for pos in 0..<self.stocks.count {
            let stock = self.stocks[pos]
            
            if stock.getProduct().getProductId() == product.getProductId() {
                position = pos
            }
        }
        return position
    }
    
    //GENERATE DISCOUNT
    
    private func generateDiscount(_ amount:Int) -> Double {
        if amount > 8  {
            return 10.0
            
        } else if amount > 6 {
            return 8.0
            
        } else if amount > 3 {
            return 5.0
            
        } else {
            return 0.0
        }
    }
}
