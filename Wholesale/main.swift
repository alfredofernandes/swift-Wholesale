//
//  main.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

//-----------------------------------
// CREATE CATEGORIES
//-----------------------------------

var category1 = Category(name: "Desktop")
var category2 = Category(name: "Laptop")
var category3 = Category(name: "Accessories")
var category4 = Category(name: "Smartphone")
var category5 = Category(name: "Softwares")

//-----------------------------------
// CREATE PRODUCTS
//-----------------------------------

var product1 = Product(name: "iMac 21.5-inch", description: "Retina 4K", category: category1)
var product2 = Product(name: "iMac 27-inch", description: "Retina 5K", category: category1)
var product3 = Product(name: "Macbook Pro 13-inch", description: "Non-retina", category: category2)
var product4 = Product(name: "Macbook Pro 15-inch", description: "Retina with touch bar", category: category2)
var product5 = Product(name: "Mouse", description: "Apple Magic Mouse 2", category: category3)
var product6 = Product(name: "Keyboard", description: "Apple Wireless Keyboard", category: category3)
var product7 = Product(name: "iPhone 6s", description: "Space Gray 32GB", category: category4)
var product8 = Product(name: "iPhone 7", description: "Jet Black 128GB", category: category4)
var product9 = Product(name: "iWork", description: "Pages, Numbers, Keynote", category: category5)
var product10 = Product(name: "iLife", description: "iMovie, iPhoto, GarageBand", category: category5)

//-----------------------------------
// CREATE STOCK
//-----------------------------------

var stock1 = Stock(product: product1, quantity: 10, priceEach: 200.00)
var stock2 = Stock(product: product2, quantity: 20, priceEach: 300.00)
var stock3 = Stock(product: product3, quantity: 30, priceEach: 400.00)
var stock4 = Stock(product: product4, quantity: 40, priceEach: 500.00)
var stock5 = Stock(product: product5, quantity: 50, priceEach: 600.00)
var stock6 = Stock(product: product6, quantity: 60, priceEach: 700.00)
var stock7 = Stock(product: product7, quantity: 70, priceEach: 800.00)
var stock8 = Stock(product: product8, quantity: 80, priceEach: 900.00)
var stock9 = Stock(product: product9, quantity: 90, priceEach: 1000.00)
var stock10 = Stock(product: product10, quantity: 99, priceEach: 1100.00)

//-----------------------------------
// CREATE ADDRESS
//-----------------------------------

var address1 = Address(street: "12 Deerford Rd", city: "Toronto", province: "ON", zipCode: "M2J 3J3", country: "Canada")
var address2 = Address(street: "35 County Ave", city: "Quebec", province: "QC", zipCode: "G2Y G6P", country: "Canada")
var address3 = Address(street: "52 Loger St", city: "Vancouver", province: "BC", zipCode: "J8W L0A", country: "Canada")
var address4 = Address(street: "11 Godstone Ave", city: "Halifax", province: "NS", zipCode: "H6G N1Z", country: "Canada")
var address5 = Address(street: "94 Somewhere Far Rd", city: "Winnipeg", province: "MB", zipCode: "W1W T7T", country: "Canada")

//-----------------------------------
// CREATE BUYERS
//-----------------------------------

var buyer1 = Buyer(name: "Corey", address: address1, products: [["product": product1, "price":100.00 as AnyObject], ["product": product2, "price": 200.00 as AnyObject]])
var buyer2 = Buyer(name: "Joeey", address: address2, products: [["product": product3, "price":300.00 as AnyObject], ["product": product4, "price": 400.00 as AnyObject]])
var buyer3 = Buyer(name: "Shawn", address: address3, products: [["product": product5, "price":500.00 as AnyObject], ["product": product6, "price": 600.00 as AnyObject]])
var buyer4 = Buyer(name: "Michi", address: address4, products: [["product": product7, "price":700.00 as AnyObject], ["product": product8, "price": 800.00 as AnyObject]])
var buyer5 = Buyer(name: "Jimmy", address: address5, products: [["product": product9, "price":900.00 as AnyObject], ["product": product1, "price": 120.00 as AnyObject]])

//-----------------------------------
// CREATE CUSTOMERS
//-----------------------------------

var customer1 = Customer(name: "Juliana", address: address1)
var customer2 = Customer(name: "Alfredo", address: address2)
var customer3 = Customer(name: "Guilherme", address: address3)
var customer4 = Customer(name: "Koustub", address: address4)
var customer5 = Customer(name: "Louise", address: address5)

//-----------------------------------
// CREATE STORE
//-----------------------------------

var wholesale = Wholesale(stocks: [stock1, stock2, stock3, stock4, stock5, stock6, stock7, stock8, stock9, stock10],
                          buyers: [buyer1, buyer2, buyer3, buyer4, buyer5],
                          customers: [customer1, customer2, customer3, customer4, customer5])

//-----------------------------------
// SALE ORDER
//-----------------------------------

print("--------- ORDER SALE 1 --------- ")
var saleOrder1 = wholesale.orderSale(customer: customer1)
wholesale.addProductInOrderSale(product: product1, quantity: 5, orderNumber: saleOrder1)
wholesale.finishOrderSale(orderNumber: saleOrder1)

print("\n--------- ORDER SALE 2 --------- ")
var saleOrder2 = wholesale.orderSale(customer: customer2)
wholesale.addProductInOrderSale(product: product2, quantity: 6, orderNumber: saleOrder2)
wholesale.addProductInOrderSale(product: product3, quantity: 8, orderNumber: saleOrder2)
wholesale.finishOrderSale(orderNumber: saleOrder2)
wholesale.payOrderSale(orderNumber: saleOrder2)

