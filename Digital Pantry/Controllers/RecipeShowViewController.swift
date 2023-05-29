//
//  RecipeShowViewController.swift
//  Digital Pantry
//
//  Created by Federico Amor on 29/5/2023.
//

import Foundation
import UIKit

class RecipeShowViewController: UIViewController {
    var recipe: Recipe?
    var ingredients: [Ingredient]?
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        recipeNameLabel.text = recipe?.recipeName
        instructionsTextView.text = recipe?.instructions
        print("Holaaa")
        ingredients = readRecipe_Ingredient(recipeId: recipe!.recipeID)
        tableView.reloadData()
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)

        self.tableView.heightAnchor.constraint(equalToConstant: CGFloat(ingredients!.count * 45)).isActive = true

        self.instructionsTextView.heightAnchor.constraint(equalToConstant: CGFloat(ingredients!.count * 170)).isActive = true


        print("Holaaa")
        // Do any additional setup after loading the view.
    }
}


extension RecipeShowViewController:UITableViewDelegate {
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        //what should the app do when user selecting row at a certain index?

    }
}

extension RecipeShowViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //as a table view, how many cells should i displayin this section
        print("Holaaaaaaaaaa")
        return ingredients!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as a table view, what cell should i display when user is at this index?
        
        //dequed a reusable cell from the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        print("HOla")
        //update the Ui for this cell
        print(ingredients!.count)
        cell?.textLabel?.text = ingredients![indexPath.row].ingredName
        cell?.textLabel?.textColor = .orange
        //return the cell to Table View
        return cell!
    }
}
