//
//  LoginViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/8/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController
{
    @IBOutlet weak var user_name_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var continue_to_sign_up_button: UIButton!
    
    var register_view:UIActivityIndicatorView!
    
    
    @IBAction func sign_up_clicked(_ sender: Any)
    {
        handleSignUp()
    }
    
    
    override func viewDidLoad()
    {
        // make button rounded
        continue_to_sign_up_button.layer.cornerRadius = 15
        super.viewDidLoad()
    }
    
    
    func handleSignUp() -> Void
    {
        guard let email = email_text_field.text
            else {return}
        guard let pass = password_text_field.text
            else {return}
        guard let username = user_name_text_field.text
            else {return}
        
        continue_button_changes(enabled:false)
        
        continue_to_sign_up_button.setTitle("", for: .normal)
        
        //register_view.startAnimating()
    
        
        Auth.auth().createUser(withEmail: email, password: pass)
        {
            user, error in
            if error == nil && user != nil
            {
                print("User created")
            }
            else
            {
                print("Error creating user")
            }
        }
    }
    
    
    func continue_button_changes(enabled:Bool) -> Void
    {
        
        if(enabled)
        {
            continue_to_sign_up_button.alpha = 1.0
            continue_to_sign_up_button.isEnabled = true
        }
        
        else
        {
            continue_to_sign_up_button.alpha = 0.5
            continue_to_sign_up_button.isEnabled = false
        }
    }
    
}
