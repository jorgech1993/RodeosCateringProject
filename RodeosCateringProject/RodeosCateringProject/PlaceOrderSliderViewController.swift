//
//  PlaceOrderSliderViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/10/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var meat_name_array = [String]()
var juice_name_array = [String]()
var meat_images = [UIImage]()

class PlaceOrderSliderViewController: UIViewController
{
    
    @IBOutlet weak var number_of_guests_label: UILabel!
    
    @IBOutlet weak var guest_slider: UISlider!
    
    @IBAction func number_slider_changed(_ sender: Any)
    {
        number_of_guests_label.text =
            String(Int(guest_slider.value))
    }
    
    
    @IBAction func continue_to_meats_page(_ sender: Any)
    {
        performSegue(withIdentifier: "meats_table_view", sender:self)
    }
    
    
    override func viewDidLoad()
    {
        number_of_guests_label.text = "10"
        guest_slider.value = Float(10)
        // we want the minimum number of available
        // guests to be catered for 10
        // and maximum number of catered guests
        // to 500.
        guest_slider.minimumValue = Float(10)
        guest_slider.maximumValue = Float(500)
        
        meat_name_array.removeAll()
        readMeatsFromDatabase()
        readMeatImages()
        readJuicesFromDatabase()
        
        super.viewDidLoad()
    }

    
    func readMeatsFromDatabase() -> Void
    {
        let ref = Database.database().reference()
        ref.child("meats").observeSingleEvent(of: .value)
        {
            (snapshot) in
            if let meat_objects = snapshot.value as? [String:String]
            {
                for (_,value) in meat_objects
                {
                    meat_name_array.append(value)
                }
            }
        }
    }// end readMeatsFromDatabase
    
    func readMeatImages() -> Void
    {
        meat_images.append(UIImage(named: "Adobada")!)
        meat_images.append(UIImage(named: "Birria")!)
        meat_images.append(UIImage(named: "Buche")!)
        meat_images.append(UIImage(named: "Cabeza")!)
        meat_images.append(UIImage(named: "Carne")!)
        meat_images.append(UIImage(named: "Carnitas")!)
                meat_images.append(UIImage(named: "Chicken")!)
        meat_images.append(UIImage(named: "Mulitas")!)
        meat_images.append(UIImage(named: "Quesadilla")!)
        meat_images.append(UIImage(named: "Tripa")!)
    } // func readMeatImages() -> Void
    
    func readJuicesFromDatabase() -> Void
    {
        let ref = Database.database().reference()
        ref.child("aguas").observeSingleEvent(of: .value)
        {
            (snapshot) in
            if let juice_objects = snapshot.value as? [String:String]
            {
                for (_,value) in juice_objects
                {
                    juice_name_array.append(value)
                }
            }
        }
    } // func readJuicesFromDatabase() -> Void
    
}
