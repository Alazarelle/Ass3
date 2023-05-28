//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class ShoppingListViewController: UIViewController {

    @IBOutlet weak var testTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let inventory = readInventoryTableForShoppingList()
        
        testTextView.text = inventory.description
    }
    
    @IBAction func buyButtonClick(_ sender: Any) {
        buyShoppingList()
        
        let inventory = readInventoryTableForShoppingList()
        
        testTextView.text = inventory.description
    }
    @IBAction func mainMenuButtonClick(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MainMenuViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
