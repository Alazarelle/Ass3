//
//  NewRecipesController.swift
//  Digital Pantry
//
//  Created by Federico Amor on 16/5/2023.
//

import Foundation

import UIKit
import OpenAIKit

var numberOfIngredients =  0
var ingredientsList = [String]()
var recipe : Recipe?

class RecipeChatGPTViewController: UIViewController {

    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generateRecipeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    

    @IBAction func generateRecipeButtonPressed(_ sender: UIButton) {
        APICaller.shared.getResponse(input: "Hi") { [weak self] result in
            switch result{
            case .success(let output):
                DispatchQueue.main.async {
                    print("success")
                    let data = output.data(using: .utf8)!
                    
                    do {
                        let aiRecipe = try JSONDecoder().decode(AIGeneratedRecipe.self, from: data)
                        recipe = Recipe.init(aiGeneratedRecipe: aiRecipe)
                        print(recipe)
                        self?.recipeNameLabel.text = aiRecipe.recipeName
                        numberOfIngredients = aiRecipe.ingredients.count
                        for ingredient in aiRecipe.ingredients{
                            ingredientsList.append(ingredient)
                        }
                        self?.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+400)

                        self?.tableView.heightAnchor.constraint(equalToConstant: CGFloat(numberOfIngredients * 45)).isActive = true
   
                        self?.instructionsTextView.heightAnchor.constraint(equalToConstant: CGFloat(numberOfIngredients * 170)).isActive = true
                        self?.tableView.reloadData()
                        for instruction in aiRecipe.instructions {
                            self?.instructionsTextView.text += instruction + "\n"
                        }
                    } catch {
                        print(error)
                    }
                }
            case .failure:
                print("failed")
            }
        }
    }
    
    @IBAction func saveRecipeButtonPressed(_ sender: UIButton) {
        insertNewRecipe(newRecipe: recipe!)
    }
    
    
}

extension RecipeChatGPTViewController:UITableViewDelegate {
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        //what should the app do when user selecting row at a certain index?
    }
}

extension RecipeChatGPTViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //as a table view, how many cells should i displayin this section
        return numberOfIngredients
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //as a table view, what cell should i display when user is at this index?
        
        //dequed a reusable cell from the table view
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        //update the Ui for this cell
        let ingredient = ingredientsList[indexPath.row]
        cell?.textLabel?.text = ingredient
        cell?.textLabel?.textColor = .orange
        //return the cell to Table View
        return cell!
    }
}
