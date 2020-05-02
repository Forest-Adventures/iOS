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

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
}

class APIController {
    
    var room: Room?
    var rooms: [Room] = []
    
    let roomsURL = "https://forest-mud-adventure.herokuapp.com/api/adv/rooms"
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
        request.httpMethod = "POST"
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
    
     func getRooms(completion: @escaping (Result<[Room], NetworkError>) -> Void) {
            // Create URL
            
            if let url = URL(string: roomsURL) {
                
                // Create a URLSession
                
                let session = URLSession(configuration: .default)
                
                // Give the session a task
                
                let task = session.dataTask(with: url) { (data, response, error) in
                    guard let data = data else {
                        print("No data or bad data returned")
                        completion(.failure(.otherError))
                        return
                    }
                    
                    if let error = error {
                        print("Error: ", error)
                        completion(.failure(.badData))
                        return
                    }
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let roomMain = try jsonDecoder.decode(RoomMain.self, from: data)
                        self.rooms = roomMain.rooms
    //                    print(self.rooms)
    //                    for room in self.rooms {
    //                        print(room.name)
    //                    }
                        
                        completion(.success(self.rooms))
                    } catch {
                        print("error: ", error)
                    }
                }
                
                // Start the task
                
                task.resume()
            }
        }
    
    func move(direction: String, completion: @escaping (Result<String, NetworkError>) -> Void)  {
        guard let bearer = bearer else { return }
        
        let moveUrl = URL(string: "https://forest-mud-adventure.herokuapp.com/api/adv/move/")!
        
        var request = URLRequest(url: moveUrl)
        request.httpMethod = "POST"
        request.addValue("Token \(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badData))
                return
            }
            
            if let error = error {
                print("Error recieving data \(error)")
                completion(.failure(.badData))
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let encoder = JSONEncoder()
            
            do {
                let JSONData = try encoder.encode(direction)
            } catch {
                completion(.failure(.otherError))
                return
            }
            completion(.failure(.badData))
        }.resume()
        
        
    }
    
    func movePlayer(input: String) {
        var currentRoomNum = 0
        var currentRoom = rooms[currentRoomNum]
        var currentRoomId = currentRoom.id
        
        if input == "N" {
            //check if there is room to North, by n_to Int?
            //var currentRoom = currentRoom
            if currentRoom.n_to == 0 {
                //change current roomNum to that rooms num
                currentRoomNum += 1
            } else {
            //else print("You can't go that way")
                print("You can't go North from here")
                
            }
            
        } else if input == "E" {
            //check if there is a room to the East
            if currentRoom.e_to == 0 {
               //change current roomNum to that rooms num
                currentRoomNum += 1
            } else {
              //else print("You cant go East from here")
                print("You can't go East from here")
            }
        
        } else if input == "W" {
            //check if there is a room to the West
            if currentRoom.w_to == 0 {
               //change current room num to that rooms num
                currentRoomNum += 1
            } else {
               //else print("You can't move west from here")
                print("YOu can't move west from here")
            }
            
        } else {
            //Check if there is a room to the SOuth
            if currentRoom.s_to == 0 {
               //change current room num to taht rooms num
                currentRoomNum += 1
            } else {
                //else print("You cant go south from here")
                print("You can't go south from here")
            }
            
        }
    }
    
        
}
