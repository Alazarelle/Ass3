//
//  RecipeViewController.swift
//  Digital Pantry
//
//  Created by Lucas Agustin Infantino on 16/5/2023.
//

import UIKit

class RecipeAddViewController: UIViewController {

    @IBOutlet weak var cookingTimeTextField: UITextField!
    @IBOutlet weak var complexityTextField: UITextField!
    @IBOutlet weak var recipeNameTextField: UITextField!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var addNewRecipeButton: UIButton!
    

    override func viewDidLoad() {
        complexityTextField.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddNewRecipeButtonPressed(_ sender: UIButton) {
        let recipe = Recipe(recipeName: (recipeNameTextField?.text)!, instructions: (instructionsTextView?.text)!, cookingTime: (cookingTimeTextField?.text)!, complexity: Int64((complexityTextField?.text)!)!)
        insertNewRecipe(newRecipe: recipe)
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
