//
//  GroceryItem.swift
//  shopping-list
//
//  Created by Blaed Johnston on 2/29/16.
//  Copyright © 2016 Blaed Johnston. All rights reserved.
//

import UIKit

class GroceryItem: NSObject, NSCoding {

    // MARK: Properties
    var name: String
    var quantity: Int
    var completed: Bool
    var price: Double
 
    var total: Double {
        return price * Double(quantity)
    }
   
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("groceryItems")
    
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let quantityKey = "quantity"
        static let priceKey = "price"
        static let completedKey = "completed"
    }
    
    // MARK: Initialization
    init?(name: String, quantity: Int?=0, price: Double?){
        self.name = name;
        self.completed = false;
        self.price = 0.0
        self.quantity = quantity ?? 0
        super.init()
        
        if let tprice = price {
            self.price = tprice
        }
        if name.isEmpty {
            return nil
        }
    }
    
    init?(name: String, quantity: Int?=0) {
        self.name = name;
        self.completed = false;
        self.price = 0.0
        self.quantity = quantity ?? 0
        if name.isEmpty {
            return nil
        }
    }

    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeInt(Int32(quantity), forKey: PropertyKey.quantityKey)
        aCoder.encodeDouble(price, forKey: PropertyKey.priceKey)

    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObjectForKey(PropertyKey.nameKey) as? String
            else {
                print("Could not initialize item from storage...")
                return nil
        }
        self.init(
            name: name,
            quantity:  decoder.decodeIntegerForKey(PropertyKey.quantityKey),
            price: decoder.decodeDoubleForKey(PropertyKey.priceKey)
        )
    }
    
}
