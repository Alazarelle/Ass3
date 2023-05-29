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
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeNameLabel.text = recipe?.recipeName
        instructionsTextView.text = recipe?.instructions
        // Do any additional setup after loading the view.
    }
}
