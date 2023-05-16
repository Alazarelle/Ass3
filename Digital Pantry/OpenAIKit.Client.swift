//
//  OpenAIKit.Client.swift
//  Digital Pantry
//
//  Created by Federico Amor on 16/5/2023.
//

import Foundation

var apiKey: String {
    ProcessInfo.processInfo.environment["OPENAI_API_KEY"]!
}

//var organization: String {
//    ProcessInfo.processInfo.environment["OPENAI_ORGANIZATION"]!
//}



// Generally we would advise on creating a single HTTPClient for the lifecycle of your application and recommend shutting it down on application close.

//let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)

//let httpClient = HTTPClient(eventLoopGroupProvider: .shared(eventLoopGroup))

//defer {
    // it's important to shutdown the httpClient after all requests are done, even if one failed. See: https://github.com/swift-server/async-http-client
//    try? httpClient.syncShutdown()
//}

//let configuration = Configuration(apiKey: apiKey, organization: organization)

//let openAIClient = OpenAIKit.Client(httpClient: httpClient, configuration: configuration)
