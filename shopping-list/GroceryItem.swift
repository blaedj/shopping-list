//
//  GroceryItem.swift
//  shopping-list
//
//  Created by Blaed Johnston on 2/29/16.
//  Copyright © 2016 Blaed Johnston. All rights reserved.
//

import UIKit

class GroceryItem {

    // MARK: Properties
    
    var name: String
    var quantity: Int16
 
    // MARK: Initialization

    init?(name: String, quantity: Int16?=0){
        self.name = name;
        self.quantity = quantity ?? 0
        if name.isEmpty {
            return nil
        }
    }
    
}
