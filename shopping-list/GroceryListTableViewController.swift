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

    override func viewDidLoad() {
        super.viewDidLoad()
        mainGroceryListView.delegate = self;
        loadSampleItems()
    }

    func loadSampleItems(){
        let item1 = GroceryItem(name: "Milk")
        let item2 = GroceryItem(name: "eggs")
        groceryItems += [item1!, item2!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.quantityLabel.text = "\(groceryItem.quantity)"
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
            let newIndexPath = NSIndexPath(forRow: groceryItems.count, inSection: 0)
            groceryItems.append(newGroceryItem)
            mainGroceryListView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }


    // Consider a tap on a table view cell an indivation that this item is completed
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let tappedItem = groceryItems[indexPath.row]
        showPriceEntryAlert(tappedItem, complete: nil)
    }

    //complete is a block called after the viewDidAppear method is called on the popped-up alert view.
    // this means it is called once the alert view has been displayed.
    func showPriceEntryAlert(item: GroceryItem, complete: (()->Void)?) {
        let alertController = UIAlertController(title: "Item Price", message: "enter the price for one item", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler( {
            (textField: UITextField) in
            textField.placeholder = "$0.00"
        })
        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: {
            (action )in
            item.completed = false
            self.tableView.reloadData()
        })

        let saveAction = UIAlertAction(title: "Save", style: .Default, handler: {
            (action) in
            if let newPrice = Double((alertController.textFields?.first?.text)!) {
                item.price = newPrice
            } else {
                item.price = 0.0
            }
            item.completed = true
            self.tableView.reloadData()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.presentViewController(alertController, animated: true, completion: complete)

    }

    func updateTotalInTitleBar() {
        // this will update the total price in the titlebar
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
