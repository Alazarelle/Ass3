//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class PantryViewController: UIViewController { //Freezer, Fridge and Pantry could be united in one InventoryControler

    @IBOutlet weak var testTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var inventory = [AppPantryItem]()
    var storageValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        testTextView.text = inventory.description
        
        switch(storageValue){
        case 0: titleLabel.text = "Pantry"
        case 1: titleLabel.text = "Fridge"
        default: titleLabel.text = "Freezer"
        }
    }
    
    @IBAction func pantryButtonClick(_ sender: Any) {
        titleLabel.text = "Pantry"
        storageValue = 0
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        testTextView.text = inventory.description
    }
    
    @IBAction func fridgeButtonClick(_ sender: Any) {
        titleLabel.text = "Fridge"
        storageValue = 1
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        testTextView.text = inventory.description
    }
    
    @IBAction func freezerButtonClick(_ sender: Any) {
        titleLabel.text = "Freezer"
        storageValue = 2
        
        inventory = readInventoryTableForInventory(storageId: Int64(storageValue))
        
        testTextView.text = inventory.description
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
