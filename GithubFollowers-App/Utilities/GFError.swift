//
//  GFError.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 28.08.2023.
//

import Foundation

// Enum with raw values
enum GFError: String, Error {
    case invalidUsername  = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse  = "Invalid response from the server. Please try again."
    case invalidData      = "The data received from the server was invalid. Please try again."
}
