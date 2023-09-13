//
//  PersistenceManager.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 13.09.2023.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum Keys {
    static let favorites = "favorites"
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower],GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {        // retrieve data from UserDefaults
            completion(.success([]))
            return
        }
        
        do {
            let favorites = try JSONDecoder().decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(GFError.unableToFavorite))
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)        // save data to UserDefaults
            return nil
        } catch {
            return GFError.unableToFavorite
        }
    }
    
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completion(GFError.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: retrievedFavorites))
            case .failure(let error):
                completion(error)
            }
        }
        
    }
    
}
