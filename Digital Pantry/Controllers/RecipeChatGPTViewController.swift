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

    @IBOutlet weak var saveRecipeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generateRecipeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsList = []
        numberOfIngredients = 0
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        generateRecipeButton.titleLabel?.textAlignment = NSTextAlignment.center
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.hidesWhenStopped = true

    }
    
    @IBAction func generateRecipeButtonPressed(_ sender: UIButton) {
        var inventory: [AppPantryItem?] = readInventoryTableForInventory(storageId: 0)
        inventory += readInventoryTableForInventory(storageId: 1)
        inventory += readInventoryTableForInventory(storageId: 2)
        var inventoryNames :String = ""
        for item in inventory{
            inventoryNames += item!.ingredientName.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil) + ", "
        }
        print(inventoryNames)
        activityIndicator.startAnimating()
        APICaller.shared.getResponse(input: inventoryNames) { [weak self] result in
            switch result{
            case .success(let output):
                DispatchQueue.main.async {
                    
                    print("success")

                    let data = output.data(using: .utf8)!
                    
                    do {
                        self?.errorLabel.isHidden = true
                        self?.scrollView.isHidden = false
                        print(output)
                        print(data)
                        let aiRecipe = try JSONDecoder().decode(AIGeneratedRecipe.self, from: data)
                        recipe = Recipe.init(aiGeneratedRecipe: aiRecipe)
                        self?.saveRecipeButton.isHidden = false
                        
                        self?.recipeNameLabel.text = aiRecipe.recipeName
                        numberOfIngredients = aiRecipe.ingredients.count
                        for ingredient in aiRecipe.ingredients{
                            ingredientsList.append(ingredient)
                        }
                        self?.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 300)

                        self?.tableView.heightAnchor.constraint(equalToConstant: CGFloat(numberOfIngredients * 45)).isActive = true
   
                        self?.instructionsTextView.heightAnchor.constraint(equalToConstant: CGFloat(numberOfIngredients * 170)).isActive = true
                        self?.tableView.reloadData()
                        for instruction in aiRecipe.instructions {
                            self?.instructionsTextView.text += instruction + "\n"
                        }
                        self?.activityIndicator.stopAnimating()
                        self?.recipeNameLabel.isHidden = false
                        self?.ingredientsLabel.isHidden = false
                        self?.instructionsLabel.isHidden = false

                    } catch {
                        print(error)
                        self?.activityIndicator.stopAnimating()
                        self?.scrollView.isHidden = true
                        self?.errorLabel.isHidden = false
                        self?.errorLabel.text = "An error ocurred. The format in which the AI answered the request is incorrect. Please press the button to try making a new recipe"
                    }
                }
            case .failure:
                print("failed")
            }
        }

    }
    
    @IBAction func saveRecipeButtonPressed(_ sender: UIButton) {
        let id: Int64?
        if doesCategoryExist(newFoodCat: FoodCategory(foodCategName: "ChatGPT")!){
            print("Hello")

            id = findCategoryIdByName(catName: "ChatGPT")
        }
        else{
            print("Goodbye")

            insertNewFoodCat(newFoodCat: FoodCategory(foodCategName: "ChatGPT")!)
            id = findCategoryIdByName(catName: "ChatGPT")
        }
        let recipeId = insertNewRecipe(newRecipe: recipe!, flag: true)
        print("Recipe saved")
        var flag = false
        let allIngredients = readIngredients()
        for ingredientA in ingredientsList{
            flag = false
            for ingredientB in allIngredients{
                if ingredientA == ingredientB.ingredName{
                    insertNewRecipe_ingredient(newRecipe_ingredient: Recipe_Ingred(recipeID: recipeId, ingredID: ingredientB.ingredientID)!)
                    flag = true
                }
            }
            if flag == false {
                print("New ingredient")
                let newIngredientId = insertNewIngredientAndReturnId(newIngredient: Ingredient(ingredName: ingredientA, foodCategoryID: id!, ingredDescription: ingredientA)!)
                
                insertNewRecipe_ingredient(newRecipe_ingredient: Recipe_Ingred(recipeID: recipeId, ingredID: newIngredientId)!)
            }
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeRecentViewController") as! RecipeRecentViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
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
