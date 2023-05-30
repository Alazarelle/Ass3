//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class RecipeRecentViewController: UIViewController {
    let recipes = readRecipes(prev:true)

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension RecipeRecentViewController:UITableViewDelegate {
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        //what should the app do when user selecting row at a certain index?

        let ShowController = storyboard?.instantiateViewController(withIdentifier: "RecipeShowViewController") as! RecipeShowViewController

        ShowController.recipe =  recipes[indexPath.row]

        self.navigationController?.pushViewController(ShowController, animated: true)
        

    }
}

extension RecipeRecentViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //as a table view, how many cells should i displayin this section
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as a table view, what cell should i display when user is at this index?
        
        //dequed a reusable cell from the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //update the Ui for this cell
        let recipe = recipes[indexPath.row]
        cell?.textLabel?.text = recipe.recipeName
        cell?.textLabel?.textColor = .orange
        //return the cell to Table View
        return cell!
    }
}

