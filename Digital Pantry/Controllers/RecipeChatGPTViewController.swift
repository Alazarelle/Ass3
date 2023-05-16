//
//  NewRecipesController.swift
//  Digital Pantry
//
//  Created by Federico Amor on 16/5/2023.
//

import Foundation

import UIKit
import OpenAIKit

class RecipeChatGPTViewController: UIViewController {
    
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var generateRecipeButton: UIButton!
    
    @IBOutlet weak var outputLabel: UILabel!
    
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateRecipeButtonPressed(_ sender: UIButton) {
        if let text = inputTextField.text, !text.isEmpty {
            APICaller.shared.getResponse(input: text) { [weak self] result in
                switch result{
                case .success(let output):
                    DispatchQueue.main.async {
                        print("success")

                        self?.outputLabel.text = output
                    }

                case .failure:
                    print("failed")
                }
                
            }
        }
    }
    
}
