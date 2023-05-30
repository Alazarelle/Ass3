//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class RecipeAddViewController: UIViewController {

    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var cookingTimeTextField: UITextField!
    @IBOutlet weak var complexityTextField: UITextField!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var addNewRecipeButton: UIButton!
    
    var selectedIngredients = [Ingredient?]()
    
    //These come from the previous screen
    var recipeName: String?
    var complexityLevel: Int64?
    var cookingTime: String?
    var instructions: String?

    override func viewDidLoad() {
        complexityTextField.delegate = self
        super.viewDidLoad()
        var ingredientsNameList: String = ""
        if !selectedIngredients.isEmpty{
            for ingredient in selectedIngredients{
                ingredientsNameList += ingredient!.ingredName + "\n"
            }
        }
        ingredientsTextView.text = ingredientsNameList
        if let recipeNameUnwrapped = recipeName{
            recipeNameTextField.text = recipeNameUnwrapped
        }
        if let complexityLevelUnwrapped = complexityLevel{
            complexityTextField.text = String(complexityLevelUnwrapped)
        }
        if let cookingTimeUnwrapped = cookingTime{
            cookingTimeTextField.text = cookingTimeUnwrapped
        }
        if let instructionsUnwrapped = instructions{
            instructionsTextView.text = instructionsUnwrapped
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddNewRecipeButtonPressed(_ sender: UIButton) {
        let recipe = Recipe(recipeName: (recipeNameTextField?.text)!, instructions: (instructionsTextView?.text)!, cookingTime: (cookingTimeTextField?.text)!, complexity: Int64((complexityTextField?.text)!)!)
        insertNewRecipe(newRecipe: recipe)
        let recipeId = readRecipes(prev:true).first?.recipeID
        if !selectedIngredients.isEmpty{
            for ingredient in selectedIngredients{
                insertNewRecipe_ingredient(newRecipe_ingredient: Recipe_Ingred(recipeID: recipeId!, ingredID: (ingredient?.ingredientID)!)!)
            }
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeRecentViewController") as! RecipeRecentViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func ChooseIngredientsButtonPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "IngredientsViewController") as! IngredientsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        vc.recipeName = self.recipeNameTextField.text
        vc.complexityLevel = (Int64(self.complexityTextField.text!))
        vc.cookingTime = self.cookingTimeTextField.text
        vc.instructions = self.instructionsTextView.text
    }
    
}


extension  RecipeAddViewController: UITextFieldDelegate {
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          guard !string.isEmpty else {
                  // Backspace detected, allow text change, no need to process the text any further
                  return true
          }
          if let x = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
            return true
         } else {
         return false
      }
   }
}
