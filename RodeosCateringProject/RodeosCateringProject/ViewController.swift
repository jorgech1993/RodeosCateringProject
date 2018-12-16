//
//  ViewController.swift
//  RodeosCateringProject
//
//  Created by Jorge Chavez on 12/8/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase


// hide keyboard when necessary
// and can be used in
// any view controller
// reference:
// https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift

// this allows the user
// when going from the menu
// screen to have the buttons and text
// fields disabled, so if a user
// just wants to see the menu
// they can just click menu and see
// the whole menu without having
// access to the checkout stuff
// just see what is available
var should_show_full_menu = true

var from_contact_us_page = false

var store_telephone_number = String()
extension UIViewController
{
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class ViewController: UIViewController
{
    
    @IBOutlet weak var menu_btn: UIButton!
    @IBOutlet weak var place_order_btn: UIButton!
    @IBOutlet weak var contact_us_btn: UIButton!
    @IBOutlet weak var phone_number_for_store: UILabel!
    
    
    @IBAction func contact_us_button_pressed(_ sender: Any)
    {
        from_contact_us_page = true
        performSegue(withIdentifier: "login_page", sender: self)
    }
    
    @IBAction func menu_clicked(_ sender: Any)
    {
        should_show_full_menu = false
        performSegue(
            withIdentifier: "home_to_direct_menu",
            sender: self)
    }
    
    override func viewDidLoad()
    {
        from_contact_us_page = false
        if (FirebaseApp.app() == nil)
        {
            FirebaseApp.configure()
        }
        
        should_show_full_menu = true
        super.viewDidLoad()
        
        menu_btn.layer.cornerRadius = 15
        place_order_btn.layer.cornerRadius = 15
        contact_us_btn.layer.cornerRadius = 15
        
        if let phone_number = phone_number_for_store.text
        {
            store_telephone_number = phone_number
        }
        
        resetAllValues()
        readMeatDependencies()
        readJuiceDependencies()
    }
}

