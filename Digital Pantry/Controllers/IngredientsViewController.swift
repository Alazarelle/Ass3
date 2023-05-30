//
//  IngredientsViewController.swift
//  Digital Pantry
//
//  Created by Federico Amor on 29/5/2023.
//

import Foundation
import UIKit

class IngredientsViewController: UIViewController {
    var ingredients = readIngredients()
    var data = [""]
    var selectedData = [Ingredient?]()
    var filteredData: [String]!
    
    //These come from the previous screen
    var recipeName: String?
    var complexityLevel: Int64?
    var cookingTime: String?
    var instructions: String?


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for ingredient in ingredients{
            data.append(ingredient.ingredName)
        }
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        filteredData = data
        // Do any additional setup after loading the view.
    }
    @IBAction func IngredientsDoneButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeAddViewController") as! RecipeAddViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.recipeName = self.recipeName
        vc.complexityLevel = self.complexityLevel
        vc.cookingTime = self.cookingTime
        vc.instructions = self.instructions
        vc.selectedIngredients = self.selectedData
    }
}

extension IngredientsViewController:UITableViewDelegate {
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        let ingredient = getIngredientByName(ingName: filteredData[indexPath.row])
        selectedData.append(ingredient)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = .gray
    }
}

extension IngredientsViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //as a table view, how many cells should i displayin this section
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as a table view, what cell should i display when user is at this index?
        
        //dequed a reusable cell from the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //update the Ui for this cell
        cell?.textLabel?.text = filteredData[indexPath.row]
        cell?.textLabel?.textColor = .orange
        //return the cell to Table View
        return cell!
    }
}

extension IngredientsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })

        tableView.reloadData()
    }
}
