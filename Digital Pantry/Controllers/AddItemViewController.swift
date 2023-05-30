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
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var ingredientsPickerView: UIPickerView!
    
    var storageData = [String]()
    var storageValue = 0
    var categoriesData = [String]()
    var categoriesValue = 0
    var ingredientsData = [String]()
    var ingredientsValue = 0
    var catID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quantityErrorLabel.text = ""
        expiryDateErrorLabel.text = ""
        
        self.storagePickerView.dataSource = self
        self.storagePickerView.delegate = self
        self.categoriesPickerView.dataSource = self
        self.categoriesPickerView.delegate = self
        self.ingredientsPickerView.dataSource = self
        self.ingredientsPickerView.delegate = self
        storagePickerView.tag = 1
        categoriesPickerView.tag = 2
        ingredientsPickerView.tag = 3

        //set up categories and storage
        storageData = readStorage()
        categoriesData = readCategories()

        expiryDatePicker.backgroundColor = .white
        expiryDatePicker.contentHorizontalAlignment = .center

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
        if (pickerView.tag == 1) {
            return storageData.count
        } else if (pickerView.tag == 2) {
            return categoriesData.count
        } else if (pickerView.tag == 3) {
            return ingredientsData.count
        }
        return 0
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return storageData[row]
        } else if (pickerView.tag == 2) {
            return categoriesData[row]
        } else if (pickerView.tag == 3) {
            return ingredientsData[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if (pickerView.tag == 1) {
            return storageValue = row
        } else if (pickerView.tag == 2) {
            //            clear before adding
            ingredientsData = []
            catID = getCatIdByName(catName: categoriesData[row])
            ingredientsData = readIngredientsByCategory(catId: Int64(catID))
            self.ingredientsPickerView.reloadAllComponents()
            print(ingredientsData)
            return categoriesValue = row
        } else if (pickerView.tag == 3) {
            return ingredientsValue = row
        }
    }
    
    @IBAction func submitButtonClick(_ sender: Any) {
        var errorFlag = false
        quantityErrorLabel.text = ""
        expiryDateErrorLabel.text = ""
        
        if quantityTextField.text!.isEmpty || Int64(quantityTextField.text!) == nil{
            quantityErrorLabel.text = "Invalid quantity"
            errorFlag = true
        }
        if expiryDatePicker.date < Date(){
            expiryDateErrorLabel.text = "Invalid expiry date"
            errorFlag = true
        }
        
        if !errorFlag{
            newInventoryItem(name: ingredientsData[ingredientsValue], quantity: Int64(quantityTextField.text!)!, expiryDate: expiryDatePicker.date, shoppingList: true, storageId: Int64(storageValue))
            let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

