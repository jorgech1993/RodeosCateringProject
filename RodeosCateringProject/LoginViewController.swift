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
import FirebaseDatabase


class LoginViewController: UIViewController
{
    @IBOutlet weak var user_name_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var continue_to_sign_up_button: UIButton!
    
    @IBOutlet weak var activity_view: UIActivityIndicatorView!
    
    
    var register_view:UIActivityIndicatorView!
    
    
    @IBAction func back_to_login_screen(_ sender: Any)
    {
        performSegue(withIdentifier: "register_to_login", sender: self)
    }
    
    
    @IBAction func sign_up_clicked(_ sender: Any)
    {
        handleSignUp()
    }
    
    
    override func viewDidLoad()
    {
        self.hideKeyboardWhenTappedAround()
        // make button rounded
        continue_to_sign_up_button.layer.cornerRadius = 15
        activity_view.isHidden = true
        self.continue_to_sign_up_button.setTitle("CONTINUE", for: .normal)
        self.activity_view.stopAnimating()
        self.continue_button_changes(enabled: true)
        should_show_full_menu = true
        super.viewDidLoad()
    }
    
    
    func handleSignUp() -> Void
    {
        guard let email = email_text_field.text
            else {
                activity_view.isHidden = true
                activity_view.stopAnimating()
                let title   = "REGISTER USER ERROR"
                let message = "Unable to register new user"
                self.displayAlert(a_title: title, a_message: message)
                return
        }
        guard let pass = password_text_field.text
            else {
                activity_view.isHidden = true
                activity_view.stopAnimating()
                let title   = "REGISTER USER ERROR"
                let message = "Unable to register new user"
                self.displayAlert(a_title: title, a_message: message)
                return
        }
        guard let username = user_name_text_field.text
            else {
                activity_view.isHidden = true
                activity_view.stopAnimating()
                let title   = "REGISTER USER ERROR"
                let message = "Unable to register new user"
                self.displayAlert(a_title: title, a_message: message)
                return
        }
        
        continue_button_changes(enabled:false)
        
        continue_to_sign_up_button.setTitle("", for: .normal)
        activity_view.isHidden = false
        activity_view.startAnimating()
    
        
        Auth.auth().createUser(withEmail: email, password: pass)
        {
            user, error in
            if ( (error == nil) && (user != nil) )
            {
                // if we are not coming from the
                // contact us page, then we are logging in
                // to go to the slider page
                // and continue on with the menu
                // with the corresponding add to cart
                // functionalities, otherwise we are going
                // to the contact us page, which is essentially
                // the chat page
                if(!from_contact_us_page)
                {
                    self.performSegue(
                        withIdentifier: "register_to_slider",
                        sender: self)
                }
                else
                {
                    self.performSegue(
                        withIdentifier: "register_to_contact_page",
                        sender: self)
                }
                
                if let uid = Auth.auth().currentUser?.uid
                {
                    let db_ref = Database.database().reference()
                    let user_data: [String:Any] =
                    [
                        "email": email,
                        "uid": uid,
                        "username": username
                    ]
                    db_ref.child("Users").child(uid).setValue(user_data)
                }
            }
            else
            {
                let title   = "REGISTER USER ERROR"
                let message = "Unable to register new user"
                self.displayAlert(a_title: title, a_message: message)
                self.continue_to_sign_up_button.setTitle("CONTINUE", for: .normal)
                self.activity_view.isHidden = true
                self.activity_view.stopAnimating()
                self.continue_button_changes(enabled: true)
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
    
    func displayAlert(a_title:String, a_message:String) -> Void
    {
        
        let alert = UIAlertController(
            title: a_title,
            message: a_message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}
