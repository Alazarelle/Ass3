//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class RecipePreferencesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var prefs = readPreferences()
    
    @IBOutlet weak var dietsPickerView: UIPickerView!
    @IBOutlet weak var allergiesPickerView: UIPickerView!
    
    @IBOutlet weak var AllergiesDietsTableView: UITableView!
    
    
    var dietsData = [String]()
    var dietsValue:Int64 = 0
    var allergiesData = [String]()
    var allergiesValue:Int64 = 0
    var allergyId = 0
    var dietId = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dietsPickerView.dataSource = self
        self.dietsPickerView.delegate = self
        self.allergiesPickerView.dataSource = self
        self.allergiesPickerView.delegate = self
        
        AllergiesDietsTableView.delegate = self
        AllergiesDietsTableView.dataSource = self
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
        insertNewPreferences(newPreferences: Preference(type: "Diet", allergyID: 0, dietID: Int64(getDietIdByName(dietName: dietsData[Int(dietsValue)])))!)
                             
        print("set diet id to \(dietsValue) which is for \(dietsData[Int(dietsValue)])")
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipePreferencesViewController") as! RecipePreferencesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func allergyAddButton(_ sender: UIButton) {
        //var pref = Preference(type: "Allergy", allergyID: 0, dietID: 0)//getDietIdByName(dietName: dietsData[row])
        insertNewPreferences(newPreferences: Preference(type: "Allergy", allergyID: Int64(getAllergyIdByName(allergyName: allergiesData[Int(allergiesValue)])), dietID: 0)!)
        print("set allergy id to \(allergiesValue) which is for \(allergiesData[Int(allergiesValue)])")
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipePreferencesViewController") as! RecipePreferencesViewController
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
            return dietsValue = Int64(row)
        } else if (pickerView.tag == 2) {
            return allergiesValue = Int64(row)
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

extension RecipePreferencesViewController:UITableViewDelegate {
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath) {
        //what should the app do when user selecting row at a certain index?
        
//        let ShowController = storyboard?.instantiateViewController(withIdentifier: "RecipePreferencesViewController") as! RecipePreferencesViewController
        
        //ShowController.prefs = prefs[indexPath.row]
        
//        self.navigationController?.pushViewController(ShowController, animated: true)
    }
}

extension RecipePreferencesViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //as a table view, how many cells should i displayin this section
        print("This is the count of records: \(prefs.count)")
        return prefs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as a table view, what cell should i display when user is at this index?
        
        //dequed a reusable cell from the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        print("THis is the prefs \(prefs.description)")
        //update the Ui for this cell
        let pref = prefs[indexPath.row]
        print("This is PREF!! \(pref) ")
        
        cell?.textLabel?.text = pref
        cell?.textLabel?.textColor = .orange
        
        //return the cell to Table View
        return cell!
    }
}



