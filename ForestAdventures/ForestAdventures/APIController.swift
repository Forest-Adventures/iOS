//
//  APIController.swift
//  ForestAdventures
//
//  Created by Brandi Bailey on 4/29/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class APIController {
    
    let signInURL = URL(string: "https://forest-adventure-mud.herokuapp.com/api-token-auth/")!
    private let registerURL = URL(string: "https://forest-adventure-mud.herokuapp.com/api/accounts/")
    var bearer: Bearer?
    
    func signIn(with user: User, completion: @escaping (Error?) -> ()) {
        
        var request = URLRequest(url: signInURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error encoding user: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                print(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            do {
                self.bearer = try decoder.decode(Bearer.self, from: data)
                print("Bearer:", self.bearer)
                
//                let token = self.bearer
//
//               UserDefaults.standard.set(token, forKey: "Bearer")
//                print(defaults)
                
                
            } catch {
                print("Error decoding bearer token: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
        
    }
    
    func signUp(with user: User, completion: @escaping (Error?) -> ()) {
        
        var request = URLRequest(url: registerURL!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
            request.httpBody = data
        } catch {
            print("Error encoding user: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
    
    
}
