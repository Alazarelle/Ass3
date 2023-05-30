//
//  UpdatePantryItemController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 30/5/2023.
//

import UIKit

class UpdatePantryItemViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var expiryDatePicker: UIDatePicker!
    @IBOutlet weak var quantityErrorLabel: UILabel!
    @IBOutlet weak var expiryDateErrorLabel: UILabel!
    @IBOutlet weak var categoriesPickerView: UIPickerView!
    @IBOutlet weak var ingredientsPickerView: UIPickerView!
    
    var item:AppPantryItem?
    var shoppingList = true
    var id:Int64 = 0
    var storageValue = 0
    var categoriesData = [String]()
    var categoriesValue = 0
    var ingredientsData = [String]()
    var ingredientsValue = 0
    var catID:Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quantityErrorLabel.text = ""
        expiryDateErrorLabel.text = ""
        
        self.categoriesPickerView.dataSource = self
        self.categoriesPickerView.delegate = self
        self.ingredientsPickerView.dataSource = self
        self.ingredientsPickerView.delegate = self
        categoriesPickerView.tag = 2
        ingredientsPickerView.tag = 3
        item = readInventoryFromId(id: id)
        
        //set up categories
        categoriesData = readCategories()
        catID = item!.getIngredient().getFoodCategoryID()
        categoriesPickerView.selectRow(Int(catID), inComponent: 0, animated: true)
        ingredientsData = readIngredientsByCategory(catId: catID)
        let name = item!.getIngredient().getIngredName()
        for (index, food) in ingredientsData.enumerated() {
            if (food == name) {
                ingredientsPickerView.selectRow(index, inComponent: 0, animated: true)
            }
        }
        
        quantityTextField.text = String(item!.quantity)
        expiryDatePicker.date = item!.expiryDate
        
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
        if (pickerView.tag == 2) {
            return categoriesData.count
        } else if (pickerView.tag == 3) {
            return ingredientsData.count
        }
        return 0
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 2) {
            return categoriesData[row]
        } else if (pickerView.tag == 3) {
            return ingredientsData[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if (pickerView.tag == 2) {
            //            clear before adding
            ingredientsData = []
            catID = Int64(getCatIdByName(catName: categoriesData[row]))
            ingredientsData = readIngredientsByCategory(catId: catID)
            self.ingredientsPickerView.reloadAllComponents()
            print(ingredientsData)
            return categoriesValue = row
        } else if (pickerView.tag == 3) {
            return ingredientsValue = row
        }
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
            item?.expiryDate = expiryDatePicker.date
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
