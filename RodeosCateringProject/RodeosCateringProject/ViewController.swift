//
//  ViewController.swift
//  RodeosCateringProject
//
//  Created by Jorge Chavez on 12/8/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FirebaseApp.configure()
        
        let ref = Database.database().reference()
    
         print("TEeesst")
        ref.child("meats").observeSingleEvent(of: .value){
            (snapshot) in
            let meatData = snapshot.value as? [String:String]
            print (meatData)
        }
    
    }


}

