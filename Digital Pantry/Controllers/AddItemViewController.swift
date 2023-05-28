//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var ingredientDescTextField: UITextField!
    @IBOutlet weak var expiryDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonClick(_ sender: Any) {
        newInventoryItem(name: ingredientNameTextField.text!, description: ingredientDescTextField.text!, quantity: Int64(quantityTextField.text!)!, expiryDate: expiryDatePicker.date, shoppingList: true)
    }
    
}
