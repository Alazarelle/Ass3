//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class RecipeRecentViewController: UIViewController {

    @IBOutlet weak var RecentrecipesTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let recipes = readRecipes()
        RecentrecipesTextView.text = recipes.description
        // Do any additional setup after loading the view.
    }
    

}


