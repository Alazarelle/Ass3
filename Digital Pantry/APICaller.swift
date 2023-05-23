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
        client?.sendCompletion(with: input, completionHandler: {result in
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
