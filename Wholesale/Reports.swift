//
//  Reports.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class Reports {
    
    private var wholesale:Wholesale
    private let dateFormatter = DateFormatter()
    
    init(wholesale:Wholesale) {
        self.wholesale = wholesale
        dateFormatter.dateFormat = "dd-MM-yyyy"
    }
    
    
    //MARK: REPORTS
    
    public func reportProductsDeliveryInYear(_ year:String) {
        
        var tableResult:[[String: AnyObject]] = []
        let historyTransactions = self.wholesale.getHistoryTransactions()
        
        for history in historyTransactions {
            if let historySale = history as? Sale {
                
                let shippedDate = dateFormatter.string(from: historySale.getShippedDate())
                let orderId = historySale.getOrderId()
                
                let yearFormatter = DateFormatter()
                yearFormatter.dateFormat = "yyyy"
                
                let yearShippedDate = yearFormatter.string(from: historySale.getShippedDate())
                
                if (historySale.getStatus() == Transaction.StatusTransaction.Delivered) && (yearShippedDate >= year) {
                    
                    for detail in historySale.getDetails() {
                        
                        let product = detail.getProduct()
                        let productName = product.getName()
                        
                        let item:[String : AnyObject] = ["1_orderId": orderId as AnyObject,
                                                         "2_shippedDate": shippedDate as AnyObject,
                                                         "3_productName": productName as AnyObject]
                        
                        tableResult.append(item)
                    }
                }
            }
        }
        
        let sortedArray = tableResult.sorted{ ($0["1_orderId"] as? Int)! < ($1["1_orderId"] as? Int)! }
        let result = PrintHeader.createTable(columns: ["ORDER_ID", "PRODUCT_NAME", "SHIPPED_DATE"], rows: sortedArray, size: 23)
        
        print(result)
    }
    
    public func reportSaleListOfCustomersPendingAmount() {
        
        var tableResult:[[String: AnyObject]] = []
        var total = 0
        
        let customers = self.wholesale.getCustomers()
        let historyTransactions = self.wholesale.getHistoryTransactions()
        
        for cust in customers {
            let customerName = cust.getName()
            var totalCustomer = 0.0
            
            for history in historyTransactions {
                
                if let historySale = history as? Sale {
                    
                    if (historySale.getStatus() == Transaction.StatusTransaction.Closed) && (historySale.getPayment() == false) {
                        
                        let customer = historySale.getCustomer()
                        
                        if (cust.getCustomerId() == customer.getCustomerId()) {
                            totalCustomer += historySale.totalPayment()
                        }
                        total += 1
                    }
                }
            }
            
            if (totalCustomer > 0) {
                let customerId = String(cust.getCustomerId())
                
                let item:[String : AnyObject] = ["1_customerId": customerId as AnyObject,
                                                 "2_customerName": customerName as AnyObject,
                                                 "3_totalPending": totalCustomer as AnyObject]
                
                tableResult.append(item)
            }
        }
        
        if total > 0 {
            
            let sortedArray = tableResult.sorted(by: { ($0["3_totalPending"] as? Double)! < ($1["3_totalPending"] as? Double)! })
            let result = PrintHeader.createTable(columns: ["CUSTOMER_ID", "CUSTOMER_NAME", "TOTAL_PENDING"], rows: sortedArray, size: 15)
            print(result)
            
        } else {
            print("All payments are paid!")
        }
    }
    
    
    public func reportSaleListOfCustomersQuantityTotalAmountPaid() {
        
        var tableResult:[[String: AnyObject]] = []
        var total = 0
        
        let customers = self.wholesale.getCustomers()
        let historyTransactions = self.wholesale.getHistoryTransactions()
        
        for cust in customers {
            let customerName = cust.getName()
            var customerOrderQty = 0
            var customerTotalAmount = 0.0
            
            for history in historyTransactions {
                
                if let historySale = history as? Sale {
                    
                    if (historySale.getPayment() == true) {
                        
                        let customer = historySale.getCustomer()
                        
                        if (cust.getCustomerId() == customer.getCustomerId()) {
                            customerOrderQty += 1
                            customerTotalAmount += historySale.totalPayment()
                        }
                        total += 1
                    }
                }
            }
            
            if (customerTotalAmount > 0) {
                let customerId = String(cust.getCustomerId())
                let orderQty = String(customerOrderQty)
                
                let item:[String : AnyObject] = ["1_customerId": customerId as AnyObject,
                                                 "2_customerName": customerName as AnyObject,
                                                 "3_orderQty": orderQty as AnyObject,
                                                 "4_totalAmount": customerTotalAmount as AnyObject]
                
                tableResult.append(item)
            }
        }
        
        if total > 0 {
            
            let sortedArray = tableResult.sorted(by: { ($0["4_totalAmount"] as? Double)! < ($1["4_totalAmount"] as? Double)! })
            let result = PrintHeader.createTable(columns: ["CUSTOMER_ID", "CUSTOMER_NAME", "ORDER_QUANTITY", "TOTAL_AMOUNT"], rows: sortedArray, size: 15)
            print(result)
            
        } else {
            print("No orders with payments!\n\n")
        }
    }
    
    public func reportProductQuantityInStock() {
        
        var tableResult:[[String: AnyObject]] = []
        
        let stocks = self.wholesale.getStock()
        
        for stock in stocks {
            let product = stock.getProduct()
            let quantity = stock.getQuantity()
            let productId = String(product.getProductId())
            let productName = product.getName()
            
            
            let item:[String : AnyObject] = ["1_productId": productId as AnyObject,
                                             "2_productName": productName as AnyObject,
                                             "3_quantity": quantity as AnyObject]
            
            tableResult.append(item)
        }
        
        let sortedArray = tableResult.sorted(by: { ($0["3_quantity"] as? Int)! > ($1["3_quantity"] as? Int)! })
        let result = PrintHeader.createTable(columns: ["PRODUCT_ID", "PRODUCT_NAME", "QUANTITY"], rows: sortedArray, size: 20)
        
        print(result)
    }
    
    public func reportListSalePaidAndNot() {
        
        var tableResult:[[String: AnyObject]] = []
        let historyTransactions = self.wholesale.getHistoryTransactions()
        
        for history in historyTransactions {
            
            if let historySale = history as? Sale {
                
                let orderId = String(historySale.getOrderId())
                
                let customer = historySale.getCustomer()
                let customerName = customer.getName()
                
                let amount = historySale.totalPayment()
                let payment = historySale.getPayment() ? "PAID" : "NOT PAID"
                
                let item:[String : AnyObject] = ["1_orderId": orderId as AnyObject,
                                                 "2_customerName": customerName as AnyObject,
                                                 "3_amount": amount as AnyObject,
                                                 "4_payment": payment as AnyObject]
                
                tableResult.append(item)
            }
        }
        
        let sortedArray = tableResult.sorted(by: { ($0["3_amount"] as? Double)! > ($1["3_amount"] as? Double)! })
        let result = PrintHeader.createTable(columns: ["ORDER_ID", "CUSTOMER_NAME", "TOTAL_AMOUNT", "PAYMENT"], rows: sortedArray, size: 20)
        print(result)
    }
    
    public func reportSalesByCities() {
        
        var tableResult:[[String: AnyObject]] = []
        let cities = ["Toronto", "Quebec", "Vancouver", "Halifax", "Winnipeg"]
        let historyTransactions = self.wholesale.getHistoryTransactions()

        for city in cities {
            let cityName = city
            var totalPayment = 0.0
            
            for history in historyTransactions {
                
                if let historySale = history as? Sale {
                    
                    let customer = historySale.getCustomer()
                    
                    let address = customer.getAddress()
                    let addressCity = address.getCity()
                    
                    if cityName == addressCity {
                        totalPayment += historySale.totalPayment()
                    }
                }
            }
            
            let item:[String : AnyObject] = ["1_city": cityName as AnyObject,
                                             "2_amount": totalPayment as AnyObject]
            
            tableResult.append(item)
        }
        
        let sortedArray = tableResult.sorted(by: { ($0["2_amount"] as? Double)! > ($1["2_amount"] as? Double)! })
        let result = PrintHeader.createTable(columns: ["CITY", "TOTAL_AMOUNT"], rows: sortedArray, size: 20)
        
        print(result)
    }
}
