//
//  Follower.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 28.08.2023.
//

import Foundation

struct Follower: Codable {
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
