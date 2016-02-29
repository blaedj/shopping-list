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
 
    // MARK: Initialization

    init?(name: String){
        self.name = name;
        if name.isEmpty {
            return nil
        }
    }
    
}
