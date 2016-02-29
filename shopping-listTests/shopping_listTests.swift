//
//  shopping_listTests.swift
//  shopping-listTests
//
//  Created by Blaed Johnston on 2/29/16.
//  Copyright © 2016 Blaed Johnston. All rights reserved.
//

import XCTest
@testable import shopping_list

class shopping_listTests: XCTestCase {
    
    
    func testGroceryItemInitialization() {
        let potentialItem = GroceryItem(name: "tomato")
        XCTAssertNotNil(potentialItem)
    }
   
    func testGroceryItemInitializationFailure() {
        let failedItem = GroceryItem(name: "")
        XCTAssertNil(failedItem, "Blank names are invalid")
    }
    
}
