//
//  PriorRegisterViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/15/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PriorRegisterViewController: UIViewController
{
    
    @IBOutlet weak var sign_in_button: UIButton!
    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    @IBOutlet weak var activity_view: UIActivityIndicatorView!
    @IBOutlet weak var cancel_button: UIButton!
    
    
    @IBOutlet weak var sign_up_move_button: UIButton!
    
    @IBAction func cancel_button_pressed(_ sender: Any)
    {
        performSegue(withIdentifier: "login_to_home", sender: self)
    }
    
    @IBAction func sign_in_clicked(_ sender: Any)
    {
        handleSignIn() 
    }
    
    @IBAction func go_to_register_page(_ sender: Any)
    {
        performSegue(withIdentifier: "register_page", sender: self)
    }
    
    override func viewDidLoad()
    {
        activity_view.isHidden = true
        self.sign_in_button.setTitle("SIGN IN", for: .normal)
        self.activity_view.stopAnimating()
        self.signin_button_changes(enabled: true)
        sign_in_button.layer.cornerRadius = 15
        cancel_button.layer.cornerRadius = 15
        should_show_full_menu = true
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
    }
    
    func handleSignIn() -> Void
    {
        signin_button_changes(enabled:false)
        sign_in_button.setTitle("", for: .normal)
        activity_view.isHidden = false
        activity_view.startAnimating()
        
        if let user_email = email_text_field.text
        {
            if let user_password = password_text_field.text
            {
                Auth.auth().signIn(withEmail: user_email, password: user_password)
                {
                    user, error in
                    if ((error == nil) && user != nil)
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
                                withIdentifier: "login_to_slider",
                                sender: self)
                        }
                        else
                        {
                            self.performSegue(
                                withIdentifier: "login_to_contact_page",
                                sender: self)
                            
                        }
                    }
                    else
                    {
                        let title   = "LOGIN ERROR"
                        let message = "Unable to sign in"
                        self.displayAlert(a_title: title, a_message: message)
                        self.sign_in_button.setTitle("SIGN IN", for: .normal)
                        self.activity_view.isHidden = true
                        self.activity_view.stopAnimating()
                        self.signin_button_changes(enabled: true)
                    }
                }
            }
            else
            {
                let title   = "LOGIN ERROR"
                let message = "Unable to sign in"
                self.displayAlert(a_title: title, a_message: message)
                self.sign_in_button.setTitle("SIGN IN", for: .normal)
                self.activity_view.isHidden = true
                self.activity_view.stopAnimating()
                self.signin_button_changes(enabled: true)
            }
        }
        else
        {
            let title   = "LOGIN ERROR"
            let message = "Unable to sign in"
            self.displayAlert(a_title: title, a_message: message)
            self.sign_in_button.setTitle("SIGN IN", for: .normal)
            self.activity_view.isHidden = true
            self.activity_view.stopAnimating()
            self.signin_button_changes(enabled: true)
        }
    } // func handleSignIn() -> Void
    
    func displayAlert(a_title:String, a_message:String) -> Void
    {
        
        let alert = UIAlertController(
            title: a_title,
            message: a_message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func signin_button_changes(enabled:Bool) -> Void
    {
        if(enabled)
        {
            sign_in_button.alpha = 1.0
            sign_in_button.isEnabled = true
        }
            
        else
        {
            sign_in_button.alpha = 0.5
            sign_in_button.isEnabled = false
        }
    }
}
