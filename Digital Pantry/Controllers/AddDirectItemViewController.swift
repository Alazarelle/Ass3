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
    @IBOutlet weak var quantityErrorLabel: UILabel!
    @IBOutlet weak var ingredientNameErrorLabel: UILabel!
    @IBOutlet weak var ingredientDescErrorLabel: UILabel!
    @IBOutlet weak var expiryDateErrorLabel: UILabel!
    
    var storageValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingredientNameErrorLabel.text = ""
        quantityErrorLabel.text = ""
        ingredientDescErrorLabel.text = ""
        expiryDateErrorLabel.text = ""
    }
    
    @IBAction func submitButtonClick(_ sender: Any) {
        print(storageValue)
        var errorFlag = false
        ingredientNameErrorLabel.text = ""
        quantityErrorLabel.text = ""
        ingredientDescErrorLabel.text = ""
        expiryDateErrorLabel.text = ""
        
        if ingredientNameTextField.text!.isEmpty{
            ingredientNameErrorLabel.text = "Invalid ingredient name"
            errorFlag = true
        }
        if ingredientDescTextField.text!.isEmpty{
            ingredientDescErrorLabel.text = "Invalid ingredient description"
            errorFlag = true
        }
        if quantityTextField.text!.isEmpty || Int64(quantityTextField.text!) == nil{
            quantityErrorLabel.text = "Invalid quantity"
            errorFlag = true
        }
        if expiryDatePicker.date < Date(){
            expiryDateErrorLabel.text = "Invalid expiry date"
            errorFlag = true
        }
        
        if !errorFlag{
            newInventoryItem(name: ingredientNameTextField.text!, description: ingredientDescTextField.text!, quantity: Int64(quantityTextField.text!)!, expiryDate: expiryDatePicker.date, shoppingList: false, storageId: Int64(storageValue))
            let vc = storyboard?.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.storageValue = self.storageValue
        }
    }
}
