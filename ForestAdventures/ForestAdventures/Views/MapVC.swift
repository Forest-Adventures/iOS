//
//  ViewController.swift
//  MudMap-HWS
//
//  Created by Brandi Bailey on 4/30/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

        //    fileprivate var rooms: [Room] = []
        
        @IBOutlet weak var gridView: UIView!
        
        var apiController = APIController()
        var room: Room?
        var rooms: [RoomMain]?
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            apiController.getRooms { (result) in
                switch result {
                case .success(let room):
                    self.updateViews()
                    print("I'm in!!")
                case .failure(let error):
                    print("You failed.")
                }
            }
            
            
        }
        
        
        func updateViews() {
            print("hello...")
            
            for room in apiController.rooms {
                
                let roomX = room.x
                let roomY = room.y
                
                DispatchQueue.main.async {
                    print("Here: ", room.name, roomX, roomY)
                    
                    self.configureGridView()
                    
                    let layerView = UIView(frame: CGRect(x: roomX, y: roomY, width: 12, height: 12))
                    layerView.backgroundColor = .orange
                    self.gridView.addSubview(layerView)
                }
                
                
            }
            
            
            
        }
        
        func configureGridView() {
            let roomCount = Double(apiController.rooms.count)
            let roomSqRt = roomCount.squareRoot().rounded()
            print(roomSqRt)
            
            var viewFrame = gridView.frame
            
            viewFrame.size.width = CGFloat(Int(roomSqRt))
            viewFrame.size.height = CGFloat(Int(roomSqRt))
            
            print(viewFrame.size.width, viewFrame.size.height)
            gridView.frame = viewFrame
            
                        
        }
        
    }






