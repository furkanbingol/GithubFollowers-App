//
//  User.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 28.08.2023.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case name
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case htmlUrl = "html_url"
        case following
        case followers
        case createdAt = "created_at"
    }
}
