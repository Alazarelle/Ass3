//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class RecipePreferencesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var dietsPickerView: UIPickerView!
    @IBOutlet weak var allergiesPickerView: UIPickerView!
    
    
    
    var dietsData = [String]()
    var dietsValue = 0
    var allergiesData = [String]()
    var allergiesValue = 0
    var allergyId = 0
    var dietId = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dietsPickerView.dataSource = self
        self.dietsPickerView.delegate = self
        self.allergiesPickerView.dataSource = self
        self.allergiesPickerView.delegate = self
        
        dietsPickerView.tag = 1
        allergiesPickerView.tag = 2
        
        //set up diets and allergies
        dietsData = readDiets()
        allergiesData = readAllergies()
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
            return dietsData.count
        } else if (pickerView.tag == 2) {
            return allergiesData.count
        }
        return 0
    }
    
    @IBAction func DietAddButton(_ sender: UIButton) {
        
        //var pref = Preference(type: "Diet", allergyID: 0, dietID: 0)//getDietIdByName(dietName: dietsData[row])
        insertNewPreferences(newPreferences: Preference(type: "Diet", allergyID: 0, dietID: (Int64(exactly: dietsValue))!)!)
                             
        print("set diet id to \(dietsValue) which is for \(dietsData[dietsValue])")
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func allergyAddButton(_ sender: UIButton) {
        var pref = Preference(type: "Diet", allergyID: 0, dietID: 0)//getDietIdByName(dietName: dietsData[row])
        insertNewPreferences(newPreferences: Preference(type: "Diet", allergyID: Int64(exactly: allergiesValue)!, dietID: 0)!)
        print("set allergy id to \(allergiesValue) which is for \(allergiesData[allergiesValue])")
        let vc = storyboard?.instantiateViewController(withIdentifier: "ShoppingListViewController") as! ShoppingListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

     
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
            return dietsData[row]
        } else if (pickerView.tag == 2) {
            return allergiesData[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if (pickerView.tag == 1) {
            return dietsValue = row
        } else if (pickerView.tag == 2) {
            return allergiesValue = row
        }
    }

//    @IBAction func submitButtonClick(_ sender: Any) {
//        //var errorFlag = false
//        
//        //if !errorFlag{
//        var pref = Preference(type: (pickerview.tag = 1 ? "Diet" : "Allergy"), allergyID: (pickerview.tag = 1 ? dietID : allergId), dietID: (pickerview.tag = 1 ? dietID : allergId))
//        insertNewAllergy(newAllergy: pref)
//        
//
//            let vc = storyboard?.instantiateViewController(withIdentifier: "AddDirectItemViewController") as! AddDirectItemViewController
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    
  
//    }

}


