//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var ingredientDescTextField: UITextField!
    @IBOutlet weak var expiryDatePicker: UIDatePicker!
    @IBOutlet weak var storagePickerView: UIPickerView!
    @IBOutlet weak var quantityErrorLabel: UILabel!
    @IBOutlet weak var ingredientNameErrorLabel: UILabel!
    @IBOutlet weak var ingredientDescErrorLabel: UILabel!
    @IBOutlet weak var expiryDateErrorLabel: UILabel!
    
    var storageData = [String]()
    var storageValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ingredientNameErrorLabel.text = ""
        quantityErrorLabel.text = ""
        ingredientDescErrorLabel.text = ""
        expiryDateErrorLabel.text = ""
        
        self.storagePickerView.dataSource = self
        self.storagePickerView.delegate = self
        
        storageData = readStorage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return storageData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return storageData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        storageValue = row
    }
    
    @IBAction func submitButtonClick(_ sender: Any) {
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
            newInventoryItem(name: ingredientNameTextField.text!, description: ingredientDescTextField.text!, quantity: Int64(quantityTextField.text!)!, expiryDate: expiryDatePicker.date, shoppingList: true, storageId: Int64(storageValue))
            let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
