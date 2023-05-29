//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 29/5/2023.
//

import UIKit

class AddDirectItemViewController: UIViewController{

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var ingredientDescTextField: UITextField!
    @IBOutlet weak var expiryDatePicker: UIDatePicker!
    
    var storageValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonClick(_ sender: Any) {
        print(storageValue)
        newInventoryItem(name: ingredientNameTextField.text!, description: ingredientDescTextField.text!, quantity: Int64(quantityTextField.text!)!, expiryDate: expiryDatePicker.date, shoppingList: false, storageId: Int64(storageValue))
        let vc = storyboard?.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.storageValue = self.storageValue
    }
}
