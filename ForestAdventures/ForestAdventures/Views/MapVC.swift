//
//  ViewController.swift
//  MudMap-HWS
//
//  Created by Brandi Bailey on 4/30/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit
import SpriteKit

class MapVC: UIViewController {
    
    //    fileprivate var rooms: [Room] = []
    //var tileSet
    @IBOutlet weak var gridView: UIView!
    
    var apiController = APIController()
    var room: Room?
    var rooms: [RoomMain]?
    var roomCoordArr: [String] = []
    
    
    
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
            
            let roomCoords = "(x: \(roomX), y: \(roomY)"
            roomCoordArr.append(roomCoords)
            print("This is our array of room coords: ", roomCoordArr)
            
    
                DispatchQueue.main.async {
                    print("Here: ", room.name, roomX, roomY)
                    
                    //                    self.configureGridView()
                    
                    //                    let roomXOffset = CGPoint(x: roomX, y: roomX + 20)
                    //                    let roomYOffset = CGPoint(x: roomY, y: roomY + 20)
                    //
                    
                    
                    let layerView = UIView(frame: CGRect(x: roomX, y: roomY, width: 24, height: 24).offsetBy(dx: 80, dy: 80))
                    layerView.backgroundColor = .orange
                    self.gridView.addSubview(layerView)
                    self.gridView.layer.borderColor = UIColor.purple.cgColor
                    self.gridView.layer.borderWidth = 5
                    
                    
                    
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
    
    
    func drawSquares() {
        
        var widthSize = 2.0
        var heightSize = 2.0
        var colorChoice = UIColor.orange
        
        var centerx = apiController.rooms[0].x
        var centery = apiController.rooms[0].y
        var num = 1
        
        
        for room in apiController.rooms {
            if apiController.rooms[num].x > centerx || apiController.rooms[num].y == centery {
                drawEast()
                num += 1
            } else if apiController.rooms[num].x == centerx || apiController.rooms[num].y > centery {
                drawNorth()
                num += 1
            } else if apiController.rooms[num].x < centerx || apiController.rooms[num].y == centery {
                drawWest()
                num += 1
            } else {
                drawSouth()
                num += 1
            }
            
        }
        
    }
    
    func drawNorth() {
        //check if coming from south
        
        //check if coming from east
        
        //check if coming from west
    }
    
    func drawEast() {
        //check if coming from south
        
        //check if coming from North
        
        //check if coming from west
    }
    
    func drawWest() {
        //check if coming from south
        
        //check if coming from east
        
        //check if coming from North
    }
    
    func drawSouth() {
        //check if coming from north
        
        //check if coming from east
        
        //check if coming from west
    }
    
}