print("\n--------- ORDER SALE 3 --------- ")
var saleOrder3 = wholesale.orderSale(customer: customer3)
wholesale.addProductInOrderSale(product: product2, quantity: 7, orderNumber: saleOrder3)
wholesale.addProductInOrderSale(product: product3, quantity: 3, orderNumber: saleOrder3)
wholesale.addProductInOrderSale(product: product4, quantity: 1, orderNumber: saleOrder3)
wholesale.addProductInOrderSale(product: product5, quantity: 4, orderNumber: saleOrder3)
wholesale.finishOrderSale(orderNumber: saleOrder3)

print("\n--------- ORDER SALE 4 --------- ")
var saleOrder4 = wholesale.orderSale(customer: customer4)
wholesale.addProductInOrderSale(product: product9, quantity: 7, orderNumber: saleOrder4)
wholesale.addProductInOrderSale(product: product8, quantity: 3, orderNumber: saleOrder4)
wholesale.addProductInOrderSale(product: product7, quantity: 1, orderNumber: saleOrder4)
wholesale.addProductInOrderSale(product: product6, quantity: 4, orderNumber: saleOrder4)
wholesale.finishOrderSale(orderNumber: saleOrder4)

print("\n--------- ORDER SALE 5 --------- ")
var saleOrder5 = wholesale.orderSale(customer: customer5)
wholesale.addProductInOrderSale(product: product2, quantity: 7, orderNumber: saleOrder5)
wholesale.addProductInOrderSale(product: product3, quantity: 4, orderNumber: saleOrder5)
wholesale.addProductInOrderSale(product: product1, quantity: 5, orderNumber: saleOrder5)
wholesale.addProductInOrderSale(product: product5, quantity: 1, orderNumber: saleOrder5)
wholesale.finishOrderSale(orderNumber: saleOrder5)
wholesale.payOrderSale(orderNumber: saleOrder5)

print("\n--------- ORDER SALE 6 --------- ")
var saleOrder6 = wholesale.orderSale(customer: customer1)
wholesale.addProductInOrderSale(product: product1, quantity: 7, orderNumber: saleOrder6)
wholesale.addProductInOrderSale(product: product3, quantity: 4, orderNumber: saleOrder6)
wholesale.addProductInOrderSale(product: product6, quantity: 5, orderNumber: saleOrder6)
wholesale.addProductInOrderSale(product: product7, quantity: 2, orderNumber: saleOrder6)
wholesale.addProductInOrderSale(product: product8, quantity: 6, orderNumber: saleOrder6)
wholesale.addProductInOrderSale(product: product9, quantity: 9, orderNumber: saleOrder6)
wholesale.finishOrderSale(orderNumber: saleOrder6)

print("\n--------- ORDER SALE 7 --------- ")
var saleOrder7 = wholesale.orderSale(customer: customer2)
wholesale.addProductInOrderSale(product: product7, quantity: 1, orderNumber: saleOrder7)
wholesale.addProductInOrderSale(product: product6, quantity: 4, orderNumber: saleOrder7)
wholesale.finishOrderSale(orderNumber: saleOrder7)
wholesale.payOrderSale(orderNumber: saleOrder7)

print("\n--------- ORDER SALE 8 --------- ")
var saleOrder8 = wholesale.orderSale(customer: customer3)
wholesale.addProductInOrderSale(product: product7, quantity: 1, orderNumber: saleOrder8)
wholesale.addProductInOrderSale(product: product8, quantity: 3, orderNumber: saleOrder8)
wholesale.addProductInOrderSale(product: product9, quantity: 6, orderNumber: saleOrder8)
wholesale.addProductInOrderSale(product: product1, quantity: 8, orderNumber: saleOrder8)
wholesale.addProductInOrderSale(product: product2, quantity: 9, orderNumber: saleOrder8)
wholesale.addProductInOrderSale(product: product3, quantity: 2, orderNumber: saleOrder8)
wholesale.finishOrderSale(orderNumber: saleOrder8)
wholesale.payOrderSale(orderNumber: saleOrder8)

print("\n--------- ORDER SALE 9 --------- ")
var saleOrder9 = wholesale.orderSale(customer: customer4)
wholesale.addProductInOrderSale(product: product10, quantity: 3, orderNumber: saleOrder9)
wholesale.addProductInOrderSale(product: product5, quantity: 10, orderNumber: saleOrder9)
wholesale.finishOrderSale(orderNumber: saleOrder9)

print("\n--------- ORDER SALE 10 --------- ")
var saleOrder10 = wholesale.orderSale(customer: customer5)
wholesale.addProductInOrderSale(product: product1, quantity: 10, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product2, quantity: 12, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product3, quantity: 27, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product4, quantity: 16, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product5, quantity: 31, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product6, quantity: 21, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product7, quantity: 22, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product8, quantity: 16, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product9, quantity: 11, orderNumber: saleOrder10)
wholesale.addProductInOrderSale(product: product10, quantity: 9, orderNumber: saleOrder10)
wholesale.finishOrderSale(orderNumber: saleOrder10)
wholesale.payOrderSale(orderNumber: saleOrder10)

print("\n--------- REPORTS --------- ")

var reports = Reports(wholesale: wholesale)

print("\nReport: Defaulters list of Customers who has not paid their pending amount.\n")
reports.reportListSalePaidAndNot()

print("\nReport: List of Payment Paid or Pending.\n")
reports.reportSaleListOfCustomersPendingAmount()

print("\nReport: List of Payment and Quantity of Orders Paid.\n")
reports.reportSaleListOfCustomersQuantityTotalAmountPaid()

print("\nReport: Product shipped in 2017.\n")
reports.reportProductsDeliveryInYear("2017")

print("\nReport: Product quantity in Stock.\n")
reports.reportProductQuantityInStock()

print("\nReport: Sales by different cities.\n")
reports.reportSalesByCities()

