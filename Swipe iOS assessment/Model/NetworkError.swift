//
//  NetworkError.swift
//  Swipe iOS assessment
//
//  Created by Dishant Nagpal on 27/08/23.
//

import Foundation

enum NetworkError: Error, LocalizedError {                // Error enum to handle to have different error cases
    case invalidURL
    case serverEror
    case invalidData
    case unkown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL was invalid, please enter the correct URL again."
        case .serverEror:
            return "There was an error with the server, please try again later"
        case .invalidData:
            return "The data is invalid"
        case .unkown(let error):
            return error.localizedDescription
        }
    }
}
