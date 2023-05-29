//
//  UpdatePantryItemController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 30/5/2023.
//

import UIKit

class UpdatePantryItemViewController: UIViewController{


    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var ingredientDescTextField: UITextField!
    @IBOutlet weak var expiryDatePicker: UIDatePicker!
    @IBOutlet weak var quantityErrorLabel: UILabel!
    @IBOutlet weak var ingredientNameErrorLabel: UILabel!
    @IBOutlet weak var ingredientDescErrorLabel: UILabel!
    @IBOutlet weak var expiryDateErrorLabel: UILabel!
    
    var item:AppPantryItem?
    var shoppingList = true
    var id:Int64 = 0
    var storageValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingredientNameErrorLabel.text = ""
        quantityErrorLabel.text = ""
        ingredientDescErrorLabel.text = ""
        expiryDateErrorLabel.text = ""
        
        item = readInventoryFromId(id: id)
        
        quantityTextField.text = String(item!.quantity)
        ingredientDescTextField.text = item!.ingredientDesc
        ingredientNameTextField.text = item!.ingredientName
        expiryDatePicker.date = item!.expiryDate
        
        expiryDatePicker.backgroundColor = .white
        expiryDatePicker.contentHorizontalAlignment = .center
    }
    
    @IBAction func deleteButtonClick(_ sender: Any) {
        deleteInventoryItem(id: id)
        if shoppingList{
            let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
            self.navigationController?.pushViewController(vc, animated: true)
            vc.storageValue = self.storageValue
        }
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
            item?.expiryDate = expiryDatePicker.date
            item?.ingredientDesc = ingredientDescTextField.text!
            item?.ingredientName = ingredientNameTextField.text!
            item?.quantity = Int64(quantityTextField.text!)!

            updateInventory(pantryID: id, updatedPantryItem: item!)
            if shoppingList{
                let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "PantryViewController") as! PantryViewController
                self.navigationController?.pushViewController(vc, animated: true)
                vc.storageValue = self.storageValue
            }
        }
    }
}
