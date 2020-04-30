//
//  StoryVCViewController.swift
//  ForestAdventures
//
//  Created by Brandi Bailey on 4/29/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import UIKit

class StoryVC: UIViewController {
    
    let apiController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if apiController.bearer == nil {
            performSegue(withIdentifier: "AuthSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AuthSegue" {
            if let authVC = segue.destination as?
                AuthenticationVC {
                authVC.apiController = apiController
            }
        }
    }
}
