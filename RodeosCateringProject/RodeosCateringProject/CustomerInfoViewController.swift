//
//  CustomerInfoViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/14/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit

var contact_info_together = String()

class CustomerInfoViewController: UIViewController
{
    
    @IBOutlet weak var first_name_text: UITextField!
    @IBOutlet weak var last_name_text: UITextField!
    @IBOutlet weak var phone_text: UITextField!
    @IBOutlet weak var address_text: UITextField!
    @IBOutlet weak var zip_code_text: UITextField!
    
    @IBOutlet weak var continue_checkout_button: UIButton!
    @IBOutlet weak var back_button: UIButton!
    
    
    @IBAction func back_to_juice_page(_ sender: Any)
    {
        performSegue(withIdentifier: "contact_info_to_juice_page", sender: self)
    }
    
    @IBAction func checkout_screen(_ sender: Any)
    {
        // if all info was filled
        // then we create a user aesthetic friendly string
        // so it can be displayed in the next screen
        if(all_info_filled())
        {
            create_contact_info_string()
            performSegue(withIdentifier: "confirm_order_screen", sender: self)
        }
        else
        {
            let title   = "Invalid Data"
            let message = "One or more fields are empty. Please fill out, before continuing"
            displayAlert(a_title: title, a_message: message)
        }
        
    }
    
    
    override func viewDidLoad()
    {
        continue_checkout_button.layer.cornerRadius = 15
        back_button.layer.cornerRadius = 15
        self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
    }
    
    // we want to create a contact info
    // string with new lines, and a nice way
    // of displaying the text when we go to
    // the checkout screen so the user can confirm their order
    func create_contact_info_string() -> Void
    {
        contact_info_together.removeAll()
        contact_info_together.append("PERSONAL INFO:")
        contact_info_together.append("\n")
        contact_info_together.append("-------------------------")
        contact_info_together.append("\n")
        if let first_name = first_name_text.text
        {
            contact_info_together.append("FIRST NAME: ")
            contact_info_together.append("\n - ")
            contact_info_together.append(first_name)
            contact_info_together.append("\n")
            contact_info_together.append("\n")
        }
        
        if let last_name = last_name_text.text
        {
            contact_info_together.append("LAST NAME: ")
            contact_info_together.append("\n - ")
            contact_info_together.append(last_name)
            contact_info_together.append("\n")
            contact_info_together.append("\n")
        }
        
        if let phone_number = phone_text.text
        {
            contact_info_together.append("PHONE NUMBER: ")
            contact_info_together.append("\n - ")
            contact_info_together.append(phone_number)
            contact_info_together.append("\n")
            contact_info_together.append("\n")
        }
        
        if let address = address_text.text
        {
            contact_info_together.append("DELIVERY ADDRESS: ")
            contact_info_together.append("\n - ")
            contact_info_together.append(address)
            contact_info_together.append("\n")
            contact_info_together.append("\n")
        }
        
        if let zip_code = zip_code_text.text
        {
            contact_info_together.append("ZIP CODE: ")
            contact_info_together.append("\n - ")
            contact_info_together.append(zip_code)
            contact_info_together.append("\n")
            contact_info_together.append("\n")
        }
        contact_info_together.append("\n")
    } // func create_contact_info_string() -> Void
    
    // a minor validation
    // requiring the user to enter in all the info
    // that is required
    func all_info_filled() -> Bool
    {
        var is_all_info_filled = true
        if let first_name = first_name_text.text
        {
            if (first_name.isEmpty)
            {
                is_all_info_filled = false
            }
        }
        
        if let last_name = last_name_text.text
        {
            if (last_name.isEmpty)
            {
                is_all_info_filled = false
            }
        }
        
        if let phone_number = phone_text.text
        {
            if (phone_number.isEmpty)
            {
                is_all_info_filled = false
            }
        }
        
        if let address = address_text.text
        {
            if (address.isEmpty)
            {
                is_all_info_filled = false
            }
        }
        
        if let zip_code = zip_code_text.text
        {
            if (zip_code.isEmpty)
            {
                is_all_info_filled = false
            }
            
            if let zip_code_converted_to_int = Int(zip_code)
            {
                let is_zip_code_valid_area =
                    isDeliveryAddressZipCodeInSupportedArea(zip_code: zip_code_converted_to_int)
                
                if(!is_zip_code_valid_area)
                {
                    // if zip code doesn't exist make an alert
                    // and do not allow the user to continue
                    is_all_info_filled = false
                    let title = "Invalid Zip Code"
                    let message = "Zip code of: " + zip_code + " not in San Diego area. Catering supported only in San Diego"
                    displayAlert(a_title: title, a_message: message)
                }
            }
        }
        
        return is_all_info_filled
    } //  all_info_filled
    
    func displayAlert(a_title:String, a_message:String) -> Void
    {
        
        let alert = UIAlertController(
            title: a_title,
            message: a_message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    // this allows us to determine if the zipcode is in a supported
    // deliverable area, that the caterer supports. Currently these
    // are all San Diego zipcodes pulled from the reference.
    // that is why we don't ask for State or City in the address
    // so when street address is entered whether the user enters
    // city and state it won't matter, because the caterer will just
    // check the given address. To attempt to verify this
    // we check the given zip code the user enters, and see if it is
    // on one of the San Diego Zip code lists found from the reference below
    func isDeliveryAddressZipCodeInSupportedArea(zip_code:Int) -> Bool
    {
        var is_in_the_area = false
        // reference for where zip codes of San Diego found
        // https://www.zillow.com/browse/homes/ca/san-diego-county/
        let supported_zip_codes =
            [
                 91902, 91901, 91905, 91908, 91906, 91910, 91911, 91914, 91913, 91916,
                 91915, 91917, 91932, 91931, 91934, 91941, 91935, 91942, 91945, 91950,
                 91948, 91962, 91963, 91978, 91977, 91980, 92004, 92003, 92008, 92007,
                 92010, 92009, 92011, 92018, 92014, 92020, 92019, 92021, 92024, 92026,
                 92025, 92028, 92027, 92029, 92036, 92033, 92037, 92040, 92052, 92054,
                 92057, 92056, 92059, 92058, 92061, 92060, 92065, 92064, 92067, 92066,
                 92069, 92071, 92070, 92078, 92075, 92081, 92083, 92082, 92084, 92086,
                 92091, 92093, 92092, 92101, 92096, 92103, 92102, 92105, 92104, 92107,
                 92106, 92109, 92108, 92111, 92110, 92113, 92112, 92115, 92114, 92117,
                 92116, 92119, 92118, 92121, 92120, 92123, 92122, 92126, 92124, 92128,
                 92127, 92130, 92129, 92132, 92131, 92136, 92135, 92138, 92140, 92139,
                 92145, 92155, 92154, 92159, 92158, 92171, 92173, 92177, 92178, 92182,
                 92672
            ]
        
        for zip in supported_zip_codes
        {
            if (zip_code == zip)
            {
                is_in_the_area = true
            }
        }
        return is_in_the_area
    }
}
