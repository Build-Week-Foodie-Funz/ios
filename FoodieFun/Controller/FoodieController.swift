//
//  FoodieController.swift
//  FoodieFun
//
//  Created by Steven Leyva on 9/24/19.
//  Copyright © 2019 William Chen. All rights reserved.
//

import Foundation
import CoreData

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkingError: Error {
    case encodingError
    case respondingError
    case otherError(Error)
    case noData
    case noDecode
    case noToken
    case success
    
}

class FoodieController: Codable{
    
    private let baseURL = URL(string: "https://sethnadu-foodie-bw.herokuapp.com/")!
    
    var userLogin: UserLogin?
    
    func signUp(with user: User, completion: @escaping (NetworkingError) -> Void) {
        
        let signUpURL = baseURL
            .appendingPathComponent("user")
            .appendingPathComponent("signup")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            let userData = try encoder.encode(user)
            request.httpBody = userData
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(.encodingError)
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error creating user on server: \(error)")
                completion(.otherError(error))
                return
            }
            //TODO: had an error look at later if something wrong
            
            completion(.success)
        }.resume()
    }
    
    func login(with user: User, completion: @escaping (NetworkingError?) -> Void) {
        let loginURL = baseURL
            .appendingPathComponent("user")
            .appendingPathComponent("login")
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch {
            NSLog("Error encoding user object: \(error)")
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error logging in: \(error)")
                completion(.otherError(error))
                return
            }
            
            guard let data = data else {
                completion(.noData)
                return
            }
            
            do {
                let userLogin = try JSONDecoder().decode(UserLogin.self, from: data)
                self.userLogin = userLogin
            } catch {
                completion(.noDecode)
                return
            }
            completion(nil)
        }.resume()
    }
    
    @discardableResult func createFoodie(with name: String, location: String, reviews: String, photos: URL, hoursOfOperation: Int64, overallRating: Int64) -> Restaurant {
        
        let resturant = Restaurant(name: name, location: location, hoursOfOperation: hoursOfOperation, overallRating: overallRating, photos: photos, reviews: reviews)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
        
        // Implement put later
        //put(resturant: resturant)
        
        return resturant
    }
    
    func updateFoodie(restaurant: Restaurant, with name: String, location: String, reviews: String, photos: URL) {
        
        restaurant.name = name
        restaurant.location = location
        restaurant.reviews = reviews
        restaurant.photos = photos
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error updating core data: \(error)")
        }
        
    }
    
    func delete(restaurant: Restaurant) {
        
       CoreDataStack.shared.mainContext.delete(restaurant)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error deleting core data: \(error)")
        }
       
        
    }
}
