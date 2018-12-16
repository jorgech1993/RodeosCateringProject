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
var juice_images = [UIImage]()
var meat_number_per_order = [Int]()
var juice_number_per_order = [Int]()


// used to determine for the
// MeatTableViewController
// on how many meats the user is able
// to select we have this algorithm
// implemented below in determining
// how many meats a user is able select
var max_number_of_meats_to_select = 0


// max_number_of_juices_to_select is hardcoded to 2
// because this value is independent of
// number of guests being served
// unlike the meats where it depends
// on the number of guests being served
var max_number_of_juices_to_select = 2

// value that will be used to calculate
// the price in the receipt/confirmation
// order page, we are calculating per guest
// to be $8.50
var total_number_of_guests_being_served = 0

class PlaceOrderSliderViewController: UIViewController
{
    
    @IBOutlet weak var continue_button: UIButton!
    @IBOutlet weak var cancel_button: UIButton!
    
    @IBAction func go_back_to_home(_ sender: Any)
    {
        performSegue(withIdentifier: "continue_guest_to_home", sender: self)
    }
    
    @IBOutlet weak var number_of_guests_label: UILabel!
    
    @IBOutlet weak var guest_slider: UISlider!
    
    @IBAction func number_slider_changed(_ sender: Any)
    {
        number_of_guests_label.text =
            String(Int(guest_slider.value))
        
        total_number_of_guests_being_served =
            Int(guest_slider.value)
    }
    
    
    @IBAction func continue_to_meats_page(_ sender: Any)
    {
        determineMaxNumberOfMeats()
        performSegue(withIdentifier: "meats_table_view", sender:self)
    }
    
    override func viewDidLoad()
    {
        number_of_guests_label.text = "10"
        total_number_of_guests_being_served = 10
        guest_slider.value = Float(10)
        // we want the minimum number of available
        // guests to be catered for 10
        // and maximum number of catered guests
        // to 500.
        guest_slider.minimumValue = Float(10)
        guest_slider.maximumValue = Float(500)
        
        resetAllValues()
        readMeatDependencies()
        readJuiceDependencies()
        
        continue_button.layer.cornerRadius = 15
        cancel_button.layer.cornerRadius = 15
        
        super.viewDidLoad()
    }
    
    func determineMaxNumberOfMeats() -> Void
    {
        // between 10-50 customer can
        // choose between 2 meats
        let converted_slider_value_to_int = Int(guest_slider.value)
        if(converted_slider_value_to_int >= 10 &&
           converted_slider_value_to_int <= 50)
        {
            max_number_of_meats_to_select = 2
        }
        // between 51-100 customer can
        // choose between 3 meats
        else if(converted_slider_value_to_int >= 51 &&
                converted_slider_value_to_int <= 100)
        {
            max_number_of_meats_to_select = 3
        }
        // between 101-199 customer can
        // choose between 4 meats
        else if(converted_slider_value_to_int >= 101 &&
                converted_slider_value_to_int <= 199)
        {
            max_number_of_meats_to_select = 4
        }
        // between 200-299 customer can
        // choose between 5 meats
        else if(converted_slider_value_to_int >= 200 &&
                converted_slider_value_to_int <= 299)
        {
            max_number_of_meats_to_select = 5
        }
        // otherwise anything between
        // 300 - 500 people will be
        // 6 meats
        else
        {
            max_number_of_meats_to_select = 6
        }
    } // func determineMaxNumberOfMeats() -> Void
}


extension UIViewController
{
    func resetAllValues() -> Void
    {
        meat_name_array.removeAll()
        juice_name_array.removeAll()
        meat_images.removeAll()
        juice_images.removeAll()
        meat_number_per_order.removeAll()
        juice_number_per_order.removeAll()
        total_meats_selected  = 0
        total_juices_selected = 0
        max_number_of_meats_to_select = 0
    }
    
    func readMeatDependencies() -> Void
    {
        readMeatsFromDatabase()
        readMeatImages()
    }
    
    func readJuiceDependencies() -> Void
    {
        readJuicesFromDatabase()
        readJuiceImages()
    }
    
    
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
    
    func readJuiceImages() -> Void
    {
        juice_images.append(UIImage(named: "CucumberLime")!)
        juice_images.append(UIImage(named: "Horchata")!)
        juice_images.append(UIImage(named: "Jamaica")!)
        juice_images.append(UIImage(named: "Lemon")!)
        juice_images.append(UIImage(named: "Orange")!)
        juice_images.append(UIImage(named: "Pineapple")!)
        juice_images.append(UIImage(named: "Tamarindo")!)
        juice_images.append(UIImage(named: "Watermelon")!)
    } // func readJuiceImages() -> Void
    
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
                    juice_number_per_order.append(0)
                }
            }
        }
    } // func readJuicesFromDatabase() -> Void
    
    
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
                    meat_number_per_order.append(0)
                }
            }
        }
    }// end readMeatsFromDatabase
    
} // extension UIViewController
