//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class PantryViewController: UIViewController { //Freezer, Fridge and Pantry could be united in one InventoryControler

    @IBOutlet weak var testTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let inventory = readInventoryTable()
        
        testTextField.text = inventory.description
    }
    

}
