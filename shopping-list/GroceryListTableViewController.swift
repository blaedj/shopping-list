//
//  GroceryListTableViewController.swift
//  shopping-list
//
//  Created by Blaed Johnston on 2/29/16.
//  Copyright © 2016 Blaed Johnston. All rights reserved.
//

import UIKit

class GroceryListTableViewController: UITableViewController {


    // MARK: Properties
    var groceryItems = [GroceryItem]()
    @IBOutlet var mainGroceryListView: UITableView!
    @IBOutlet weak var listTotal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainGroceryListView.delegate = self;
        navigationItem.leftBarButtonItem = editButtonItem()
        if let savedItems = loadGroceryItems() {
            groceryItems += savedItems
        } else {
            // flatMap the sample items to drop out the nils
            groceryItems += loadSampleItems().flatMap({$0})
        }
        self.updateListTotal()
    }

    func loadSampleItems() -> [GroceryItem?]{
        let item1 = GroceryItem(name: "Milk", quantity: 2)
        let item2 = GroceryItem(name: "eggs", quantity: 1)
        return [item1, item2]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func reloadTableData(){
        tableView.reloadData();
        updateListTotal()
        saveGroceryItems()
    }
   
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "GroceryItemTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! GroceryItemTableViewCell
        let groceryItem = groceryItems[indexPath.row]
        // Configure the cell
        cell.itemDescription.text = groceryItem.name
        cell.quantityInput.text = "\(groceryItem.quantity)"
        cell.unitPriceLabel.text = String(format: "$%.2f", groceryItem.price )
        if groceryItem.completed {
            cell.accessoryType = .Checkmark
        }else {
            cell.accessoryType = .None
        }
        return cell
    }


    @IBAction func unwindToGroceryList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? GroceryListItemViewController, newGroceryItem = sourceViewController.groceryItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow { // edit an existing item
                groceryItems[selectedIndexPath.row] = newGroceryItem
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                reloadTableData()
            } else { // add a new grocery item
                let newIndexPath = NSIndexPath(forRow: groceryItems.count, inSection: 0)
                groceryItems.append(newGroceryItem)
                mainGroceryListView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                reloadTableData()
            }
        }
    }

    func updateListTotal() {
        let totalPrice = groceryItems.reduce(0.0, combine: {$0 + $1.total } )
        listTotal.text = String(format: "$%.2f", totalPrice)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let itemShouldBeEditable = true
        return itemShouldBeEditable
    }
 


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            groceryItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.reloadTableData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let itemDetailViewController = segue.destinationViewController as! GroceryListItemViewController
            if let selectedItemCell = sender as? GroceryItemTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedItemCell)!
                let selectedGroceryItem = groceryItems[indexPath.row]
                itemDetailViewController.groceryItem = selectedGroceryItem
            }
        } else if segue.identifier == "AddItem" {
            print("Adding new grocery item")
        }
    }

    // MARK: NSCoding
    
    func saveGroceryItems(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(groceryItems, toFile: GroceryItem.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save the grocery items...")
        }
    }
    
    func loadGroceryItems() -> [GroceryItem]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(GroceryItem.ArchiveURL.path!) as? [GroceryItem]
    }
    
    

}

















