//
//  CheckoutPageViewController.swift
//  RodeosCateringProject
//
//  Created by Omid Azodi on 12/14/18.
//  Copyright © 2018 Jorge Chavez. All rights reserved.
//

import UIKit
import MessageUI

class CheckoutPageViewController: UIViewController, MFMailComposeViewControllerDelegate
{
    @IBOutlet weak var text_view: UITextView!
    @IBOutlet weak var confirm_button: UIButton!
    @IBOutlet weak var back_button: UIButton!
    
    
    @IBAction func go_back_to_customer_page(_ sender: Any)
    {
        performSegue(withIdentifier: "order_info_page_to_customer_info", sender: self)
    }
    
    var m_total_amount = Float(0)
    var m_information_for_body = String()
    @IBAction func confirm_ordered_pressed(_ sender: Any)
    {
        // attempt to send email for the user
        // with the corresponding information
        // filled of their order info in the body
        // as well as the to recipient
        sendEmail()
    }
    
    override func viewDidLoad()
    {
        confirm_button.layer.cornerRadius = 15
        back_button.layer.cornerRadius = 15
        let service_included_string = createServiceIncludedString()
        let additional_included_string = createAdditionalsIncludedString()
        let pricing_info_string = createPricingString()
        
        let total_info =
            contact_info_together +
            meats_ordered_string  +
            juice_order_string    +
            service_included_string +
            additional_included_string +
            pricing_info_string
        
        // used for body of email
        m_information_for_body = total_info
        
        // Custom color
        let whiteColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        // create the attributed colour
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : whiteColor];
        
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: total_info, attributes: attributedStringColor)
        
        
        // we want to make the the headers black
        // so it is more aesthetic to the user
        attributedString.setColorForText(textForAttribute: "PERSONAL INFO:", withColor: UIColor.black)
        
        attributedString.setColorForText(textForAttribute: "JUICES ORDERED:", withColor: UIColor.black)
        
        attributedString.setColorForText(textForAttribute: "MEATS ORDERED:", withColor: UIColor.black)
        
        attributedString.setColorForText(textForAttribute: "SERVICE INCLUDED:", withColor: UIColor.black)

        attributedString.setColorForText(textForAttribute: "PRICING:", withColor: UIColor.black)
        
        attributedString.setColorForText(textForAttribute: "ADDITIONALS INCLUDED:", withColor: UIColor.black)
        
        text_view.attributedText = attributedString

        super.viewDidLoad()
    }
    
    // this creates a list of things
    // included in the catering package
    // for the services that it includes
    // this is not editable by the user
    // and no substitutions can be made
    // meats & juices are the only things the user
    // is able to choose for the catering service
    // the rest are included, this is currently
    // going to have the items listed in their
    // 'Service Include' menu page
    func createServiceIncludedString() -> String
    {
        var service_included = "SERVICE INCLUDED:"
        service_included.append("\n")
        service_included.append("-------------------------")
        service_included.append("\n")
        service_included.append("  - Rice")
        service_included.append("\n")
        service_included.append("  - Beans")
        service_included.append("\n")
        service_included.append("  - Guacamole")
        service_included.append("\n")
        service_included.append("  - Nopales Salad")
        service_included.append("\n")
        service_included.append("  - Salsas")
        service_included.append("\n")
        service_included.append("  - Cheese")
        service_included.append("\n")
        service_included.append("  - Onions")
        service_included.append("\n")
        service_included.append("  - Cilantro")
        service_included.append("\n")
        service_included.append("  - Lemons")
        service_included.append("\n")
        service_included.append("  - Radishes")
        service_included.append("\n")
        service_included.append("  - Chiles")
        service_included.append("\n")
        service_included.append("  - Tortilla Chips")
        service_included.append("\n")
        service_included.append("  - Grilled Green Onions")
        service_included.append("\n")
        service_included.append("  - Grilled Chiles")
        service_included.append("\n")
        service_included.append("\n")
        
        return service_included
    }
    
    // function to create the page listed
    // on the menu 'Everything Included'
    // which is essentially utensils
    // and disposables
    func createAdditionalsIncludedString() -> String
    {
        var additional_info = "ADDITIONALS INCLUDED:"
        additional_info.append("\n")
        additional_info.append("-------------------------")
        additional_info.append("\n")
        additional_info.append("  - Plates")
        additional_info.append("\n")
        additional_info.append("  - Cups")
        additional_info.append("\n")
        additional_info.append("  - Spoons")
        additional_info.append("\n")
        additional_info.append("  - Forks")
        additional_info.append("\n")
        additional_info.append("  - Napkins")
        additional_info.append("\n")
        additional_info.append("\n")
        
        return additional_info
    }
    
    // function to have the pricing info
    // and create a string so it can be displayed on the
    // text view
    func createPricingString() -> String
    {
        // delivery_fee is a flat $50.00
        // from the caterer, they only deliver
        // to San Diego region, which is why
        // on the previous page CONTACT INFO
        // page we have a check to ensure
        // the zipcode of the delivery address is
        // within the San Diego Region
        let delivery_fee = "50.00"
        
        // the catering total is a
        // per person based fee
        // which is $8.50 per guest
        let per_guest_fee = "8.50"
        
        // tax is a flat sales tax of
        // the average San Diego region
        // which is currently 8%
        let tax_rate = "8.0"
        var total_amount = Float(0)
        var tax_amount_on_raw_total = Float(0)
        
        if let tax_rate_float = Float(tax_rate)
        {
            if let per_guest_fee_float = Float(per_guest_fee)
            {
                if let delivery_fee_float = Float(delivery_fee)
                {
                    let tax_converted = (tax_rate_float/100.0)
                    var raw_total =
                        (per_guest_fee_float * Float(total_number_of_guests_being_served))
                    
                    raw_total  = raw_total + delivery_fee_float
                    
                    tax_amount_on_raw_total =
                        (raw_total * tax_converted)
                    
                    tax_amount_on_raw_total.round()
                    
                    total_amount = tax_amount_on_raw_total + raw_total
                    total_amount.round()
                }
            }
        }
        
        var pricing_info = "PRICING:"
        pricing_info.append("\n")
        pricing_info.append("-------------------------")
        pricing_info.append("\n")
        pricing_info.append("DELIVERY FEE: ")
        pricing_info.append("$")
        pricing_info.append(delivery_fee)
        pricing_info.append("\n")
        pricing_info.append("CATERING FEE: ")
        pricing_info.append(String(total_number_of_guests_being_served))
        pricing_info.append(" guests")
        pricing_info.append(" x ")
        pricing_info.append("$")
        pricing_info.append(per_guest_fee)
        pricing_info.append("\n")
        pricing_info.append("TOTAL TAXES: ")
        pricing_info.append("$")
        pricing_info.append(String(tax_amount_on_raw_total))
        pricing_info.append("\n")
        pricing_info.append("\n")
        pricing_info.append("TOTAL: ")
        pricing_info.append("$")
        pricing_info.append(String(total_amount))
        m_total_amount = total_amount
 
        return pricing_info
    }
    
    func sendEmail()
    {
        // reference to send email:
        // https://www.hackingwithswift.com/example-code/uikit/how-to-send-an-email
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            // the set to receipient
            // is always this email
            // since this is the owners email
           mail.setSubject("ORDER CONFIRMATION RODEO'S CATERING")
            mail.setToRecipients(["rodeoscatering2018@gmail.com"])
            mail.setMessageBody( m_information_for_body , isHTML: false)
            self.present(mail, animated: true)
        }
        else
        {
            // for simulators is one case
            // where this will fail
            // so we display a popup telling the
            // user to call the store
            // and have the phone number available
            // on the alert dialog
            // this can also fail if the user
            // on the device doesn't have their email setup
            // or iCloud related
            // the user can still view the ORDER INFO PAGE
            // and let the caterer know their exact order
            // and the price that was listed, and has easy access
            // via phone
            let title = "Order Failed"
            var message = "Your order has failed to go through via email. "
            message.append("\n")
            message.append("Please call the store: ")
            message.append(store_telephone_number)
            displayAlert(a_title: title, a_message: message)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        let title   = "Confirmation Order Status"
        var message = ""
        switch result
        {
            case MFMailComposeResult.failed:
                do
                {
                    message = "Your order has failed to go through via email. "
                    message.append("\n")
                    message.append("Please call the store: ")
                    message.append(store_telephone_number)
                }
            case MFMailComposeResult.cancelled:
                do
                {
                    message = "Failed to send order. Email was cancelled"
                }
            case MFMailComposeResult.sent:
                do
                {
                    message = "Succesfully sent order. Check email for a copy."
                    performSegue(withIdentifier: "order_info_back_to_home_page", sender: self)
                }
            default:
                do
                {
                    message = "Order has failed to go through."
                    message.append("\n")
                    message.append("Please call the store: ")
                    message.append(store_telephone_number)
                    break
                }
        } //  switch result
        self.displayAlert(a_title:title, a_message:message)
        controller.dismiss(animated: true)
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
