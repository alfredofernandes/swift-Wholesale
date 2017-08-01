//
//  PrintHeader.swift
//  Wholesale
//
//  Copyright © 2017 Lambton. All rights reserved.
//

import Foundation

class PrintHeader {
    
    static func createTable(columns:[String], rows:[[String:AnyObject]], size:Int) -> String {
        
        let columnDefault = size
        var headerString = ""
        
        for column in columns {
            headerString += column.padding(toLength: columnDefault, withPad: " ", startingAt: 0)
        }
        
        let lineString = "".padding(toLength: headerString.characters.count, withPad: "-", startingAt: 0)
        let rows = self.createRows(rows: rows, size: size)
        
        return "\(headerString)\n\(lineString)\n\(rows)"
    }
    
    static func createRows(rows:[[String:AnyObject]], size:Int) -> String {
        
        var result = ""
        
        for dictionary in rows {

            var dataString = ""
            for (_,value) in Array(dictionary).sorted(by: {$0.0 < $1.0}) {
                
                let variable = String(describing: value)
                dataString += variable.padding(toLength: size, withPad: " ", startingAt: 0)
            }
            
            result += dataString + "\n"
        }
        
       return result
    }
}
