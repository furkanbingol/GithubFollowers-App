//
//  NetworkManager.swift
//  GithubFollowers-App
//
//  Created by Furkan Bingöl on 28.08.2023.
//

import UIKit

final class NetworkManager {
    static let shared   = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    private let cache   = NSCache<NSString, UIImage>()       // for image caching
    
    private init() { }
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {    // HTTP Code: 200 -- OK
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String, completion: @escaping(Result<User, GFError>) -> Void) {
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping(UIImage) -> Void) {
        // Check if the image cached before
        if let image = cache.object(forKey: urlString as NSString) {
            completion(image)
            return
        }
        
        // If the image is not in cache, get image from network and put it in the cache
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  error == nil else {
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        task.resume()
    }
    
}
