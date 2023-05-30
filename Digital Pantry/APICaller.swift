//
//  APICaller.swift
//  Digital Pantry
//
//  Created by Federico Amor on 16/5/2023.
//

import Foundation
import OpenAISwift

final class APICaller{
    static let shared = APICaller()
    
    private var client: OpenAISwift?
    
    private init(){}
        
    public func setup() {
        self.client = OpenAISwift(authToken: "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")
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String,Error>) -> Void){
        print("Give me a recipe I can make with the following ingredients: \(input). Not all ingredients need to be used. All ingredients used in the recipe instructions must be in the previous list. Do not add new ingredients. Temperature should be in Celsius. Format the answer as a json similar to the following one: { \"recipeName\": \"name\", \"complexity\": \"complexity level from 1 to 5 as a string\", \"cookingTime\": \"cooking time\", \"ingredients\": [ \"ingredient1\", \"ingredient2\", …], \"instructions\": [ \"1. step\", \"2. step\", \"3. step\", …] }")
        client?.sendCompletion(with: "Give me a recipe I can make with the following ingredients: \(input). Not all ingredients need to be used. All ingredients used in the recipe instructions must be in the previous list. Do not add new ingredients. Temperature should be in Celsius. Format the answer as a json similar to the following one: { \"recipeName\": \"name\", \"complexity\": \"complexity level from 1 to 5 as a string\", \"cookingTime\": \"cooking time\", \"ingredients\": [ \"ingredient1\", \"ingredient2\", …], \"instructions\": [ \"1. step\", \"2. step\", \"3. step\", …] }",
                               model: .gpt3(.davinci),
                               maxTokens: 1024,
                               completionHandler: {result in
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? ""
                print(model.choices?.first?.text ?? "")
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
