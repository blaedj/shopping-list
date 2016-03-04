//
//  AddGroceryListItemViewController.swift
//  shopping-list
//
//  Created by Blaed Johnston on 3/3/16.
//  Copyright © 2016 Blaed Johnston. All rights reserved.
//

import UIKit

class GroceryListItemViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    var groceryItem: GroceryItem?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var itemDescriptionField: UITextField!
    @IBOutlet weak var quantityField: UITextField!

    // MARK: Navigation
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //this method lets you configure a view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let description = itemDescriptionField.text ?? ""
            let quantityText = quantityField.text ?? "0"
            let quantity = Int16(quantityText)
            print(description, quantity)
            groceryItem = GroceryItem(name: description, quantity: quantity)
        }
    }

    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        //disable the save button while editing
        saveButton.enabled = false
        checkValidItemDescriptionField()
    }

    func textFieldDidEndEditing(textField: UITextField){
        checkValidItemDescriptionField()
        navigationItem.title = textField.text
    }

    func checkValidItemDescriptionField(){
        let text = itemDescriptionField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        itemDescriptionField.delegate = self
        checkValidItemDescriptionField()
    }
    
}
