//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell{
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientDescLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
}

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var inventory = readInventoryTableForShoppingList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        inventory = readInventoryTableForShoppingList()
        
        tableView.reloadData()
    }
    
    @IBAction func buyButtonClick(_ sender: Any) {
        buyShoppingList()
        
        inventory = readInventoryTableForShoppingList()
        
        tableView.reloadData()
    }
    @IBAction func mainMenuButtonClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.executeDB = false
    }
    
}

extension ShoppingListViewController:UITableViewDelegate {
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        //what should the app do when user selecting row at a certain index?
        let vc = storyboard?.instantiateViewController(withIdentifier: "UpdatePantryItemViewController") as! UpdatePantryItemViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.id = inventory[indexPath.row].appPantryID
        vc.shoppingList = true
    }
    
}

extension ShoppingListViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //as a table view, how many cells should i displayin this section
        return inventory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as a table view, what cell should i display when user is at this index?
        
        //dequed a reusable cell from the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ShoppingListTableViewCell
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
