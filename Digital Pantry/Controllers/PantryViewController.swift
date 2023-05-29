//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class PantryTableViewCell: UITableViewCell{
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientDescLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
}

class PantryViewController: UIViewController { //Freezer, Fridge and Pantry could be united in one InventoryControler

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var inventory = [AppPantryItem]()
    var storageValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        tableView.dataSource = self
        tableView.delegate = self
        
        switch(storageValue){
        case 0: titleLabel.text = "Pantry"
        case 1: titleLabel.text = "Fridge"
        default: titleLabel.text = "Freezer"
        }
        
        tableView.reloadData()
    }
    
    @IBAction func pantryButtonClick(_ sender: Any) {
        titleLabel.text = "Pantry"
        storageValue = 0
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        tableView.reloadData()
    }
    
    @IBAction func fridgeButtonClick(_ sender: Any) {
        titleLabel.text = "Fridge"
        storageValue = 1
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        tableView.reloadData()
    }
    
    @IBAction func freezerButtonClick(_ sender: Any) {
        titleLabel.text = "Freezer"
        storageValue = 2
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        tableView.reloadData()
    }
    
    @IBAction func mainMenuButtonClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.executeDB = false
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddDirectItemViewController") as! AddDirectItemViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.storageValue = self.storageValue
    }
}

extension PantryViewController:UITableViewDelegate {
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        //what should the app do when user selecting row at a certain index?
        let vc = storyboard?.instantiateViewController(withIdentifier: "UpdatePantryItemViewController") as! UpdatePantryItemViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.id = inventory[indexPath.row].appPantryID
        vc.shoppingList = false
    }
    
}

extension PantryViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //as a table view, how many cells should i displayin this section
        return inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as a table view, what cell should i display when user is at this index?
        
        //dequed a reusable cell from the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PantryTableViewCell
        let item = inventory[indexPath.row]
        let formater = DateFormatter()
        formater.dateStyle = .short
        //update the Ui for this cell
        cell.ingredientNameLabel.text = item.ingredientName
        cell.ingredientDescLabel.text = item.ingredientDesc
        cell.expiryDateLabel.text = formater.string(from:item.expiryDate)
        cell.quantityLabel.text = String(item.quantity)
        //return the cell to Table View
        return cell
    }
}
