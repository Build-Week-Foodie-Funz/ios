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

class RestaurantController: Codable{
    
    private let baseURL = URL(string: "https://sethnadu-foodie-bw.herokuapp.com/")!
    
    var user: User?
    
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
                let userLogin = try JSONDecoder().decode(User.self, from: data)
                self.user = userLogin
            } catch {
                completion(.noDecode)
                return
            }
            completion(nil)
            }.resume()
    }
    
    @discardableResult func createFoodie(with name: String, location: String, reviews: [Review], photos: [Photo], hoursOfOperation: Int64, overallRating: Int64) -> Restaurant {
        
        let restaurant = Restaurant(name: name, location: location, hoursOfOperation: hoursOfOperation, overallRating: overallRating, photos: photos, reviews: reviews)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving to core data: \(error)")
        }
        
        // Implement put later
        //put(resturant: resturant)
        
        return restaurant
    }
    
    private func updatePersistentStore(with restaurantRepresentations: [RestaurantRepresentation], context: NSManagedObjectContext) {
        context.performAndWait {
            
            
            
            let namesToFetch = restaurantRepresentations.compactMap({$0.name!})
            
            let representationsByName = Dictionary(uniqueKeysWithValues: zip(namesToFetch, restaurantRepresentations))
            
            var restaurantsToCreate = representationsByName
            
            let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name IN %@", namesToFetch)
            
            let context = CoreDataStack.shared.container.newBackgroundContext()
            
            context.performAndWait {
                
                do {
                    let existingRestaurants = try context.fetch(fetchRequest)
                    
                    for restaurant in existingRestaurants{
                        guard let name = restaurant.name,
                            let representation = representationsByName[name] else { continue }
                        self.updateFoodie(restaurant: restaurant, with: representation)
                        
                        restaurantsToCreate.removeValue(forKey: name)
                    }
                    
                    for representation in restaurantsToCreate.values {
                        Restaurant(restaurantRepresentation: representation, context: context)
                    }
                    
                } catch {
                    NSLog("Error fetching tasks for UUIDs: \(error)")
                }
                
                try? CoreDataStack.shared.save(context: context)
            }
        }
        
        func updateFoodie(restaurant: Restaurant, with name: String, location: String, reviews: String, photos: URL) {
            
            restaurant.name = name
            restaurant.location = location
            restaurant.photo = [photos]
            restaurant.reviews = [reviews]
            
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
            
            func fetchRestaurantsFromServer(classId: Int64, completion: @escaping () -> Void = {}) {
                guard let token = user?.token else { return }
                let requestURL = baseURL.appendingPathComponent("user") .appendingPathComponent("restaurant")
                var request = URLRequest(url: requestURL)
                request.httpMethod = HTTPMethod.get.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue(token, forHTTPHeaderField: "Authorization")
                
                URLSession.shared.dataTask(with: request) { (data, _, error) in
                    if let error = error {
                        NSLog("Error fetching sessions from server: \(error)")
                        return
                    }
                    guard let data = data else {
                        NSLog("No data returned from data task")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let restaurantRepresentation  = try decoder.decode([RestaurantRepresentation].self, from: data)
                        
                        // loop through the course representations
                        let moc = CoreDataStack.shared.container.newBackgroundContext()
                        self.updatePersistentStore(with: restaurantRepresentation, context: moc)
                    }catch {
                        NSLog("Error decoding: \(error)")
                    }
                    completion()
                    }.resume()
            }
            
        }
        
    }
}
