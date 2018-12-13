//
//  ViewController.swift
//  RodeosCateringProject
//
//  Created by Jorge Chavez on 12/8/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController
{
    
    @IBOutlet weak var menu_btn: UIButton!
    @IBOutlet weak var place_order_btn: UIButton!
    @IBOutlet weak var contact_us_btn: UIButton!
    
    
    @IBAction func place_order_pressed(_ sender: Any) {
        performSegue(withIdentifier: "place_order_slider", sender: self)
    }
    
    
    override func viewDidLoad()
    {
        FirebaseApp.configure()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menu_btn.layer.cornerRadius = 15
        place_order_btn.layer.cornerRadius = 15
        contact_us_btn.layer.cornerRadius = 15
    }
}

